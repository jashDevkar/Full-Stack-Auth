import 'dart:convert';

import 'package:frontend/constants/contants.dart';
import 'package:http/http.dart' as http;

class AuthService {
  Future<http.Response> signIn(
      {required String email, required String password}) async {
    try {
      final http.Response res = await http.post(
        Uri.parse('${Constants.uri}/api/signin'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({"email": email, "password": password}),
      );
      return res;
    } catch (e) {
      throw Future.error(e);
    }
  }

  //sigup
  Future<http.Response> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final http.Response res = await http.post(
        Uri.parse('${Constants.uri}/api/signup'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({"name": name, "email": email, "password": password}),
      );
      return res;
    } catch (e) {
      throw Future.error(e.toString());
    }
  }

  Future<http.Response> validateToken({
    required String token,
  }) async {
    try {
      final http.Response res = await http.post(
        Uri.parse('${Constants.uri}/tokenIsValid'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'auth-token': token
        },
      );
      return res;
    } catch (e) {
      throw Future.error(e.toString());
    }
  }


  Future<http.Response> getUserData({
    required String token,
  }) async {
    try {
      final http.Response res = await http.get(
        Uri.parse('${Constants.uri}/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'auth-token': token
        },
      );
      return res;
    } catch (e) {
      throw Future.error(e.toString());
    }
  }
}
