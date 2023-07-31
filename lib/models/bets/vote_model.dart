class VoteModel {
  const VoteModel({
    required this.userId,
    required this.userVoteId,
    required this.amount
  });

  final String userId;
  final String userVoteId;
  final int amount;
}