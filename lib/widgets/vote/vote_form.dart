import 'package:deadpool/features/authentication/bloc/authentication_bloc.dart';
import 'package:deadpool/features/bets/bloc/bets_bloc.dart';
import 'package:deadpool/models/bets/bets_model.dart';
import 'package:deadpool/models/bets/vote_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VoteForm extends StatefulWidget {
  const VoteForm({super.key, required this.bet});

  final BetModel bet;

  @override
  State<VoteForm> createState() => _VoteFormState();
}

class _VoteFormState extends State<VoteForm> {
  final TextEditingController _controller = TextEditingController();
  final List<DropdownMenuItem> dropdownMenu = [];

  String? selectedValue;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      final String text = _controller.text.toLowerCase();
      _controller.value = _controller.value.copyWith(
        text: text,
        selection:
            TextSelection(baseOffset: text.length, extentOffset: text.length),
        composing: TextRange.empty,
      );
    });

    var list = widget.bet.group!.usersData.map((user) => DropdownMenuItem(
          value: user.uid,
          child: Text(user.displayName ?? user.email!),
        ));

    dropdownMenu.addAll(list);
    selectedValue = dropdownMenu[0].value;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();

    void addVote(BuildContext context, BuildContext authContext) {
      var isValid = formKey.currentState!.validate();

      if (!isValid) {
        return;
      }

      var state = authContext.read<AuthenticationBloc>().state;
      if (state is AuthenticationSuccess) {
        context.read<BetsBloc>().add(
            AddVote(
              widget.bet.id,
              VoteModel(
                  amount: int.parse(_controller.text),
                  userId: state.uid,
                  userVoteId: selectedValue!),
            ),
          );
      }
    }

    return BlocConsumer<BetsBloc, BetsState>(
      listener: (context, state) {
        if (state.status == BetsStatus.voted) {
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const SizedBox(height: 20),
              TextFormField(
                decoration:
                    const InputDecoration(label: Text('Tu pari combien ?')),
                controller: _controller,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField(
                value: selectedValue ?? dropdownMenu[0].value,
                items: dropdownMenu,
                onChanged: (value) {
                  setState(() {
                    selectedValue = value!;
                  });
                },
              ),
              const SizedBox(height: 20),
              BlocBuilder<AuthenticationBloc, AuthenticationState>(
                builder: (authContext, state) {
                  return ElevatedButton(
                    onPressed: () {
                      addVote(context, authContext);
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).colorScheme.primaryContainer,
                        foregroundColor:
                            Theme.of(context).colorScheme.onPrimaryContainer,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8)))),
                    child: const Text('Ajouter mon vote'),
                  );
                },
              )
            ],
          ),
        );
      },
    );
  }
}
