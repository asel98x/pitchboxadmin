// services/user_service.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pitchboxadmin/test oop/model/user.dart';
import 'package:pitchboxadmin/test oop/utility/userServiceInterface.dart';

class UserService implements UserServiceInterface {
  final CollectionReference usersCollection =
  FirebaseFirestore.instance.collection('testUsers');

  @override
  Future<DocumentReference> addUser(User user) {
    return usersCollection.add(user.toMap());
  }

  @override
  Stream<List<User>> getUsers() {
    return usersCollection.snapshots().map((snapshot) => snapshot.docs
        .map((document) => User.fromSnapshot(document))
        .toList());
  }
}
