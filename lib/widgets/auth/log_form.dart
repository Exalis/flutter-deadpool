import 'package:deadpool/features/form-validation/bloc/form_validation_bloc.dart';
import 'package:deadpool/widgets/auth/text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogForm extends StatefulWidget {
  const LogForm({super.key});

  @override
  State<LogForm> createState() => _LogFormState();
}

class _LogFormState extends State<LogForm> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = false;

  void _submit(BuildContext context) async {
    var isValid = _formKey.currentState!.validate();

    if (!isValid) {
      return;
    }

    context
        .read<FormValidationBloc>()
        .add(FormSubmitted(value: _isLogin ? Status.signIn : Status.signUp));
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            TextInput(
              label: 'Email',
              validator: (value) {
                if (value == null ||
                    value.trim().isEmpty ||
                    !value.contains('@')) {
                  return 'Merci de mettre un email valide.';
                }
                return null;
              },
              onChanged: (value) {
                context.read<FormValidationBloc>().add(EmailChanged(value));
              },
            ),
            const SizedBox(height: 20),
            TextInput(
              label: 'Mot de passe',
              validator: (value) {
                if (value == null || value.trim().length < 6) {
                  return 'Le mot de passe doit faire 6 characters';
                }
                return null;
              },
              onChanged: (value) {
                context.read<FormValidationBloc>().add(PasswordChanged(value));
              },
            ),
            const SizedBox(height: 20),
            if (!_isLogin)
              TextInput(
                label: 'Nom',
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Tu dois bien avoir un nom non ?';
                  }
                  return null;
                },
                onChanged: (value) {
                  context
                      .read<FormValidationBloc>()
                      .add(UserNameChanged(value));
                },
              ),
            const SizedBox(height: 20),
            BlocBuilder<FormValidationBloc, FormValidate>(
              builder: (context, state) {
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Theme.of(context).colorScheme.primaryContainer),
                  onPressed: () {
                    _submit(context);
                  },
                  child: Text(
                    _isLogin ? 'Se connecter' : 'S\'inscrire',
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                setState(() {
                  _isLogin = !_isLogin;
                });
              },
              child: Text(_isLogin
                  ? 'Tu n\'a pas de compte ? Inscris toi !'
                  : 'J\'ai déjà un compte. Se connecter.'),
            ),
          ],
        ),
      ),
    );
  }
}
