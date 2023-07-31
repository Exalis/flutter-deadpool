import 'package:deadpool/features/bets/bloc/bets_bloc.dart';
import 'package:deadpool/models/bets/bets_model.dart';
import 'package:deadpool/widgets/auth/text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddBetModal extends StatefulWidget {
  const AddBetModal({super.key, required this.groupId});

  final String groupId;

  @override
  State<AddBetModal> createState() => _AddBetModalState();
}

class _AddBetModalState extends State<AddBetModal> {
  final _formKey = GlobalKey<FormState>();
  String _betName = '';

  void _addBetModel(BuildContext ctx) {
    var isValid = _formKey.currentState!.validate();

    if (!isValid) {
      return;
    }

    ctx.read<BetsBloc>().add(
          AddBet(
            BetModel(
              id: 'new',
              groupId: widget.groupId,
              name: _betName,
            ),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BetsBloc, BetsState>(
      listener: (context, state) {
        if (state.status == BetsStatus.added) {
          Navigator.pop(context);
        }
        if (state.status == BetsStatus.failure) {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Erreur lors de l\'ajout')));
        }
      },
      builder: (context, state) {
        return FractionallySizedBox(
          widthFactor: 1,
          heightFactor: .9,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text('Ajouter un pari !'),
                  const SizedBox(height: 20),
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        TextInput(
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value.trim().length <= 1) {
                                return 'Merci de remplir le nom du pari';
                              }
                              return null;
                            },
                            label: 'Nom du pari',
                            onChanged: (value) {
                              setState(() {
                                _betName = value;
                              });
                            }),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            _addBetModel(context);
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
                              foregroundColor: Theme.of(context)
                                  .colorScheme
                                  .onPrimaryContainer,
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)))),
                          child: const Text('Ajouter'),
                          //TODO changer si tu as déjà voté.
                        ),
                      ],
                    ),
                  )
                ]),
          ),
        );
      },
    );
  }
}
