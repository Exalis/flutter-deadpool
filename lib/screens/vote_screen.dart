import 'package:deadpool/models/bets/bets_model.dart';
import 'package:deadpool/models/bets/vote_model.dart';
import 'package:deadpool/widgets/vote/vote_form.dart';
import 'package:deadpool/widgets/vote/vote_item.dart';
import 'package:flutter/material.dart';

class VoteScreen extends StatelessWidget {
  const VoteScreen({super.key, required this.bet});

  final BetModel bet;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('C\'est l\'heure de voter !'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              bet.name,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Theme.of(context).colorScheme.primary, fontSize: 28),
            ),           
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    side: const BorderSide(
                      color: Color.fromARGB(113, 190, 190, 190),
                    )),
                elevation: 0,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (VoteModel vote in bet.votes) VoteItem(vote: vote),
                      Text('Pour un total de : ${bet.cashPrice}')
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            VoteForm(bet: bet,)
          ],
        ),
      ),
    );
  }
}
