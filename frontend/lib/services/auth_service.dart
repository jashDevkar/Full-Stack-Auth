import 'dart:convert';

import 'package:frontend/constants/contants.dart';
import 'package:frontend/constants/models/user_model.dart';
import 'package:http/http.dart' as http;

class AuthService {
  Future<void> signIn(
      {required String email, required String password}) async {}

  //sigup
  Future<http.Response> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    UserModel userModel = UserModel(
      name: name,
      email: email,
      password: password,
    );

    try {
      final http.Response res = await http.post(
        Uri.parse('${Constants.uri}/api/signup'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: userModel.toJson(),
      );
      return res;
    } catch (e) {
      throw Future.error(e.toString());
    }
  }
}
