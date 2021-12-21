import 'package:shared_preferences/shared_preferences.dart';
import 'package:template_app/config/config.dart';
import '../extension/extension.dart';

class SharedPrefService {
  static final SharedPrefService _sharedPrefService =
      SharedPrefService._internal();
  SharedPrefService._internal();
  factory SharedPrefService() => _sharedPrefService;

  Future<String?> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(Config.tokenKey);
    if (token.isNullOrEmpty()) {
      return null;
    }
    return token;
  }

  Future<void> setToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(Config.tokenKey, token);
  }
}
