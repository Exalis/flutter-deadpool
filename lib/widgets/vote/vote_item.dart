import 'package:deadpool/features/friends_group/bloc/friends_group_bloc.dart';
import 'package:deadpool/models/bets/vote_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VoteItem extends StatelessWidget {
  const VoteItem({super.key, required this.vote});

  final VoteModel vote;
  
  //TODO Changer l'UI Si tout le monde a voté.

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FriendsGroupBloc, FriendsGroupState>(
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.only(bottom: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                    '${state.selectedGroup?.getUserById(vote.userId)?.displayName} a voté ${state.selectedGroup?.getUserById(vote.userVoteId)?.displayName}'),
              ),
              Container(
                width: 60,
                height: 30,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(80),
                  color: Theme.of(context).colorScheme.secondaryContainer,
                ),
                child: Text(
                  '${vote.amount}€',
                  style: TextStyle(
                      color:
                          Theme.of(context).colorScheme.onSecondaryContainer),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
