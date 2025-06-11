import 'package:shared_preferences/shared_preferences.dart';

class SharePrefsService {
  final SharedPreferences _prefs;
  static const String _keyToken = 'auth_token';
  static const String _keySaveSession = 'save_session';

  SharePrefsService({required SharedPreferences prefs}) : _prefs = prefs;

  Future<void> saveAuthToken(String token) async {
    await _prefs.setString(_keyToken, token);
  }

  Future<void> saveSession(bool isSaveSession) async {
    await _prefs.setBool(_keySaveSession, isSaveSession);
  }

  String? getAuthToken() {
    return _prefs.getString(_keyToken);
  }

  bool? getSaveSession() {
    return _prefs.getBool(_keySaveSession);
  }

  Future<void> clear() async {
    await _prefs.clear();
  }
}
