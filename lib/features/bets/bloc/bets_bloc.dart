import 'package:deadpool/features/bets/bets_repository_impl.dart';
import 'package:deadpool/models/bets/bets_model.dart';
import 'package:deadpool/models/friends_group.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/bets/vote_model.dart';

part 'bets_event.dart';
part 'bets_state.dart';

class BetsBloc extends Bloc<BetsEvent, BetsState> {
  final BetsRepositoyImpl repo;
  BetsBloc(this.repo) : super(const BetsState(bets: [], status: BetsStatus.initial)) {
    on<BetsEvent>(_fetchBets);
    on<AddBet>(_addBet);
    on<AddVote>(_addVote);
  }

  _fetchBets(event, emit) async {
    if (event is BetsFetched) {
      var allBets = await repo.getAllBets(event.group);
      emit(state.copyWith(bets: allBets, status: BetsStatus.success));
    }
  }

  _addBet(event, emit) async {
    if (event is AddBet){
      var hasBeenSent = await repo.addBet(event.betModel);
      if(hasBeenSent){
        emit(state.copyWith(status: BetsStatus.added));
      }
    }
  }

  _addVote(event, emit) async{
    if(event is AddVote){
      var hasBeenSent = await repo.addVote(event.betId, event.vote);
      if(hasBeenSent){
        emit(state.copyWith(status: BetsStatus.voted));
      }
    }
  }
}
