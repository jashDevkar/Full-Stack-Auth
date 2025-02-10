import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/models/user_model.dart';
import 'package:frontend/services/auth_service.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  late UserModel _userModel = UserModel();
  final Box _box = Hive.box('auth-token');
  final AuthService authService = AuthService();

  UserModel get userModel => _userModel;

  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>(
      (event, emit) => emit(AuthLoading()),
    );
    on<OnAuthSignUp>(onSignUpButtonPress);
    on<OnAuthSignIn>(onSignInButtonPress);
    on<IsUserLogedIn>(getAllUserData);
    on<SignOut>(signOutUser);
  }

  // void onSignUpButtonPress(OnAuthSignUp event, Emitter emit) async {
  //   final http.Response response = await authService.signUp(
  //     name: event.name,
  //     email: event.email,
  //     password: event.password,
  //   );
  //   if (response.statusCode == 200) {
  //     emit(AuthSuccess());
  //   } else if (response.statusCode == 500) {
  //     final responseBody = jsonDecode(response.body);
  //     emit(AuthFailure(message: responseBody['error']));
  //   } else {
  //     final responseBody = jsonDecode(response.body);
  //     emit(AuthFailure(message: responseBody['mssg']));
  //   }
  // }

  // void onSignInButtonPress(OnAuthSignIn event, Emitter emit) async {
  //   try {
  //     final http.Response response = await authService.signIn(
  //       email: event.email,
  //       password: event.password,
  //     );
  //     if (response.statusCode == 200) {
  //       final responseBody = jsonDecode(response.body);
  //       _userModel.copyWith(
  //           name: responseBody['name'],
  //           email: responseBody['email'],
  //           password: responseBody['passsword'],
  //           id: responseBody['_id'],
  //           token: responseBody['token']);

  //       await _box.put('Token', _userModel.toJson());
  //       print(responseBody.runtimeType);

  //       emit(AuthSuccess());
  //     } else if (response.statusCode == 500) {
  //       final responseBody = jsonDecode(response.body);
  //       emit(AuthFailure(message: responseBody['error']));
  //     } else {
  //       final message = jsonDecode(response.body);
  //       emit(AuthFailure(message: message['mssg']));
  //     }
  //   } catch (e) {
  //     emit(AuthFailure(message: e.toString()));
  //   }
  // }

  ///get all user data
  // void getAllUserData(IsUserLogedIn event, Emitter emit) {
  //   final String? data = _box.get('Token');
  //   if (data == null) {
  //     _userModel = UserModel();
  //     emit(AuthSuccess());
  //   } else {
  //     _userModel = UserModel.fromJson(data);
  //     emit(AuthSuccess());
  //   }
  // }

  // void signOutUser(SignOut event, Emitter emit) {
  //   _box.delete('Token');
  //   _userModel = UserModel();
  //   emit(AuthSuccess());
  // }
}
