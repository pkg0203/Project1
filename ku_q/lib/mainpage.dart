


import 'package:flutter/material.dart';
import 'package:ku_q/screens/homescreen.dart';
import 'package:ku_q/screens/mypagescreen.dart';
import 'package:ku_q/screens/pointshopscreen.dart';
import 'package:ku_q/screens/makequestionscreen.dart';
import 'package:ku_q/screens/recentquestionscreen.dart';
import 'package:ku_q/screens/surveyscreen.dart';



class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  int _selectedIndex = 2;

  List<BottomNavigationBarItem> bottomNavItems = [
    const BottomNavigationBarItem(
        icon: Icon(Icons.add_circle),
        label: '질문하기'
    ),
    const BottomNavigationBarItem(
        icon: Icon(Icons.add_chart),
        label: '설문조사'
    ),
    const BottomNavigationBarItem(
        icon: Icon(Icons.account_balance_rounded),
        label: '홈'
    ),
    const BottomNavigationBarItem(
        icon: Icon(Icons.add_business_sharp),
        label: '포인트샵'
    ),
    const BottomNavigationBarItem(
        icon: Icon(Icons.account_circle_rounded),
        label: '마이페이지'
    ),
  ];

  List screens = [
    RecentQuestionScreen(),
    SurveyScreen(),
    HomeScreen(),
    PointShopScreen(),
    MyPageScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: screens[_selectedIndex],

      bottomNavigationBar: BottomNavigationBar(
        items: bottomNavItems,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        selectedFontSize: 11,
        unselectedItemColor: Colors.grey,
        unselectedFontSize: 10,
        currentIndex: _selectedIndex,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        }
      ),
    );
  }
}
