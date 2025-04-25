import 'package:realm/realm.dart';

part 'sync_queue_model.realm.dart';

enum SyncOperation { create, update, delete }

@RealmModel()
class _SyncQueueItem {
  @PrimaryKey()
  late ObjectId id;
  late String entityType; // 'post', 'user', 'book'
  late String entityId;
  late String operation; // 'create', 'update', 'delete'
  late String? payload; // JSON string for create/update
  late DateTime createdAt;
  late bool isSynced;
}

extension SyncQueueItemExtension on SyncQueueItem {
  SyncOperation get operationType {
    switch (operation) {
      case 'create':
        return SyncOperation.create;
      case 'update':
        return SyncOperation.update;
      case 'delete':
        return SyncOperation.delete;
      default:
        throw Exception('Invalid operation type: $operation');
    }
  }
}
