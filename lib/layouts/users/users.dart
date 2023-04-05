import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pitchboxadmin/layouts/users/tabs/entrepreneurTab.dart';
import 'package:pitchboxadmin/layouts/users/tabs/investorTab.dart';
import 'tabs/adminTab.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> with SingleTickerProviderStateMixin{
  late TabController controller;

  @override
  void initState(){
    super.initState();
    controller = TabController(length: 3,vsync: this);
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

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text('Tab ${controller.index + 1}'),
          centerTitle: true,
          backgroundColor: Color(0xff005BE0),
          bottom: TabBar(
            controller: controller,
            tabs: [
              Tab(text: 'Entrepreneur'),
              Tab(text: 'Investor'),
              Tab(text: 'Admin'),
            ],
          ),
        ),
        body: TabBarView(
          controller: controller,
          children: [
            EntrepreneurTab(),
            InvestorTab(),
            AdminTab(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add, size: 32,),
          onPressed: (){
            controller.animateTo(2);
          },
        ),
      );

  }
}
