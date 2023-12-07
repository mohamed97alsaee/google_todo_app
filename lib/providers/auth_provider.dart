import 'dart:async';

import 'package:flutter/foundation.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/functions_helper.dart';
import '../services/api.dart';

enum Status { uninitialized, authenticated, authenticating, unauthenticated }

class AuthProvider with ChangeNotifier {
  final Api _api = Api();

  Status _status = Status.uninitialized;
  late String _token;

  Status get status => _status;
  String get token => _token;

  bool isLoading = false;

  initAuthProvider() async {
    String? token = await getToken();
    if (token != null) {
      _token = token;

      _status = Status.authenticated;
    } else {
      _status = Status.unauthenticated;
    }
    notifyListeners();
  }

  Future<List> register(Map body) async {
    final response = await _api.post('/api/v1/register', body);

    Map apiResponse = json.decode(response.body);

    if (response.statusCode == 200) {
      if (kDebugMode) {
        print('RESPONSE BODY SUCESS : ${response.body}');
      }

      _status = Status.authenticated;
      _token = apiResponse['access_token'];
      await storeData('token', apiResponse['access_token']);
      notifyListeners();

      return [true, apiResponse['message']];
    } else {
      return [false, apiResponse['errors'][0]];
    }
  }

  Future<List> login(Map<String, String> body) async {
    _status = Status.authenticating;
    notifyListeners();

    if (kDebugMode) {
      print("LOGINBODY: $body");
    }

    final response = await _api.post('/api/v1/login', body);
    Map apiResponse = json.decode(response.body);

    if (response.statusCode == 200) {
      if (kDebugMode) {
        print("LOGIN SUCCESS RESPONSE: ${response.body}");
      }
      _status = Status.authenticated;
      _token = apiResponse['access_token'];
      await storeData('token', apiResponse['access_token']);
      notifyListeners();
      initAuthProvider();

      return [true, apiResponse['message']];
    } else {
      if (kDebugMode) {
        print("LOGIN FAILED RESPONSE: ${response.body}");
      }
    }

    if (response.statusCode == 401) {
      _status = Status.unauthenticated;

      notifyListeners();
      return [false, apiResponse['errors'][0]];
    }

    _status = Status.unauthenticated;

    notifyListeners();
    return [false, apiResponse['errors'][0]];
  }




  Future<bool> logOut() async {
    _status = Status.unauthenticated;
    SharedPreferences storage = await SharedPreferences.getInstance();
    storage.clear();
    return true;
  }

  Future<String?> getToken() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    String? token = storage.getString('token');
    return token;
  }

  setToken(String token) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    storage.setString('token', token);
  }
}
