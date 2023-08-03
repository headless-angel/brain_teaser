import 'package:brain_teaser/screen/homes_screen.dart';
import 'package:brain_teaser/screen/question_page/add_questions.dart';
import 'package:brain_teaser/screen/scorescreen.dart';
import 'package:brain_teaser/util/constant.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int currentIndex = 0;

  List<Widget> listScreen = [
    HomeScreen(),
    AddQuestionPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: listScreen,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        backgroundColor: Colors.white,
        selectedItemColor: kItemSelectBottomNav,
        elevation: 5.0,
        unselectedItemColor: kItemUnSelectBottomNav,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: <BottomNavigationBarItem>[
          _buildItemBottomNav(FontAwesomeIcons.home, "Home"),
          _buildItemBottomNav(FontAwesomeIcons.history, "Point")
        ],
      ),
    );
  }

  _buildItemBottomNav(IconData icon, String title) {
    return BottomNavigationBarItem(icon: Icon(icon), label: title
        //  Text(
        //   title,
        //   style: TextStyle(fontWeight: FontWeight.bold),
        // ),
        );
  }
}
