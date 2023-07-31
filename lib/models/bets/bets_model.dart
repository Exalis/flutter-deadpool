import 'package:deadpool/models/bets/vote_model.dart';
import 'package:deadpool/models/friends_group.dart';

class BetModel {
  BetModel({
    required this.id,
    required this.groupId,
    required this.name, 
    this.group,
  });

  final String id;
  final String groupId;
  final String name;
  final List<VoteModel> votes = [];
  FriendsGroup? group;

  String get cashPrice {
    int amount = 0;
    for(VoteModel vote in votes){
      amount += vote.amount;
    }
    return "${amount}€";
  }

  String get numberOfParticipants {
    return "${votes.length} participants";
  }

  void addVote(VoteModel voteModel) {
    votes.add(voteModel);
  }

}
