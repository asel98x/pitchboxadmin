// services/user_service_interface.dart

import 'package:pitchboxadmin/test oop/model/user.dart';

abstract class UserServiceInterface {
  Future<void> addUser(User user);
  Stream<List<User>> getUsers();
}
