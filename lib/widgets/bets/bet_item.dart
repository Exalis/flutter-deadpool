import 'package:deadpool/models/bets/bets_model.dart';
import 'package:deadpool/screens/vote_screen.dart';
import 'package:flutter/material.dart';

class BetItem extends StatelessWidget {
  const BetItem({super.key, required this.bet});

  final BetModel bet;

  @override
  Widget build(BuildContext context) {

    void _openVote() {
      Navigator.push(
       context,
       MaterialPageRoute(builder: (context) => VoteScreen(bet: bet)),
       );
    }

    return SizedBox(
      width: double.infinity,
      height: 200,
      child: Card(
        margin: const EdgeInsets.all(20),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                bet.name,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(color: Theme.of(context).colorScheme.primary),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    bet.numberOfParticipants,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                  Text(
                    bet.cashPrice,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  _openVote();
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Theme.of(context).colorScheme.primaryContainer,
                    minimumSize: const Size.fromHeight(50),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    )),
                child: Text(
                  'Voter',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onPrimaryContainer
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
