import 'package:cloud_firestore/cloud_firestore.dart';

class MainUser {
  String userId;
  String userName;
  final String userEmail;
  final String userPassword;
  final String userType;

  MainUser({
    required this.userId,
    required this.userName,
    required this.userEmail,
    required this.userPassword,
    required this.userType,
  });

  factory MainUser.fromSnapshot(DocumentSnapshot snapshot) {
    return MainUser(
      userName: snapshot['userName'],
      userEmail: snapshot['userEmail'],
      userPassword: snapshot['userPassword'],
      userType: snapshot['userType'],
      userId: snapshot.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'userName': userName,
      'userEmail': userEmail,
      'userPassword': userPassword,
      'userType': userType,
    };
  }
}