// lib/core/utils/realm_config.dart
import 'package:clean_architecture/core/model/app_config_model.dart';
import 'package:clean_architecture/core/model/sync_queue_model.dart';
import 'package:clean_architecture/core/util/logger.dart';
import 'package:clean_architecture/feature/posts/data/models/post_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:realm/realm.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'realm_config.g.dart';

class RealmConfig {
  late final Realm realm;

  RealmConfig() {
    final config = Configuration.local(
      [PostModel.schema, SyncQueueItem.schema, AppConfig.schema],
      schemaVersion: 1,
      shouldDeleteIfMigrationNeeded: false,
    );
    realm = Realm(config);
  }

  void close() {
    realm.close();
  }
}

// --- Add keepAlive: true ---
@Riverpod(keepAlive: true)
RealmConfig realmConfig(Ref ref) {
  // Use generated Ref type
  final realmConfigInstance = RealmConfig();
  ref.onDispose(() {
    Logs.d("Disposing realmConfigProvider, closing Realm...");
    realmConfigInstance.close();
  });
  Logs.d("realmConfigProvider initialized.");
  return realmConfigInstance;
}
