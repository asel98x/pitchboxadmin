
import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String id;
  final String name;
  final String email;

  User({required this.id, required this.name, required this.email});

  factory User.fromSnapshot(DocumentSnapshot snapshot) {
    return User(
      name: snapshot['name'],
      email: snapshot['email'],
      id: snapshot.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
    };
  }
}
