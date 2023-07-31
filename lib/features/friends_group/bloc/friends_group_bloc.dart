import 'package:deadpool/features/friends_group/friends_group_repository_impl.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/friends_group.dart';

part 'friends_group_event.dart';
part 'friends_group_state.dart';

class FriendsGroupBloc extends Bloc<FriendsGroupEvent, FriendsGroupState> {
  final FriendsGroupRepositoyImpl _repo;

  FriendsGroupBloc(this._repo) : super(const FriendsGroupState(groups: [])) {
    on<FriendsGroupsFetched>(_onGroupsFetched);
    on<SelectedFriendsGroup>(_onGroupSelected);
    on<AddFriendsGroupToUser>(_addFriendGroupToUser);
    on<CreateFriendGroup>(_createFriendGroup);
  }

  _onGroupsFetched(event, emit) async {
    if (event is FriendsGroupsFetched) {
      if (state.status == FriendsGroupStatus.initial) {
        List<FriendsGroup> groups = await _repo.getAllGroups();

        for (FriendsGroup group in groups) {
          group = await _repo.getAllUsersDataFromGroup(group);
        }

         emit(
            state.copyWith(groups: groups, status: FriendsGroupStatus.success));
      }
    }
  }

  _onGroupSelected(event, emit) {
    if (event is SelectedFriendsGroup) {
      emit(state.copyWith(selectedGroup: event.group));
    }
  }

  _addFriendGroupToUser(event, emit) async {
    if (event is AddFriendsGroupToUser) {
      var hasWorked = await _repo.addGroupToUser(event.uid, event.group);
      if (hasWorked) {
        var groups = state.groups;
        groups.remove(event.group);
        event.group.users.add(event.uid);

        emit(state.copyWith(
            status: FriendsGroupStatus.added,
            groups: [...groups, event.group]));
      }
    }
  }

  _createFriendGroup(event, emit) async {
    if (event is CreateFriendGroup) {
      var group = await _repo.createGroup(event.groupName, event.userId);

      emit(OnGroupCreate(
          status: FriendsGroupStatus.created,
          groupPasscode: group.passcode,
          groups: [...state.groups, group]));
    }
  }
}
