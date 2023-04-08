import 'package:flutter/material.dart';
import 'package:pitchboxadmin/appcolors.dart';
import 'package:pitchboxadmin/appstyles.dart';
import 'package:pitchboxadmin/backend/controller/userController.dart';
import 'package:pitchboxadmin/backend/model/mainUser.dart';

class AdminTab extends StatefulWidget {

  @override
  _AdminTabState createState() => _AdminTabState();
}

class _AdminTabState extends State<AdminTab> {
  final UserController _controller = UserController();

  List<MainUser> _adminList = [];
  List<MainUser> _filteredAdmins = [];

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadadminList();
  }

  Future<void> _loadadminList() async {
    List<MainUser> adminList = await _controller.getAdminList();
    setState(() {
      _adminList = adminList;
      _filteredAdmins = adminList;
    });
  }

  void _filterAdmins(String query) {
    List<MainUser> filteredAdmins = _adminList
        .where((adminList) =>
        adminList.userName.toLowerCase().contains(query.toLowerCase()))
        .toList();
    setState(() {
      _filteredAdmins = filteredAdmins;
    });
  }

  Future<void> _handleRefresh() async {
    _loadadminList();
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
        _controller.deleteAdmin(mainUser.userId);
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
              labelText: 'Search Admin',
              hintText: 'Enter an Admin name',
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
            child: _filteredAdmins.isEmpty
                ? Center(
              child: Text('No admins found'),
            )
                : ListView.builder(
              itemCount: _filteredAdmins.length,
              itemBuilder: (context, index) {
                MainUser mainUser = _filteredAdmins[index];
                return GestureDetector(
                  onTap: () { },
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
