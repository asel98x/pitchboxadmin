import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pitchboxadmin/appcolors.dart';
import 'package:pitchboxadmin/backend/controller/IndustryController.dart';
import 'package:pitchboxadmin/backend/model/industry.dart';
import 'package:pitchboxadmin/layouts/startups/add/AddNewBusinessPage.dart';
import 'package:pitchboxadmin/layouts/startups/tabs/industryTab.dart';
import 'package:pitchboxadmin/layouts/startups/tabs/startupTab.dart';
import 'package:pitchboxadmin/layouts/users/tabs/investorTab.dart';
import 'package:image_picker/image_picker.dart';

class BusinessPage extends StatefulWidget {
  const BusinessPage({Key? key});

  @override
  State<BusinessPage> createState() => _BusinessPageState();
}

class _BusinessPageState extends State<BusinessPage> with SingleTickerProviderStateMixin{
  final _formKey = GlobalKey<FormState>();
  late TabController controller;
  final IndustryController _industryController = IndustryController();
  TextEditingController _nameController = TextEditingController();
  File? _imageFile;


  @override
  void initState(){
    super.initState();
    controller = TabController(length: 2, vsync: this);
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

  void clear(){
    _nameController.text = "";
  }

  void _showAddDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        bool _isUploading = false;
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Stack(
              children: [
                AlertDialog(
                  key: _formKey,
                  title: Text('Add Industry'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          labelText: 'Enter Industry name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter Industry name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20.0),
                      _imageFile != null
                          ? Image.file(
                        _imageFile!,
                        height: 100.0,
                        width: 100.0,
                      )
                          : Container(),
                      ElevatedButton(
                        onPressed: () async {
                          final pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);
                          setState(() {
                            if (pickedFile != null) {
                              _imageFile = File(pickedFile.path);
                            }
                          });
                        },
                        child: Text('Add Image'),
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Cancel'),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        String name = _nameController.text;
                        File? image = _imageFile;
                        setState(() {
                          _isUploading = true;
                        });
                        await IndustryController().addIndustry(name, image, context);

                        setState(() {
                          _isUploading = false;
                        });
                        // Reset the dialog
                        _nameController.clear();
                        setState(() {
                          _imageFile = null;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Industry added successfully!'),
                          ),
                        );
                        clear();
                      },
                      child: Text('Add'),
                    ),
                  ],
                ),
                _isUploading
                    ? Container(
                  color: Colors.grey.withOpacity(0.5),
                )
                    : Container(),
                _isUploading
                    ? Center(
                  child: CircularProgressIndicator(),
                )
                    : Container(),
              ],
            );
          },
        );
      },
    );




  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: AppColors.blueDarkColor, // Set status bar color
    ));
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Container(
          color: Colors.grey[200], // set the background color to gray
          child: Scaffold(
            appBar: AppBar(
              title: Text('P I T C H B O X'),
              backgroundColor: AppColors.mainBlueColor,
              bottom: TabBar(
                controller: controller,
                tabs: [
                  Tab(text: 'Startup'),
                  Tab(text: 'Industry'),
                ],
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: TabBarView(
                    controller: controller,
                    children: [
                      StartupTab(),
                      IndustryTab(),
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
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => AddBusinessPage()),
                  );
                } else if (controller.index == 1) {
                  _showAddDialog(context);
                }
              },
            ),
          ),
        ),
      ),
    );
  }


}
