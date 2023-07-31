import 'package:deadpool/features/authentication/bloc/authentication_bloc.dart';
import 'package:deadpool/models/friends_group.dart';
import 'package:deadpool/screens/create_group.dart';
import 'package:deadpool/widgets/add_group/passcode_input.dart';
import 'package:deadpool/widgets/home/groups/group_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../features/friends_group/bloc/friends_group_bloc.dart';

enum GetGroupState { initial, loading, error, fetched }

class AddGroup extends StatefulWidget {
  const AddGroup({super.key});

  @override
  State<AddGroup> createState() => _AddGroupState();
}

class _AddGroupState extends State<AddGroup> {
  int firstDigit = 0;
  int secondDigit = 0;
  int thirdDigit = 0;
  int fourthDigit = 0;
  int fifthDigit = 0;
  int sixtDigit = 0;
  GetGroupState groupState = GetGroupState.initial;
  FriendsGroup? group;

  void _addGroupToUser(String uid) {
    context
        .read<FriendsGroupBloc>()
        .add(AddFriendsGroupToUser(uid: uid, group: group!));
  }

  void _searchGroup(FriendsGroupState state) {
    setState(() {
      groupState = GetGroupState.loading;
    });

    var groupResult =
        state.getById('$firstDigit$secondDigit$thirdDigit$fourthDigit$fifthDigit$sixtDigit');

    if (groupResult == null) {
      setState(() {
        groupState = GetGroupState.error;
      });
    } else {
      setState(() {
        groupState = GetGroupState.fetched;
        group = groupResult;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rejoindre un group!'),
      ),
      body: BlocConsumer<FriendsGroupBloc, FriendsGroupState>(
        listener: (context, state) {
          if (state.status == FriendsGroupStatus.added) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Form(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      PasscodeInput(updateValue: (value) {
                        setState(() {
                          firstDigit = int.parse(value);
                        });
                      }),
                      PasscodeInput(updateValue: (value) {
                        setState(() {
                          secondDigit = int.parse(value);
                        });
                      }),
                      PasscodeInput(updateValue: (value) {
                        setState(() {
                          thirdDigit = int.parse(value);
                        });
                      }),
                      PasscodeInput(updateValue: (value) {
                        setState(() {
                          fourthDigit = int.parse(value);
                        });
                      }),
                      PasscodeInput(updateValue: (value) {
                        setState(() {
                          fifthDigit = int.parse(value);
                        });
                      }),
                      PasscodeInput(updateValue: (value) {
                        setState(() {
                          sixtDigit = int.parse(value);
                        });
                        _searchGroup(state);
                      }),
                    ],
                  ),
                ),
                if (groupState == GetGroupState.loading)
                  const CircularProgressIndicator()
                else if (groupState == GetGroupState.error)
                  const Text('Le group n\'existe pas')
                else if (groupState == GetGroupState.fetched)
                  IgnorePointer(
                    child: GroupItem(group: group!),
                  ),
                const SizedBox(height: 10),
                BlocBuilder<AuthenticationBloc, AuthenticationState>(
                  builder: (context, authState) {
                    return ElevatedButton(
                      onPressed: () {
                        if (groupState == GetGroupState.fetched &&
                            authState is AuthenticationSuccess) {
                          _addGroupToUser(authState.uid);
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text('Erreur...'),
                          ));
                        }
                      },
                      child: const Text('Ajouter le groupe'),
                    );
                  },
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                     context,
                     MaterialPageRoute(builder: (context) => const CreateGroup()),
                     );
                  },
                  child: const Text('Je veux créer un groupe'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
