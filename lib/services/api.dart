import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:io';
import 'dart:convert';
import 'dart:async';

import '../helpers/consts.dart';

class Api {
  Future<Response> get(String url, Map body) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // String? localCode = prefs.getString('langCode');

    if (kDebugMode) {
      print("GET URL: $baseUrl$url");
    }
    Response response = await http.get(
      Uri.parse(
          // url.contains("auth")
          //   ? '$baseUrl$url?lang=$localCode'
          //   :
          '$baseUrl$url'),
      headers: {
        HttpHeaders.authorizationHeader: "Bearer ${prefs.getString("token")}",
        'Accept': "application/json",
        'content-type': 'application/json',
      },
    );

    if (kDebugMode) {
      print("GET RES : ${response.statusCode}");
      print("GET RES : ${response.body}");
    }

    return response;
  }

  Future<Response> post(
    String url,
    Map body,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // String? localCode = prefs.getString('langCode');

    if (kDebugMode) {
      print("POST URL: $baseUrl$url");
      print("POST BODY : '$body");
    }
    Response response = await http
        .post(Uri.parse('$baseUrl$url'), body: jsonEncode(body), headers: {
      HttpHeaders.authorizationHeader: "Bearer ${prefs.getString("token")}",
      'Accept': "application/json",
      'content-type': 'application/json',
    });

    if (kDebugMode) {
      print("POST RES : ${response.statusCode}");
      print("POST RES : ${response.body}");
    }
    return response;
  }

  Future<Response> put(
    String url,
    Map body,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // String? localCode = prefs.getString('langCode');

    if (kDebugMode) {
      print("PUT URL: $baseUrl$url");
    }
    Response response = await http
        .put(Uri.parse('$baseUrl$url'), body: jsonEncode(body), headers: {
      HttpHeaders.authorizationHeader: "Bearer ${prefs.getString("token")}",
      'Accept': "application/json",
      'content-type': 'application/json',
    });

    if (kDebugMode) {
      print("PUT RES : ${response.statusCode}");
      print("PUT RES : ${response.body}}");
    }
    return response;
  }

  Future<Response> delete(
    String url,
    Map body,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // String? localCode = prefs.getString('langCode');

    if (kDebugMode) {
      print("DELETE URL: $baseUrl$url");
    }
    Response response = await http
        .delete(Uri.parse('$baseUrl$url'), body: jsonEncode(body), headers: {
      HttpHeaders.authorizationHeader: "Bearer ${prefs.getString("token")}",
      'Accept': "application/json",
      'content-type': 'application/json',
    });

    if (kDebugMode) {
      print("DELETE RES : ${response.statusCode}");
      print("DELETE RES : ${response.body}}");
    }
    return response;
  }

  Future<Response> upload(File file) async {
    var postUri = Uri.parse("$baseUrl/user/uploader");

    http.MultipartRequest request = http.MultipartRequest(
      "POST",
      postUri,
    );

    http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
      'file',
      file.path,
    );

    request.headers['Accept'] = 'application/json';
    request.headers['content-type'] = 'application/json';
    request.headers['mostanad-auth-key'] = '0';
    request.files.add(multipartFile);

    StreamedResponse response = await request.send();

    return Response.fromStream(response);
  }
}
