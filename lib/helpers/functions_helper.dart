import 'package:shared_preferences/shared_preferences.dart';

storeData(
  String key,
  value,
) async {
  SharedPreferences storage = await SharedPreferences.getInstance();
  await storage.setString(key, value);
}

setStringToPrefs(String key, String value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(key, value);
}

Future<String?> getStringFromPrefs(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? value = prefs.getString(key);
  return value;
}
