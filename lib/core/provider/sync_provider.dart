import 'dart:async';
import 'dart:convert';
import 'package:clean_architecture/core/api/api_service.dart';
import 'package:clean_architecture/core/error/exception.dart';
import 'package:clean_architecture/core/local/realm_config.dart';
import 'package:clean_architecture/core/model/sync_queue_model.dart';
import 'package:clean_architecture/core/network/network_info.dart';
import 'package:clean_architecture/core/util/logger.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:realm/realm.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sync_provider.g.dart';

class SyncService {
  final RealmConfig _realmConfig;
  final NetworkInfo _networkInfo;
  final ApiService _apiService;
  bool _isSyncing = false;

  SyncService({
    required RealmConfig realmConfig,
    required NetworkInfo networkInfo,
    required ApiService apiService,
  })  : _realmConfig = realmConfig,
        _networkInfo = networkInfo,
        _apiService = apiService {
    Logs.i('SyncService created. Setting up network listener.');

    _networkInfo.isConnected.then((value) async {
      if (value = true) {
        await syncPendingOperations();
      }
    });
  }

  void addToSyncQueue({
    required String entityType,
    required String entityId,
    required SyncOperation operation,
    String? payload,
  }) {
    final syncItem = SyncQueueItem(
      ObjectId(),
      entityType,
      entityId,
      operation.toString().split('.').last,
      DateTime.now(),
      false,
      payload: payload,
    );

    Logs.i(
        'Adding to sync queue: ${syncItem.entityType} - ${syncItem.entityId} - Op: ${syncItem.operationType}');
    _realmConfig.realm.write(() {
      _realmConfig.realm.add(syncItem);
    });

    syncPendingOperations();
  }

  Future<void> syncPendingOperations() async {
    if (_isSyncing) {
      Logs.w('Sync already in progress. Skipping debounced trigger.');
      return;
    }
    if (!await _networkInfo.isConnected) {
      Logs.i('Sync skipped (debounced): No network connection.');
      return;
    }

    _isSyncing = true;
    Logs.i('Starting sync process (debounced)...');

    try {
      final pendingItems = _realmConfig.realm
          .query<SyncQueueItem>('isSynced == false SORT(createdAt ASC)')
          .toList();

      if (pendingItems.isEmpty) {
        Logs.i('No pending items to sync (debounced).');
        _isSyncing = false;
        return;
      }

      Logs.i('Found ${pendingItems.length} items to sync (debounced).');

      for (final item in pendingItems) {
        Logs.e(item.toEJson());
        if (!await _networkInfo.isConnected) {
          Logs.w(
              'Network lost during sync batch processing. Stopping (debounced).');
          break;
        }

        Logs.i(
            'Processing item (debounced): ${item.id} - ${item.entityType} - ${item.entityId} - Op: ${item.operationType}');
        try {
          await _processSyncItem(item);

          final freshItem = _realmConfig.realm.find<SyncQueueItem>(item.id);
          if (freshItem != null && !freshItem.isSynced) {
            if (!_realmConfig.realm.isClosed) {
              _realmConfig.realm.write(() {
                final currentItem =
                    _realmConfig.realm.find<SyncQueueItem>(item.id);
                if (currentItem != null && !currentItem.isSynced) {
                  currentItem.isSynced = true;
                  Logs.i(
                      'Marked item as synced (debounced): ${currentItem.id} - ${currentItem.entityId}');
                } else {
                  Logs.w(
                      'Item ${item.id} - ${item.entityId} already synced or deleted before marking (debounced).');
                }
              });
            } else {
              Logs.w('Realm closed before marking item ${item.id} as synced.');
            }
          } else if (freshItem == null) {
            Logs.w(
                'Item ${item.id} - ${item.entityId} was deleted during sync processing (debounced).');
          } else {
            Logs.w(
                'Item ${item.id} - ${item.entityId} was already marked as synced (debounced).');
          }
        } catch (e) {
          Logs.e(
              'Error syncing item ${item.id} - ${item.entityId} (debounced): ${e.toString()}. Will retry later.');
        }
      }
      Logs.i('Sync finished processing batch (debounced).');
    } catch (e) {
      Logs.e(
          'Error querying or starting sync batch (debounced): ${e.toString()}');
    } finally {
      _isSyncing = false;

      Logs.i('Sync process ended (debounced).');
    }
  }

  Future<void> _processSyncItem(SyncQueueItem item) async {
    final endpoint = _getEndpointForEntityType(item.entityType);

    SyncOperation operation;
    try {
      operation = SyncOperation.values.firstWhere(
          (e) => e == item.operationType,
          orElse: () => throw SyncException(
              message:
                  'Unknown operation type in queue: ${item.operationType}'));
    } catch (e) {
      Logs.e(
          'Failed to parse operation type "${item.operationType}" for item ${item.id}. Error: $e');
      rethrow;
    }

    switch (operation) {
      case SyncOperation.create:
        if (item.payload == null) {
          throw SyncException(
              message: 'Create operation requires payload for item ${item.id}');
        }
        Logs.i('Executing CREATE for ${item.entityId} at endpoint $endpoint');

        await _apiService.post(endpoint, data: jsonDecode(item.payload!));
        break;
      case SyncOperation.update:
        if (item.payload == null) {
          throw SyncException(
              message: 'Update operation requires payload for item ${item.id}');
        }
        Logs.i(
            'Executing UPDATE for ${item.entityId} at endpoint $endpoint/${item.entityId}');

        await _apiService.put('$endpoint/${item.entityId}',
            data: jsonDecode(item.payload!));
        break;
      case SyncOperation.delete:
        Logs.i(
            'Executing DELETE for ${item.entityId} at endpoint $endpoint/${item.entityId}');

        await _apiService.delete('$endpoint/${item.entityId}');
        break;
    }
    Logs.i(
        'Successfully processed API call for item ${item.id} - ${item.entityId}');
  }

  String _getEndpointForEntityType(String entityType) {
    switch (entityType.toLowerCase()) {
      case 'post':
        return 'posts';
      case 'user':
        return 'users';
      case 'book':
        return 'books';
      default:
        throw SyncException(message: 'Unknown entity type: $entityType');
    }
  }

  void removeSuccessfulSyncItems() {
    Logs.i('Removing successfully synced items...');
    final syncedItems =
        _realmConfig.realm.query<SyncQueueItem>('isSynced == true');
    _realmConfig.realm.write(() {
      Logs.i('Deleting ${syncedItems.length} synced items.');
      _realmConfig.realm.deleteMany(syncedItems);
    });
  }
}

@riverpod
SyncService syncService(Ref ref) {
  final realmConfig = ref.watch(realmConfigProvider);
  final networkInfo = ref.watch(networkInfoProvider);
  final apiService = ref.watch(apiServiceProvider);

  final service = SyncService(
    realmConfig: realmConfig,
    networkInfo: networkInfo,
    apiService: apiService,
  );

  return service;
}
