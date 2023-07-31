import 'package:deadpool/models/friends_group.dart';

import 'friends_group_service.dart';

class FriendsGroupRepositoyImpl extends FriendsGroupRepositoy {
  final FriendsGroupService service = FriendsGroupService();

  @override
  Future<List<FriendsGroup>> getAllGroups() {
    return service.getAll();
  }
  
  @override
  Future<FriendsGroup> getAllUsersDataFromGroup(FriendsGroup group) {
    return service.getUsersOfGroup(group);
  }

  Future<bool> addGroupToUser(String uid, FriendsGroup group) async {
    return await service.addGroupToUser(uid, group);
  }

  Future<FriendsGroup> createGroup(String groupName, String userId) async {
    return await service.createGroup(groupName, userId);
  }
}

abstract class FriendsGroupRepositoy {
  Future<List<FriendsGroup>> getAllGroups();
  Future<FriendsGroup> getAllUsersDataFromGroup(FriendsGroup group);
}
