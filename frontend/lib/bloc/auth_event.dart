part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class OnAuthSignIn extends AuthEvent {
  final String email;
  final String password;
  final BuildContext context;

  OnAuthSignIn({
    required this.email,
    required this.password,
    required this.context,
  });
}

class OnAuthSignUp extends AuthEvent {
  final String name;
  final String email;
  final String password;

  OnAuthSignUp({
    required this.name,
    required this.email,
    required this.password,
  });
}

class IsUserLogedIn extends AuthEvent {}

class ValidateCurrentUser extends AuthEvent {}

class OnSignOut extends AuthEvent {}
