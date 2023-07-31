part of 'friends_group_bloc.dart';

enum FriendsGroupStatus {
  initial,
  success,
  failure, 
  added, created,
}

final class FriendsGroupState extends Equatable {
  const FriendsGroupState({
    this.groups = const <FriendsGroup>[],
    this.status = FriendsGroupStatus.initial,
    this.selectedGroup,
  });

  final List<FriendsGroup> groups;
  final FriendsGroupStatus status;
  final FriendsGroup? selectedGroup;

  FriendsGroupState copyWith({
    List<FriendsGroup>? groups,
    FriendsGroupStatus? status,
    FriendsGroup? selectedGroup
  }){
    return FriendsGroupState(
      groups: groups ?? this.groups,
      status: status ?? this.status,
      selectedGroup: selectedGroup ?? this.selectedGroup
    );
  }

  FriendsGroup? getById(String passcode){
    var result = groups.where((group) => group.passcode == passcode);

    if(result.isEmpty) return null;

    return result.first;
  }

  @override
  List<Object?> get props => [groups, status, selectedGroup];
}

final class OnGroupCreate extends FriendsGroupState{
  const OnGroupCreate({super.groups, super.selectedGroup, super.status, required this.groupPasscode});

  final String groupPasscode;
}