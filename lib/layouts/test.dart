import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pitchboxadmin/layouts/dashboard.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String _errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  hintText: 'Username',
                ),
              ),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Password',
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  try {
                    // Get the entered username and password data
                    String username = _usernameController.text;
                    String password = _passwordController.text;

                    // Check if the entered username and password data is correct on Firestore
                    QuerySnapshot snapshot = await _firestore
                        .collection('admin')
                        .where('username', isEqualTo: username)
                        .get();

                    if (snapshot.docs.length > 0) {
                      // Get the first document in the query result
                      DocumentSnapshot document = snapshot.docs[0];

                      // Check if the entered password matches the password in Firestore
                      String actualPassword = document.get('password');
                      if (actualPassword == password) {
                        // Navigate to the next page
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Dashboard(),
                          ),
                        );
                      } else {
                        setState(() {
                          _errorMessage = 'Incorrect password';
                        });
                      }
                    } else {
                      setState(() {
                        _errorMessage = 'User not found';
                      });
                    }
                  } catch (e) {
                    setState(() {
                      _errorMessage = 'Error: $e';
                    });
                  }
                },


                child: Text('Login'),
              ),
              SizedBox(height: 16.0),
              Text(
                _errorMessage,
                style: TextStyle(color: Colors.red),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
