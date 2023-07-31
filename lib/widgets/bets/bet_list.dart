import 'package:deadpool/models/bets/bets_model.dart';
import 'package:deadpool/widgets/bets/bet_item.dart';
import 'package:flutter/material.dart';

class BetList extends StatelessWidget {
  const BetList({super.key, required this.bets});

  final List<BetModel> bets;

  @override
  Widget build(BuildContext context) {
    return bets.isEmpty
        ? const Center(
            child: Text('Aucun pari n\'a été créer pour le moment.'),
          )
        : ListView.builder(
            itemCount: bets.length,
            itemBuilder: (context, index) => BetItem(bet: bets[index]),
          );
  }
}
