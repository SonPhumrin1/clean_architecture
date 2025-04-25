// lib/core/utils/realm_config.dart
import 'package:clean_architecture/core/model/app_config_model.dart';
import 'package:clean_architecture/core/model/sync_queue_model.dart';
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

@riverpod
RealmConfig realmConfig(Ref ref) {
  final realmConfig = RealmConfig();
  ref.onDispose(() {
    realmConfig.close();
  });
  return realmConfig;
}
