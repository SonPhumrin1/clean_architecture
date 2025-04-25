// lib/core/utils/sync_service.dart
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

  SyncService({
    required RealmConfig realmConfig,
    required NetworkInfo networkInfo,
    required ApiService apiService,
  })  : _realmConfig = realmConfig,
        _networkInfo = networkInfo,
        _apiService = apiService {
    // Listen to connection changes and try to sync when back online
    _networkInfo.onConnectionChange.listen((isConnected) {
      if (isConnected) {
        syncPendingOperations();
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

    _realmConfig.realm.write(() {
      _realmConfig.realm.add(syncItem);
    });
  }

  Future<void> syncPendingOperations() async {
    if (!await _networkInfo.isConnected) {
      return;
    }

    final pendingItems = _realmConfig.realm
        .query<SyncQueueItem>('isSynced == false SORT(createdAt ASC)');

    for (final item in pendingItems) {
      try {
        await _processSyncItem(item);
        _realmConfig.realm.write(() {
          item.isSynced = true;
        });
      } catch (e) {
        Logs.e('Error syncing item: ${e.toString()}');
      }
    }
  }

  Future<void> _processSyncItem(SyncQueueItem item) async {
    final endpoint = _getEndpointForEntityType(item.entityType);

    switch (item.operationType) {
      case SyncOperation.create:
        if (item.payload == null) {
          throw SyncException(message: 'Create operation requires payload');
        }
        await _apiService.post(endpoint, data: jsonDecode(item.payload!));
        break;
      case SyncOperation.update:
        if (item.payload == null) {
          throw SyncException(message: 'Update operation requires payload');
        }
        await _apiService.put('$endpoint/${item.entityId}',
            data: jsonDecode(item.payload!));
        break;
      case SyncOperation.delete:
        await _apiService.delete('$endpoint/${item.entityId}');
        break;
    }
  }

  String _getEndpointForEntityType(String entityType) {
    switch (entityType) {
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
    final syncedItems =
        _realmConfig.realm.query<SyncQueueItem>('isSynced == true');
    _realmConfig.realm.write(() {
      _realmConfig.realm.deleteMany(syncedItems);
    });
  }
}

@riverpod
SyncService syncService(Ref ref) {
  final realmConfig = ref.watch(realmConfigProvider);
  final networkInfo = ref.watch(networkInfoProvider);
  final apiService = ref.watch(apiServiceProvider);

  return SyncService(
    realmConfig: realmConfig,
    networkInfo: networkInfo,
    apiService: apiService,
  );
}
