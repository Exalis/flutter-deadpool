part of 'friends_group_bloc.dart';

abstract class FriendsGroupEvent extends Equatable {
  const FriendsGroupEvent();

  @override
  List<Object> get props => [];
}

class FriendsGroupsFetched extends FriendsGroupEvent{}

class SelectedFriendsGroup extends FriendsGroupEvent{
  const SelectedFriendsGroup({required this.group});
  
  final FriendsGroup group;
}

class AddFriendsGroupToUser extends FriendsGroupEvent{
  const AddFriendsGroupToUser({required this.uid, required this.group});

  final String uid;
  final FriendsGroup group;
}

class CreateFriendGroup extends FriendsGroupEvent{
  const CreateFriendGroup({required this.groupName, required this.userId});

  final String userId;
  final String groupName;
}