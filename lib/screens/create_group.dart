import 'package:deadpool/features/authentication/bloc/authentication_bloc.dart';
import 'package:deadpool/features/friends_group/bloc/friends_group_bloc.dart';
import 'package:deadpool/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateGroup extends StatefulWidget {
  const CreateGroup({super.key});

  @override
  State<CreateGroup> createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  final _formKey = GlobalKey<FormState>();
  String groupName = '';

  void _createGroup(BuildContext context, String uid) {
    var isValid = _formKey.currentState!.validate();

    if (!isValid) {
      return;
    }

    context
        .read<FriendsGroupBloc>()
        .add(CreateFriendGroup(groupName: groupName, userId: uid));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Créer un groupe'),
      ),
      body: BlocConsumer<FriendsGroupBloc, FriendsGroupState>(
        listener: (context, state) {
          if (state is OnGroupCreate) {
            if (state.status == FriendsGroupStatus.failure) {
              return;
            }

            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        Clipboard.setData(ClipboardData(
                            text:
                                'Rejoins nous pour parier avec le code : ${state.groupPasscode}'));
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomeScreen()),
                        );
                      },
                      child: const Text('Partager'),
                    )
                  ],
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0))),
                  title: Text(
                      'Groupe créer, partage le code : ${state.groupPasscode}'),
                );
              },
            );
          }
        },
        builder: (friendBlocContext, state) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Créer un groupe',
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                  textAlign: TextAlign.center,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(
                          label: Text('Nom du groupe'),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Il faut rentrer un nom de groupe...';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            groupName = value;
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                      BlocBuilder<AuthenticationBloc, AuthenticationState>(
                        builder: (context, authState) {
                          if(authState is AuthenticationSuccess){
                            return ElevatedButton(
                              onPressed: () {
                                _createGroup(friendBlocContext, authState.uid);
                              },
                              child: const Text('Créer le group'));
                          }

                          return const SizedBox();
                        },
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
