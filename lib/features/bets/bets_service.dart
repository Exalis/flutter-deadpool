import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deadpool/models/bets/bets_model.dart';
import 'package:deadpool/models/bets/vote_model.dart';
import 'package:deadpool/models/friends_group.dart';

class BetsService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<List<BetModel>> getAllBets(FriendsGroup group) async {
    final response = await firestore
        .collection('bets')
        .where('groupId', isEqualTo: group.id)
        .get();

    final List<BetModel> fetchedBets = [];
    for (var document in response.docs) {
      var betData = document.data();
      fetchedBets.add(BetModel(
        groupId: group.id,
        name: betData['name'],
        id: document.id,
        group: group
      ));
    }

    for (BetModel betModel in fetchedBets) {
      final voteCollection = await firestore
          .collection('bets')
          .doc(betModel.id)
          .collection('votes')
          .get();

      for (var voteDocument in voteCollection.docs) {
        betModel.addVote(VoteModel(
            userId: voteDocument['userId'],
            userVoteId: voteDocument['userVoteId'],
            amount: voteDocument['amount']));
      }
    }

    return fetchedBets;
  }

  Future<bool> addBet(BetModel betModel) async {
    try {
      await firestore
          .collection('bets')
          .add({'groupId': betModel.groupId, 'name': betModel.name});

      return true;
    } catch (e) {
      return false;
    }
  }

   Future<bool> addVote(String betId, VoteModel vote) async {
    try {
      await firestore
          .collection('bets')
          .doc(betId).collection('votes').add({
            'userId': vote.userId,
            'userVoteId': vote.userVoteId,
            'amount': vote.amount
          });
      return true;
    } catch (e) {
      return false;
    }
  }
}
