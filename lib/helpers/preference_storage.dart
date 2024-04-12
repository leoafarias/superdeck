import 'package:shared_preferences/shared_preferences.dart';

class PreferenceStorage {
  PreferenceStorage._privateConstructor();
  static final PreferenceStorage _instance =
      PreferenceStorage._privateConstructor();

  static PreferenceStorage get instance => _instance;

  static late SharedPreferences _prefs;

  static Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
  }

  int? get lastPage => _prefs.getInt('lastPage');

  Future<void> setLastPage(int value) async {
    await _prefs.setInt('lastPage', value);
  }
}
