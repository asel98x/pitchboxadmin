import 'package:flutter/material.dart';
import 'package:pitchboxadmin/appcolors.dart';
import 'package:pitchboxadmin/appstyles.dart';
import 'package:pitchboxadmin/backend/controller/userController.dart';
import 'package:pitchboxadmin/backend/model/mainUser.dart';

class InvestorTab extends StatefulWidget {

  @override
  _InvestorTabState createState() => _InvestorTabState();
}

class _InvestorTabState extends State<InvestorTab> {
  final UserController _controller = UserController();

  List<MainUser> _investorList = [];
  List<MainUser> _filteredInvestors = [];

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadInvestorList();
  }

  Future<void> _loadInvestorList() async {
    List<MainUser> investorList = await _controller.getInvestorList();
    setState(() {
      _investorList = investorList;
      _filteredInvestors = investorList;
    });
  }

  void _filterAdmins(String query) {
    List<MainUser> filteredInvestors  = _investorList
        .where((investorList) =>
        investorList.userName.toLowerCase().contains(query.toLowerCase()))
        .toList();
    setState(() {
      _filteredInvestors = filteredInvestors;
    });
  }

  Future<void> _handleRefresh() async {
    _loadInvestorList();
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
        _controller.deleteInvestor(mainUser.userId);
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
              labelText: 'Search Investor',
              hintText: 'Enter an Investor name',
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
            child: _filteredInvestors.isEmpty
                ? Center(
              child: Text('No investor found'),
            )
                : ListView.builder(
              itemCount: _filteredInvestors.length,
              itemBuilder: (context, index) {
                MainUser mainUser = _filteredInvestors[index];
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
