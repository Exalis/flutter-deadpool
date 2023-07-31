import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? uid;
  final String? email;
  String? password;
  final String? displayName;
  final int? age;
  UserModel({this.uid, this.email, this.password, this.displayName, this.age});

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'displayName': displayName,
      'age': age,
    };
  }

  UserModel.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : uid = doc.id,
        email = doc.data()!["email"],
        age = doc.data()!["age"],
        displayName = doc.data()!["displayName"];
 

  UserModel copyWith({
    String? uid,
    String? email,
    String? password,
    String? displayName,
    int? age,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      password: password ?? this.password,
      displayName: displayName ?? this.displayName,
      age: age ?? this.age,
    );
  }
}

