import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveTokenToLocalStorage(String token) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('jwt_token', token);
}

// Function to retrieve JWT token from local storage
Future<String?> getTokenFromLocalStorage() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('jwt_token');
}

Future<void> deleteTokenFromLocalStorage() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('jwt_token');
}

Future<void> savePageInfoToLocalStorage(String page) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('current_page', page);
}

Future<String?> getPageInfoFromLocalStorage() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('current_page');
}

Future<void> deletePageInfoFromLocalStorage() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('current_page');
}
