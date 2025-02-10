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
  UserModel _userModel = UserModel(
    name: '',
    email: '',
    password: '',
    token: '',
    id: '',
  );
  final Box _box = Hive.box('auth-token');
  final AuthService authService = AuthService();

  UserModel get userModel => _userModel;

  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>(
      (event, emit) => emit(AuthLoading()),
    );
    on<OnAuthSignUp>(onSignUpEvent);
    on<OnAuthSignIn>(onSignInEvent);
    on<ValidateCurrentUser>(validateCurrentUser);
    on<OnSignOut>(signOutUser);
  }

  void onSignUpEvent(OnAuthSignUp event, Emitter emit) async {
    final http.Response response = await authService.signUp(
      name: event.name,
      email: event.email,
      password: event.password,
    );

    final responseBody = jsonDecode(response.body);
    if (response.statusCode == 200) {
      emit(AuthSuccess());
    } else if (response.statusCode == 500) {
      emit(AuthFailure(message: responseBody['error']));
    } else {
      emit(AuthFailure(message: responseBody['mssg']));
    }
  }

  void onSignInEvent(OnAuthSignIn event, Emitter emit) async {
    try {
      final http.Response response = await authService.signIn(
        email: event.email,
        password: event.password,
      );

      final Map<String, dynamic> responseBody = jsonDecode(response.body);

      if (response.statusCode == 200) {
        _userModel = UserModel.fromMap(responseBody);
        await _box.put('Token', _userModel.token);
        emit(AuthSuccess());
      } else if (response.statusCode == 500) {
        emit(AuthFailure(message: responseBody['error']));
      } else {
        emit(AuthFailure(message: responseBody['mssg']));
      }
    } catch (e) {
      emit(AuthFailure(message: e.toString()));
    }
  }

  void validateCurrentUser(ValidateCurrentUser event, Emitter emit) async {
    final String? token = _box.get(
      'Token',
    );
    if (token != null) {
      final http.Response response =
          await authService.validateToken(token: token);
      final responseBody = jsonDecode(response.body);
      if (responseBody == true) {
        final data = await authService.getUserData(token: token);
        _userModel = UserModel.fromJson(data.body);
        emit(AuthSignedIn());
      } else {
        emit(AuthFailure(message: 'User is not authenticated'));
      }
    } else {
      emit(AuthInitial());
    }
  }

  void signOutUser(OnSignOut event, Emitter emit) async {
    final res = await _box.clear();
    emit(AuthInitial());
  }
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