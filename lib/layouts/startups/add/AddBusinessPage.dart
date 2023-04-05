import 'package:flutter/material.dart';
import 'package:pitchboxadmin/appcolors.dart';

class AddIndustryPage extends StatefulWidget {
  const AddIndustryPage({Key? key}) : super(key: key);

  @override
  State<AddIndustryPage> createState() => _AddIndustryPageState();
}

class _AddIndustryPageState extends State<AddIndustryPage> {
  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Business List'),
          backgroundColor: AppColors.mainBlueColor,
          centerTitle: true,
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search',
                  suffixIcon: IconButton(
                    onPressed: () => _searchController.clear(),
                    icon: Icon(Icons.clear),
                  ),
                ),
              ),
            ),
            Flexible(
              child: ListView.builder(
                itemCount: 20, // replace with actual user data length
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('User $index'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

}
