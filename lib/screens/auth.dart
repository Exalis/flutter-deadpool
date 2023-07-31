import 'package:deadpool/features/authentication/authentication_repository_impl.dart';
import 'package:deadpool/features/authentication/bloc/authentication_bloc.dart';
import 'package:deadpool/features/form-validation/bloc/form_validation_bloc.dart';
import 'package:deadpool/screens/home.dart';
import 'package:deadpool/widgets/auth/log_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final authRepository = AuthenticationRepositoryImpl();

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<FormValidationBloc, FormValidate>(
          listener: ((context, state) {
            if (state is FormFailed) {
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.errorMessage))
              );
            }
            if (state is FormSucceeded) {
              context.read<AuthenticationBloc>().add(AuthenticationStarted());
            }
          }),
        ),
        BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            if (state is AuthenticationSuccess) {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                  (Route<dynamic> route) => false);
            }
          },
        )
      ],
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  margin: const EdgeInsets.all(20),
                  width: 100,
                  child: Image.asset('assets/images/background.png'),
                ),
                const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: LogForm(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
