import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PasscodeInput extends StatelessWidget {
  const PasscodeInput({super.key, required this.updateValue});

  final void Function(String) updateValue;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40,
      height: 40,
      child: TextField(
        style: Theme.of(context).textTheme.headlineLarge,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly
        ],
        onChanged: (value) {
          if (value.length == 1) {
            updateValue(value);
            FocusScope.of(context).nextFocus();
          }
        },
      ),
    );
  }
}
