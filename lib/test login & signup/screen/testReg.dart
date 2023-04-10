import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pitchboxadmin/test login & signup/model/user_model.dart';


class TestRegistrationScreen extends StatefulWidget {
  @override
  _TestRegistrationScreenState createState() => _TestRegistrationScreenState();
}

class _TestRegistrationScreenState extends State<TestRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();

  late String _firstName;
  late String _secondName;
  late String _email;
  late String _password;

  Future<void> _register() async {
    try {
      UserCredential userCredential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _email,
        password: _password,
      );

      String uid = userCredential.user!.uid;

      UserModel userModel = UserModel(
        uid: uid,
        email: _email,
        firstName: _firstName,
        secondName: _secondName,
      );

      await FirebaseFirestore.instance
          .collection('Testuser')
          .doc(uid)
          .set(userModel.toMap());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registration'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'First Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your first name.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _firstName = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Second Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your second name.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _secondName = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email.';
                  }
                  if (!value.contains('@')) {
                    return 'Please enter a valid email address.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _email = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Password'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password.';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters long.';
                  }
                  return null;
                },
                obscureText: true,
                onSaved: (value) {
                  _password = value!;
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    _register();
                  }
                },
                child: Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
