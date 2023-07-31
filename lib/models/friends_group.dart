import 'package:deadpool/models/user_model.dart';

class FriendsGroup {
  FriendsGroup({
    required this.id,
    required this.users,
    required this.bets,
    required this.name,
    required this.passcode
  });

  final String id;
  final List<dynamic> users;
  final List<dynamic> bets;
  final String name;
  final String passcode;
  
  final List<UserModel> usersData = [];

  UserModel? getUserById(String id){
    var users = usersData.where((user) => user.uid == id);
    if(users.isEmpty){
      return null;
    }

    return users.first;
  }

  void addUser(UserModel userModel) {
    usersData.add(userModel);
  }
}
