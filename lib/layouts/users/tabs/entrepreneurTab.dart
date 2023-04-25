import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pitchboxadmin/appcolors.dart';
import 'package:pitchboxadmin/appstyles.dart';
import 'package:pitchboxadmin/backend/controller/userController.dart';
import 'package:pitchboxadmin/backend/model/mainUser.dart';

class EntrepreneurTab extends StatefulWidget {

  @override
  _EntrepreneurTabState createState() => _EntrepreneurTabState();
}

class _EntrepreneurTabState extends State<EntrepreneurTab> {
  final _formKey = GlobalKey<FormState>();
  final UserController _controller = UserController();
  final _idController = TextEditingController();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  List<MainUser> _entrepreneurList = [];
  List<MainUser> _filteredEntrepreneur = [];

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadInvestorList();
  }

  Future<void> _loadInvestorList() async {
    List<MainUser> entrepreneurListList = await _controller.getEntrepreneurList();
    setState(() {
      _entrepreneurList = entrepreneurListList;
      _filteredEntrepreneur = entrepreneurListList;
    });
  }

  void _filterAdmins(String query) {
    List<MainUser> filteredEntrepreneur  = _entrepreneurList
        .where((entrepreneurListList) =>
        entrepreneurListList.userName.toLowerCase().contains(query.toLowerCase()))
        .toList();
    setState(() {
      _filteredEntrepreneur = filteredEntrepreneur;
    });
  }

  Future<void> _handleRefresh() async {
    _loadInvestorList();
  }

  void _showUserDetailsDialog(BuildContext context, MainUser mainUser) {
    bool _obscurePassword = true;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        _idController.text = mainUser.userId;
        _nameController.text = mainUser.userName;
        _emailController.text = mainUser.userEmail;
        _passwordController.text = mainUser.userPassword;
        return AlertDialog(
          title: Text('User Information'),
          content: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _idController,
                          decoration: InputDecoration(
                            labelText: 'User ID',
                            border: OutlineInputBorder(),
                          ),
                          enabled: false,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Clipboard.setData(ClipboardData(text: _idController.text));
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Copied to clipboard')),
                          );
                        },
                        icon: Icon(Icons.copy),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'UserName',
                      border: OutlineInputBorder(),
                    ),
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
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'User Email',
                      border: OutlineInputBorder(),
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
                  SizedBox(height: 20),
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
                          _obscurePassword ? Icons.visibility_off : Icons.visibility,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                    ),
                    obscureText: _obscurePassword,
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
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _confirmPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      border: OutlineInputBorder(),
                    ),
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
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        print('before');
                        String id = mainUser.userId;
                        String name = _nameController.text;
                        String email = _emailController.text;
                        String password = _passwordController.text;
                        String userType = 'entrepreneur';

                        await _controller.updateEntrepreneur(id, name, email, password, userType);
                        print('after');
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('User information updated')),
                        );
                        Navigator.pop(context);
                      }
                    },
                    child: Text('Update'),
                  ),

                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, MainUser mainUser) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Delete'),
          content: Text('Are you sure you want to delete ${mainUser.userName}?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text('Delete'),
            ),
          ],
        );
      },
    ).then((confirmed) {
      if (confirmed == true) {
        // Call the delete method on the controller to delete the industry
        _controller.deleteEntrepreneur(mainUser.userId);
        // Refresh the list after deletion
        _handleRefresh();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              labelText: 'Search Entrepreneur',
              hintText: 'Enter an Entrepreneur name',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            onChanged: (value) {
              _filterAdmins(value);
            },
          ),
        ),
        Expanded(
          child: RefreshIndicator(
            onRefresh: _handleRefresh,
            child: _filteredEntrepreneur.isEmpty
                ? Center(
              child: Text('No entrepreneur found'),
            )
                : ListView.builder(
              itemCount: _filteredEntrepreneur.length,
              itemBuilder: (context, index) {
                MainUser mainUser = _filteredEntrepreneur[index];
                return GestureDetector(
                  onTap: () {
                    _showUserDetailsDialog(context, mainUser);
                  },
                  onLongPress: () {
                    _showDeleteConfirmationDialog(context, mainUser);
                  },
                  child: Card(
                    child: Column(
                      children: [
                        SizedBox(height: 8),
                        Text(
                          mainUser.userName,
                          style: ralewayStyle.copyWith(
                            fontSize: 18.0,
                            color: AppColors.textColor,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          mainUser.userEmail,
                          style: ralewayStyle.copyWith(
                            fontSize: 18.0,
                            color: AppColors.textColor,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
