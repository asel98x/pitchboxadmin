// views/user_list_screen.dart

import 'package:flutter/material.dart';
import 'package:pitchboxadmin/test%20oop/controller/userController.dart';
import 'package:pitchboxadmin/test%20oop/model/user.dart';

class UserListScreen extends StatelessWidget {
  final UserController _userController = UserController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User List'),
      ),
      body: StreamBuilder<List<User>>(
        stream: _userController.getUsers(),
        builder: (context, snapshot) {
          print(snapshot);
          if (snapshot.hasError) {
            return const Center(
              child: Text('An error occurred'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final users = snapshot.data!;

          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              return ListTile(
                title: Text(user.name),
                subtitle: Text(user.id),
              );
            },
          );
        },
      ),
    );
  }
}
