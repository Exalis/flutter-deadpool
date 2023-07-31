import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/form-validation/bloc/form_validation_bloc.dart';

class TextInput extends StatelessWidget {
  TextInput(
      {super.key,
      required this.validator,
      required this.label,
      required this.onChanged,
      this.keyboardType = TextInputType.emailAddress
      });

  TextInputType keyboardType = TextInputType.emailAddress;
  final String label;
  final String? Function(String?) validator;
  final void Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FormValidationBloc, FormValidate>(
      builder: (context, state) {
        return TextFormField(
          decoration: InputDecoration(
            label: Text(label),
            border: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.purple),
                borderRadius: BorderRadius.all(Radius.circular(20))),
          ),
          keyboardType: keyboardType,
          validator: validator,
          onChanged: onChanged,
        );
      },
    );
  }
}
