import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/constants/contants.dart';
import 'package:frontend/pages/signin_page.dart';
import 'package:frontend/services/auth_service.dart';
import 'package:frontend/widgets/input_field.dart';
import 'package:page_transition/page_transition.dart';

class SignupPage extends StatefulWidget {
  SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  Constants constants = Constants();

  AuthService authService = AuthService();

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    } else if (!constants.nameRegex.hasMatch(value)) {
      return 'Enter a valid name (Min. 3 letters, only alphabets)';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    } else if (!constants.emailRegex.hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  void _submitForm(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(content: Text("Form Submitted Successfully!")),
      // );
      try {
        final response = await authService.signUp(
            name: _nameController.text,
            email: _emailController.text,
            password: _passwordController.text);

        if (response.statusCode == 200) {
          _emailController.clear();
          _nameController.clear();
          _passwordController.clear();
        }

        // print(response.statusCode);
        // print(jsonDecode(response.body));
      } catch (e) {}
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                    validateInputField: _validateName,
                    controller: _nameController,
                    hintText: "Name",
                  ),
                  InputField(
                    validateInputField: _validateEmail,
                    controller: _emailController,
                    hintText: "Email",
                  ),
                  InputField(
                    validateInputField: (val) {},
                    controller: _passwordController,
                    hintText: "Password",
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.blueGrey.shade700,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0))),
                    onPressed: () => _submitForm(context),
                    child: Text('Signup'),
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.rightToLeftWithFade,
                            child: SigninPage()),
                      ),
                      child: Text("Login?"),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
