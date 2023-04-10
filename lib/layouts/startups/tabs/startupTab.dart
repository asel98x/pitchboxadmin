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
                          MaterialPageRoute(builder: (context) => updateBusinessPage()),
                        );
                      },
                      onLongPress: () {
                        _showDeleteConfirmationDialog(context, business);
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
                                    child: Image.asset(
                                      'assets/images/DryFoodsComp.jpg',
                                      fit: BoxFit.cover,
                                      height: 125.0,
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0.0,
                                    right: 0.0,
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
                                        backgroundImage: AssetImage(
                                          'assets/images/RyanReynolds-2019_r.jpg',
                                        ),
                                        radius: 28.0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    style: ralewayStyle.copyWith(
                                      fontSize: 20,
                                      color: AppColors.greyColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    business.businessName,
                                    textAlign: TextAlign.justify,
                                  ),
                                  SizedBox(height: 8.0),
                                  Text(
                                    business.businessName,
                                    style: ralewayStyle.copyWith(
                                      fontSize: 16.0,
                                      color: AppColors.blueDarkColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.justify,
                                  ),
                                  SizedBox(height: 16.0),
                                  Text(
                                    'Over 150M in Lifetime Revenue and 4M+ games sold through DTC, Target, Walmart and Amazon',
                                    style: ralewayStyle.copyWith(
                                      fontSize: 16.0,
                                      color: AppColors.greyColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    textAlign: TextAlign.justify,
                                  ),
                                  SizedBox(height: 16.0),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '\$66,000',
                                        style: ralewayStyle.copyWith(
                                          fontSize: 22.0,
                                          color: AppColors.blueDarkColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        'Text 1',
                                        style: TextStyle(
                                          fontSize: 16.0,
                                        ),
                                      ),
                                      Text(
                                        'Text 2',
                                        style: TextStyle(
                                          fontSize: 16.0,
                                        ),
                                      ),
                                      Text(
                                        'Text 3',
                                        style: TextStyle(
                                          fontSize: 16.0,
                                        ),
                                      ),
                                    ],
                                  ),
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
