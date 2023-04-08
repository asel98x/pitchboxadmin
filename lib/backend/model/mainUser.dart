import 'package:cloud_firestore/cloud_firestore.dart';

class MainUser {
  String userId;
  final String userName;
  final String userEmail;
  final String userPassword;

  MainUser({
    required this.userId,
    required this.userName,
    required this.userEmail,
    required this.userPassword,
  });

  factory MainUser.fromSnapshot(DocumentSnapshot snapshot) {
    return MainUser(
      userName: snapshot['userName'],
      userEmail: snapshot['userEmail'],
      userPassword: snapshot['userPassword'],
      userId: snapshot.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'userName': userName,
      'userEmail': userEmail,
      'userPassword': userPassword,
    };
  }
}