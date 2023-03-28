import 'dart:ui';

import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:pitchboxadmin/appcolors.dart';
import 'package:pitchboxadmin/layouts/loan.dart';
import 'package:pitchboxadmin/layouts/profile.dart';
import 'package:pitchboxadmin/layouts/startups.dart';
import 'package:pitchboxadmin/layouts/users.dart';

class Dashboard extends StatefulWidget{
  @override
  State<Dashboard> createState() => _DashboardState();

}

class _DashboardState extends State<Dashboard> {
  int _currentIndex = 0;
  late PageController _pageController;

  final List<Widget> _pages = [    StarPage(),    LoanPage(),    UserPage(),    ProfilePage(),  ];

  @override
  void initState(){
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose(){
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: Navigator(
          onGenerateRoute: (settings) {
            return MaterialPageRoute(
              builder: (context) {
                return _pages[_currentIndex];
              },
            );
          },
        ),
        bottomNavigationBar: BottomNavyBar(
            selectedIndex: _currentIndex,
            onItemSelected:(index){
              setState(() {
                _currentIndex = index;
              });
            },
            items: <BottomNavyBarItem>[
              BottomNavyBarItem(
                  title: Text("Startups",
                  style: TextStyle(
                    color: AppColors.blueDarkColor,
                  ),
                  ),
                  icon: Icon(
                    Icons.account_balance_sharp,
                    color: AppColors.blueDarkColor,)
              ),
              BottomNavyBarItem(
                  title: Text("Loan",
                  style: TextStyle(
                    color: AppColors.blueDarkColor,
                  ),
                  ),
                  icon: Icon(
                    Icons.account_balance_wallet_outlined,
                    color: AppColors.blueDarkColor,)
              ),
              BottomNavyBarItem(
                  title: Text("Users",
                  style: TextStyle(
                    color: AppColors.blueDarkColor,
                  ),
                  ),
                  icon: Icon(
                    Icons.account_circle_outlined,
                    color: AppColors.blueDarkColor,)
              ),
              BottomNavyBarItem(
                  title: Text("Profile",
                  style: TextStyle(
                    color: AppColors.blueDarkColor,
                  ),
                  ),
                  icon: Icon(
                    Icons.account_box_outlined,
                    color: AppColors.blueDarkColor,)
              ),
            ]
        ),
      );


  }
}








