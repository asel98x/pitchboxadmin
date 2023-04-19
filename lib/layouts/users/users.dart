import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pitchboxadmin/appcolors.dart';
import 'package:pitchboxadmin/backend/controller/userController.dart';
import 'package:pitchboxadmin/backend/model/mainUser.dart';
import 'package:pitchboxadmin/backend/services/userService.dart';
import 'package:pitchboxadmin/layouts/loginScreen.dart';
import 'package:pitchboxadmin/layouts/users/tabs/entrepreneurTab.dart';
import 'package:pitchboxadmin/layouts/users/tabs/investorTab.dart';
import 'tabs/adminTab.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> with SingleTickerProviderStateMixin{
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  late TabController controller;
  final _userService = UserService();
  final _userController = UserController();
  String? errorMessage;

  bool _obscureText = true;
  final _idController = TextEditingController();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();




  void userRegister(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        await await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) => {postDetailsToFirestore()})
            .catchError((e) async {
          Fluttertoast.showToast(msg: e!.message);

          UserCredential userCredential = await FirebaseAuth.instance
              .createUserWithEmailAndPassword(email: email, password: password);
          User? user = userCredential.user;
          print(user);
        });
      } on FirebaseAuthException catch (error) {
        if (error.code == 'weak-password') {
          print('The password provided is too weak.');
        } else if (error.code == 'email-already-in-use') {
          print('The account already exists for that email.');
        }
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Your email address appears to be malformed.";
            break;
          case "wrong-password":
            errorMessage = "Your password is wrong.";
            break;
          case "user-not-found":
            errorMessage = "User with this email doesn't exist.";
            break;
          case "user-disabled":
            errorMessage = "User with this email has been disabled.";
            break;
          case "too-many-requests":
            errorMessage = "Too many requests";
            break;
          case "operation-not-allowed":
            errorMessage = "Signing in with Email and Password is not enabled.";
            break;
          default:
            errorMessage = "An undefined Error happened.";
        }
        Fluttertoast.showToast(msg: errorMessage!);
        print(error.code);
      }
    }
  }
  postDetailsToFirestore() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    MainUser userModel = MainUser(
        userId: user!.uid, // Use user.uid instead of user.userId
        userName: _nameController.text,
        userEmail: _emailController.text,
        userPassword: _confirmPasswordController.text);

    if (controller.index == 0) {
      await firebaseFirestore
          .collection("Entrepreneur")
          .doc(user.uid) // Use user.uid here as well
          .set(userModel.toMap());
      Fluttertoast.showToast(msg: "Entrepreneur Account created successfully");
    } else if (controller.index == 1) {
      await firebaseFirestore
          .collection("investor")
          .doc(user.uid) // Use user.uid here as well
          .set(userModel.toMap());
      Fluttertoast.showToast(msg: "Investor Account created successfully");
    }
    else if (controller.index == 2) {
      await firebaseFirestore
          .collection("Admin")
          .doc(user.uid) // Use user.uid here as well
          .set(userModel.toMap());
      Fluttertoast.showToast(msg: "Admin Account created successfully");
    }



  }


  @override
  void initState(){
    super.initState();
    controller = TabController(length: 3,vsync: this);
    controller.addListener(() {
      setState(() {

      });
    });
  }

  @override
  void dispose(){
    controller.dispose();
    super.dispose();
  }

  void _showAddAdminDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        bool _obscureText = true;

        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return SingleChildScrollView(
              child: AlertDialog(
                title: const Text('User Register'),
                content: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                            labelText: 'Name',border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(),
                        ),),
                        validator: (value) {
                          RegExp regex = new RegExp(r'^.{3,}$');
                          if (value!.isEmpty) {
                            return ("Name cannot be Empty");
                          }
                          if (!regex.hasMatch(value)) {
                            return ("Enter Valid name(Min. 3 Character)");
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _nameController.text = value!;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                          if (!emailRegex.hasMatch(value)) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _emailController.text = value!;
                        },
                      ),



                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureText ? Icons.visibility_off : Icons.visibility,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                          ),
                        ),
                        obscureText: _obscureText,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a password';
                          }
                          if (value.length < 6) {
                            return 'Password must be at least 6 characters long';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _confirmPasswordController,
                        decoration: InputDecoration(
                            labelText: 'Confirm Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(),
                          ),),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please confirm your password';
                          }
                          if (value != _passwordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        userRegister(_emailController.text, _confirmPasswordController.text);
                        Navigator.of(context).pop();
                      }
                    },
                    child: const Text('Register'),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }



  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: 3,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text('U S E R S'),
            backgroundColor: AppColors.mainBlueColor,
            bottom: TabBar(
              controller: controller,
              tabs: [
                Tab(text: 'Entrepreneur'),
                Tab(text: 'Investor'),
                Tab(text: 'Admin'),
              ],
            ),
          ),
          body: Column(
            children: [
              Expanded(
                child: TabBarView(
                  controller: controller,
                  children: [
                    EntrepreneurTab(),
                    InvestorTab(),
                    AdminTab(),
                  ],
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: AppColors.mainBlueColor,
            child: Icon(Icons.add, size: 32),
            onPressed: () {
              if (controller.index == 0) {
                _showAddAdminDialog(context);
              } else if (controller.index == 1) {
                _showAddAdminDialog(context);
              }
              else if (controller.index == 2) {
                _showAddAdminDialog(context);
              }
            },
          ),
        ),
      ),
    );


  }
}
