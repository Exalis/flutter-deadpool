import 'package:deadpool/features/bets/bets_repository_impl.dart';
import 'package:deadpool/features/bets/bloc/bets_bloc.dart';
import 'package:deadpool/models/friends_group.dart';
import 'package:deadpool/screens/add_bet_modal.dart';
import 'package:deadpool/widgets/bets/bet_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupDetails extends StatefulWidget {
  const GroupDetails({super.key, required this.group});

  final FriendsGroup group;

  @override
  State<GroupDetails> createState() => _GroupDetailsState();
}

class _GroupDetailsState extends State<GroupDetails> {
  void _createBet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: ((ctx) => AddBetModal(groupId: widget.group.id)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Les paris de ${widget.group.name}'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createBet,
        child: Icon(Icons.add,
            color: Theme.of(context).colorScheme.onPrimaryContainer),
      ),
      body: BlocBuilder<BetsBloc, BetsState>(
        builder: (context, state) {
          context.read<BetsBloc>().add(BetsFetched(widget.group));
          if (state.status == BetsStatus.initial) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return BetList(bets: state.bets);
        },
      ),
    );
  }
}
