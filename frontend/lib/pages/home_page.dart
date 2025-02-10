import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/bloc/auth_bloc.dart';
import 'package:frontend/models/user_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late UserModel _userModel;
  @override
  void initState() {
    _userModel = BlocProvider.of<AuthBloc>(context).userModel;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Home Page ${_userModel.email}'),
            TextButton(
                onPressed: () {
                  BlocProvider.of<AuthBloc>(context).add(OnSignOut());
                },
                child: Text('Signout'))
          ],
        ),
      ),
    );
  }
}
