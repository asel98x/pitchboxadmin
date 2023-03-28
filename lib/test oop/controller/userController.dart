// controllers/user_controller.dart

import 'package:pitchboxadmin/test oop/model/user.dart';
import 'package:pitchboxadmin/test oop/services/userService.dart';

class UserController {
  final UserService userService = UserService();

  Future<void> addUser({required String name, required String email}) async {
    final user = User(name: name, email: email, id: '');
    final docRef = await userService.addUser(user);
    user.id = docRef.id;
  }

  Stream<List<User>> getUsers() {
    return userService.getUsers();
  }
}
