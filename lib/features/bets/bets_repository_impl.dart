import 'package:deadpool/features/bets/bets_service.dart';
import 'package:deadpool/models/bets/vote_model.dart';
import 'package:deadpool/models/friends_group.dart';

import '../../models/bets/bets_model.dart';

class BetsRepositoyImpl extends BetsRepositoy{
  BetsService service = BetsService();

  @override
  Future<List<BetModel>> getAllBets(FriendsGroup group) async {
    return await service.getAllBets(group);  
  }

  Future<bool> addBet(BetModel betModel) async {
    return await service.addBet(betModel);
  }

  Future<bool> addVote(String betId, VoteModel vote) async {
    return await service.addVote(betId, vote);
  }

}

abstract class BetsRepositoy{
  Future<List<BetModel>> getAllBets(FriendsGroup group); 
}