part of 'bets_bloc.dart';

enum BetsStatus { initial, success, failure, added, voted }

final class BetsState extends Equatable {
  const BetsState({required this.bets, required this.status});

  final List<BetModel> bets;
  final BetsStatus status;

  BetsState copyWith({List<BetModel>? bets, BetsStatus? status}) {
    return BetsState(bets: bets ?? this.bets, status: status ?? this.status);
  }

  @override
  List<Object> get props => [bets, status];
}
