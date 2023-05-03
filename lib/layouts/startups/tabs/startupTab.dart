import 'package:flutter/material.dart';
import 'package:pitchboxadmin/appcolors.dart';
import 'package:pitchboxadmin/appstyles.dart';
import 'package:pitchboxadmin/backend/controller/businessController.dart';
import 'package:pitchboxadmin/backend/model/business.dart';
import 'package:pitchboxadmin/layouts/startups/add/UpdateBusinessPage.dart';

class StartupTab extends StatefulWidget {
  const StartupTab({Key? key}) : super(key: key);

  @override
  _StartupTabState createState() => _StartupTabState();
}

class _StartupTabState extends State<StartupTab> {
  final BusinessController _controller = BusinessController();
  final TextEditingController _searchController = TextEditingController();

  List<Business> _businessList = [];

  @override
  void initState() {
    super.initState();
    _loadBusinessList();
  }

  Future<void> _loadBusinessList() async {
    List<Business> businessList = await _controller.getNewBusinessesList();
    setState(() {
      _businessList = businessList;
    });
  }


  void _filterBusinessList(String query) {
    List<Business> filterBusinessList = _businessList
        .where((business) =>
        business.businessName.toLowerCase().contains(query.toLowerCase()))
        .toList();
    setState(() {
      _businessList = filterBusinessList;
    });
  }

  Future<void> _handleRefresh() async {
    _loadBusinessList();
  }

  void _showDeleteConfirmationDialog(BuildContext context, Business business) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Delete'),
          content: Text('Are you sure you want to delete ${business.businessName}?'),
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
        _controller.deleteNewBusiness(business.id);
        // Refresh the list after deletion
        _handleRefresh();

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Business idea Deleted successfully!'),
          ),
        );
        Navigator.of(context).pop();
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
                labelText: 'Search Startup',
                hintText: 'Enter a Startup name',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              onChanged: (value) {
                _filterBusinessList(value);
              },
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: _handleRefresh,
              child: _businessList.isEmpty
                  ? Center(
                child: Text('No Startups found'),
              )
                  : ListView.builder(
                itemCount: _businessList.length,
                itemBuilder: (context, index) {
                  Business business = _businessList[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => updateBusinessPage(business: _businessList[index],)),
                      );
                    },
                    onLongPress: () {
                      _showDeleteConfirmationDialog(context,business);
                    },
                    child: Card(
                      margin: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Stack(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Image.network(
                                    business.businessImgUrl,
                                    fit: BoxFit.cover,
                                    height: 170.0,
                                  ),
                                ),
                                Positioned(
                                  bottom: 20.0,
                                  right: 20.0,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 2.0,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.8),
                                          blurRadius: 8.0,
                                          spreadRadius: 4.0,
                                          offset: Offset(0.0, 4.0),
                                        ),
                                      ],
                                    ),
                                    child: CircleAvatar(
                                      backgroundImage: NetworkImage(
                                        business.UserImgUrl,
                                      ),
                                      radius: 28.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  business.businessName,
                                  style: ralewayStyle.copyWith(
                                    fontSize: 16.0,
                                    color: AppColors.blueDarkColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                                SizedBox(height: 8.0),
                                Text(
                                  business.executiveSummary,
                                  style: ralewayStyle.copyWith(
                                    fontSize: 16.0,
                                    color: AppColors.greyColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                                SizedBox(height: 8.0),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '\$'+business.fundAmount,
                                      style: ralewayStyle.copyWith(
                                        fontSize: 18.0,
                                        color: AppColors.blueDarkColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Wrap(
                                      children: business.industryFocus.map((industry) => Container(
                                        margin: EdgeInsets.only(right: 10),
                                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: AppColors.lightBlueColor,
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                        child: Text(
                                          industry,
                                          style: ralewayStyle.copyWith(
                                            fontSize: 16.0,
                                            color: AppColors.blueDarkColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      )).toList(),
                                    )
                                  ],
                                ),
                                SizedBox(height: 8.0),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ]
    );
  }
}