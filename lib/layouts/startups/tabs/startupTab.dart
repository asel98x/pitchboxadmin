import 'package:flutter/material.dart';
import 'package:pitchboxadmin/backend/controller/businessController.dart';
import 'package:pitchboxadmin/backend/model/business.dart';

class StartupTab extends StatefulWidget {
  const StartupTab({Key? key}) : super(key: key);

  @override
  _StartupTabState createState() => _StartupTabState();
}

class _StartupTabState extends State<StartupTab> {
  final BusinessController _controller = BusinessController();

  List<Business> _businessList = [];

  @override
  void initState() {
    super.initState();
    _loadBusinessList();
  }

  Future<void> _loadBusinessList() async {
    List<Business> businessList = await _controller.getNewBusinesses();
    setState(() {
      _businessList = businessList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _businessList.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: _businessList.length,
        itemBuilder: (context, index) {
          Business business = _businessList[index];
          return Card(
            child: ListTile(
              onTap: () {
                //Navigator.push(context, MaterialPageRoute(builder: (context) => BusinessListPage(business: business,),));
              },
              title: Text(business.businessIndustry),
              subtitle: Text(business.businessName),
            ),
          );
        },
      ),
    );
  }
}