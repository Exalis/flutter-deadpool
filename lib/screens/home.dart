import 'package:deadpool/features/authentication/bloc/authentication_bloc.dart';
import 'package:deadpool/features/friends_group/bloc/friends_group_bloc.dart';
import 'package:deadpool/screens/add_goup.dart';
import 'package:deadpool/widgets/home/groups/group_item.dart';
import 'package:deadpool/widgets/home/no_groups.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      listener: (context, authState) {
        if (authState is AuthenticationFailure) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const AuthScreen()),
              (Route<dynamic> route) => false);
        }
      },
      builder: (context, authState) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Mes groupes de Deadpool'),
            actions: [
              IconButton(
                onPressed: () {
                  context
                      .read<AuthenticationBloc>()
                      .add(AuthenticationSignedOut());
                },
                icon: const Icon(Icons.logout),
              )
            ],
          ),
          body: BlocBuilder<FriendsGroupBloc, FriendsGroupState>(
            builder: (context, state) {
              if (state.status == FriendsGroupStatus.initial) {
                return const Center(child: CircularProgressIndicator());
              }

              if (authState is AuthenticationFailure) {
                return const Center(
                  child: Text("Déconnexion, veuillez patienter..."),
                );
              }

              var usersGroup = state.groups
                  .where((group) => group.users
                      .contains((authState as AuthenticationSuccess).uid))
                  .toList();

              return usersGroup.isEmpty
                  ? const NoGroups()
                  : Stack(
                      children: [
                        ListView.builder(
                            itemCount: usersGroup.length,
                            itemBuilder: (context, index) =>
                                GroupItem(group: usersGroup[index])),
                        Positioned(
                          bottom: 20,
                          right: 20,
                          child: FloatingActionButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const AddGroup()),
                              );
                            },
                            child: const Icon(Icons.add),
                          ),
                        )
                      ],
                    );
            },
          ),
        );
      },
    );
  }
}
