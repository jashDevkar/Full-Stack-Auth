import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/bloc/auth_bloc.dart';
import 'package:frontend/pages/home_page.dart';
import 'package:frontend/widgets/input_field.dart';
import 'package:page_transition/page_transition.dart';

class SigninPage extends StatelessWidget {
  SigninPage({super.key});

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final RegExp _emailRegex =
      RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
  final RegExp _passwordRegex =
      RegExp(r"^(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$");

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    } else if (!_emailRegex.hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    } else if (!_passwordRegex.hasMatch(value)) {
      return 'Password must be at least 8 chars with 1 uppercase, 1 number & 1 special char';
    }
    return null;
  }

  void _submitForm(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<AuthBloc>(context).add(OnAuthSignIn(
          email: _emailController.text,
          password: _passwordController.text,
          context: context));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.rightToLeft, child: HomePage()),
          );
        }
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            elevation: 4.0,
            title: Text("Signup"),
          ),
          body: Center(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  spacing: 10.0,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InputField(
                      validateInputField: _validateEmail,
                      controller: _emailController,
                      hintText: "Email",
                    ),
                    InputField(
                      validateInputField: _validatePassword,
                      controller: _passwordController,
                      hintText: "Password",
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                          foregroundColor: Colors.black,
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0))),
                      onPressed: () => _submitForm(context),
                      child: Text('Signin'),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
