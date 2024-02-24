import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  LocalStorage._();

  static SharedPreferences? _prefs;
  static int? lastPage;
  static initialize() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static int? getLastPage() {
    if (_prefs == null) throw Exception('LocalStorage not initialized');
    lastPage = _prefs!.getInt('lastPage');
    return lastPage;
  }

  static void setLastPage(int value) {
    if (_prefs == null) throw Exception('LocalStorage not initialized');
    lastPage = value;
    _prefs!.setInt('lastPage', value);
  }
}
