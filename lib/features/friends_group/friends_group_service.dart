import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deadpool/models/friends_group.dart';
import 'package:uuid/uuid.dart';

import '../../models/user_model.dart';

const uuidGen = Uuid();

class FriendsGroupService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<List<FriendsGroup>> getAll() async {
    var snapshot = await firestore.collection('friends_group').get();
    final List<FriendsGroup> groupOfFriends = [];

    for (var document in snapshot.docs) {
      var data = document.data();
      groupOfFriends.add(FriendsGroup(
        users: data['users'],
        bets: data['bets'],
        id: document.id,
        name: data['name'],
        passcode: data['passcode'],
      ));
    }

    return groupOfFriends;
  }

  Future<FriendsGroup> getUsersOfGroup(FriendsGroup group) async {
    for (String userId in group.users) {
      var response = await firestore.collection('users').doc(userId).get();
      group.addUser(UserModel(
          email: response['email'],
          uid: userId,
          displayName: response['displayName']));
    }
    return group;
  }

  Future<bool> addGroupToUser(String uid, FriendsGroup group) async {
    try {
      firestore.collection('friends_group').doc(group.id).update({
        'users': [...group.users, uid]
      });
      return true;
    } on Exception {
      return false;
    }
  }

  Future<FriendsGroup> createGroup(String groupName, String userId) async {
    var uuid = uuidGen.v1();
    var rng = Random();
    var passcode = (rng.nextInt(900000) + 100000).toString();

    var group = FriendsGroup(
        bets: <String>[],
        id: uuid,
        name: groupName,
        passcode: passcode,
        users: <String>[userId]);

    await firestore.collection('friends_group').doc(uuid).set({
      'bets': group.bets,
      'id': group.id,
      'name': group.name,
      'passcode': group.passcode,
      'users': group.users
    });

    return group;
  }
}
