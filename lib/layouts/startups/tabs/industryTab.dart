import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
  final TextEditingController _searchController = TextEditingController();
  List<Industry> _industries = [];
  List<Industry> _filteredIndustries = [];
  TextEditingController _nameController = TextEditingController();
  File? _imageFile;

  @override
  void initState() {
    super.initState();
    _getIndustries();

  }

  void _getIndustries() async {
    List<Industry> industries = await _industryController.getIndustries();
    setState(() {
      _industries = industries;
      _filteredIndustries = industries;
    });
  }

  void _filterIndustries(String query) {
    List<Industry> filteredIndustries = _industries
        .where((industry) =>
        industry.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    setState(() {
      _filteredIndustries = filteredIndustries;
    });
  }

  Future<void> _handleRefresh() async {
    _getIndustries();
  }

  void _showIndustryDetailsDialog(BuildContext context, Industry industry) {
    GlobalKey _imageKey = GlobalKey();
    //File? _imageFile;

    Future<void> _pickImage(ImageSource source) async {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: source);
      if (pickedFile != null) {
        setState(() {
          _imageFile = File(pickedFile.path);
          _imageKey = GlobalKey(); // create a new key to force a rebuild
        });
      }
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        _nameController.text = industry.name;
        return AlertDialog(
          title: Text('Industry Information'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () {
                  if (_imageFile == null) {
                    _pickImage(ImageSource.gallery);
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Change Image'),
                          content: Text('Do you want to change the image?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                _pickImage(ImageSource.gallery);
                              },
                              child: Text('Change'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                child: Container(
                  key: _imageKey, // add the key to the Container widget
                  width: double.infinity,
                  height: 150,
                  decoration: BoxDecoration(
                    image: _imageFile == null
                        ? DecorationImage(
                      image: NetworkImage(industry.imgUrl),
                      fit: BoxFit.cover,
                    )
                        : DecorationImage(
                      image: FileImage(_imageFile!),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: _imageFile == null
                      ? Icon(
                    Icons.photo,
                    color: Colors.white,
                    size: 40,
                  )
                      : null,
                ),
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: _nameController,
                //initialValue: industry.name,
                decoration: InputDecoration(
                  labelText: 'Industry Name',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 8),
              ElevatedButton(
                onPressed: () async {
                  String id = industry.id;
                  String name = _nameController.text;
                  File? img = _imageFile;
                  print('id'+id);
                  await _industryController.updateIndustry(id, name, img,industry.imgUrl);
                  _imageFile = null;
                  print('object');
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Industry updated successfully!'),
                    ),
                  );
                },
                child: Text('Update'),
              ),
            ],
          ),
        );
      },
    );
  }





  void _showDeleteConfirmationDialog(BuildContext context, Industry industry) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Delete'),
          content: Text('Are you sure you want to delete ${industry.name}?'),
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
        _industryController.deleteIndustry(industry.id);
        // Refresh the list after deletion
        _handleRefresh();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Industry deleted successfully!'),
          ),
        );
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
              labelText: 'Search Industry',
              hintText: 'Enter an industry name',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            onChanged: (value) {
              _filterIndustries(value);
            },
          ),
        ),
        Expanded(
          child: RefreshIndicator(
            onRefresh: _handleRefresh,
            child: _filteredIndustries.isEmpty
                ? Center(
              child: Text('No industries found'),
            )
                : ListView.builder(
              itemCount: _filteredIndustries.length,
              itemBuilder: (context, index) {
                Industry industry = _filteredIndustries[index];
                return GestureDetector(
                  onTap: () {
                    _showIndustryDetailsDialog(context, industry);
                  },
                  onLongPress: () {
                    _showDeleteConfirmationDialog(context, industry);
                  },
                  child: Card(
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
