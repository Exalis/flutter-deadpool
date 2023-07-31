part of 'bets_bloc.dart';

abstract class BetsEvent extends Equatable {
  const BetsEvent();

  @override
  List<Object> get props => [];
}

class BetsFetched extends BetsEvent {
  const BetsFetched(this.group);

  final FriendsGroup group;
}

class AddBet extends BetsEvent {
  const AddBet(this.betModel);

  final BetModel betModel;
}

class AddVote extends BetsEvent {
  const AddVote(this.betId, this.vote);

  final String betId;
  final VoteModel vote;
}