import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pitchboxadmin/appcolors.dart';
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
  late TabController controller;
  final _userService = UserService();

  bool _obscureText = true;
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();



  void _addValue() async {
    late String userName= _nameController.text;
    late String userEmail= _emailController.text;
    late String userPassword= _confirmPasswordController.text;
    try{
      if (controller.index == 0) {
        await _userService.addEntrepreneur(
            MainUser(
                userId: '',
                userName: userName,
                userEmail: userEmail,
                userPassword: userPassword

            ));
      }else if (controller.index == 1) {
        await _userService.addInvestor(
            MainUser(
                userId: '',
                userName: userName,
                userEmail: userEmail,
                userPassword: userPassword

            ));
      }else if (controller.index == 2) {
       await _userService.addAdmin(
           MainUser(
               userId: '',
               userName: userName,
               userEmail: userEmail,
               userPassword: userPassword

           ));
     }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('User added successfully!'),
        ),
      );

    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to add user'),
        ),
      );
      print(e.toString());
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
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
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
                        _addValue();
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
