import 'package:flutter/material.dart';
import 'package:pitchboxadmin/appcolors.dart';
import 'package:pitchboxadmin/appstyles.dart';
import 'package:pitchboxadmin/backend/controller/IndustryController.dart';
import 'package:pitchboxadmin/backend/model/industry.dart';

class IndustryTab extends StatefulWidget {
  @override
  _IndustryTabState createState() => _IndustryTabState();
}

class _IndustryTabState extends State<IndustryTab> {
  final _industryController = IndustryController();

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _handleRefresh,
      child: FutureBuilder<List<Industry>>(
        future: _industryController.getIndustries(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Industry> industries = snapshot.data!;
            return ListView.builder(
              itemCount: industries.length,
              itemBuilder: (context, index) {
                Industry industry = industries[index];
                return Card(
                  child: Column(
                    children: [
                      SizedBox(height: 8),
                      Image.network(
                        industry.imgUrl,
                        width: double.infinity,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(height: 8),
                      Text(
                        industry.name,
                        style: ralewayStyle.copyWith(
                          fontSize: 18.0,
                          color: AppColors.textColor,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      SizedBox(height: 10),
                    ],

                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text("Error loading industries: ${snapshot.error}");
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Future<void> _handleRefresh() async {
    await _industryController.getIndustries();
  }

}
