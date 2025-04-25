import 'package:realm/realm.dart';

part 'app_config_model.realm.dart';

@RealmModel()
class _AppConfig {
  @PrimaryKey()
  late int id;
  bool isFirstTime = true;
  late bool isDarkMode;
  late String? accessToken;
  late String? refreshToken;
}
