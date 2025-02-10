import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/bloc/auth_bloc.dart';
import 'package:frontend/pages/home_page.dart';
import 'package:frontend/pages/signup_page.dart';
import 'package:frontend/theme/app_theme.dart';
import 'package:frontend/widgets/loading.dart';
import 'package:frontend/widgets/show_snack_bar.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('auth-token');
  runApp(MultiBlocProvider(
      providers: [BlocProvider(create: (_) => AuthBloc())],
      child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    BlocProvider.of<AuthBloc>(context).add(ValidateCurrentUser());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      home: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            showSnackBar(context, state.message);
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return Loading();
          }
          if (state is AuthSignedIn) {
            return HomePage();
          }

          return SignupPage();
        },
      ),
    );
  }
}
