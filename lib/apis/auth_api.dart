import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService extends ChangeNotifier {
  final _baseUrl = "identitytoolkit.googleapis.com";
  final String _firebaseToken = "AIzaSyCrded0oicDOmspuP9-n0E-qdfXvC5tVKk";
  final storage = FlutterSecureStorage();
  Future<String?> createUser(String email, String password) async {
    final data = {
      "email": email,
      "password": password,
    };
    var url = Uri.https(_baseUrl, "/v1/accounts:signUp", {
      "key": _firebaseToken,
    });
    var response = await http.post(url, body: data);
    final Map<String, dynamic> decodeResp = jsonDecode(response.body);
    print(decodeResp);
    if (decodeResp.containsKey("idToken")) {
      // return decodeResp["idToken"];
      await storage.write(key: "idToken", value: decodeResp["idToken"]);
      return null;
    } else {
      print(decodeResp["error"]["message"]);
      return decodeResp["error"]["message"];
    }
    // var data = jsonDecode(response.body);
  }

  Future<String?> authUser(String email, String password) async {
    final data = {
      "email": email,
      "password": password,
    };
    var url = Uri.https(_baseUrl, "/v1/accounts:signInWithPassword", {
      "key": _firebaseToken,
    });
    var response = await http.post(url, body: data);
    final Map<String, dynamic> decodeResp = jsonDecode(response.body);
    print(decodeResp);
    if (decodeResp.containsKey("idToken")) {
      // return decodeResp["idToken"];
      await storage.write(key: "idToken", value: decodeResp["idToken"]);
      return null;
    } else {
      print(decodeResp["error"]["message"]);
      return decodeResp["error"]["message"];
    }
    // var data = jsonDecode(response.body);
  }

  Future logout() async {
    await storage.delete(key: "idToken");
  }

  Future<String> readToken() async {
    return await storage.read(key: "idToken") ?? '';
  }
}
