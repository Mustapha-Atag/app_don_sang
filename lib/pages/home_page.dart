import 'dart:async';
import 'dart:ui';
// flutter packages
import 'package:app_don_0/pages/rdvPage/rdv_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

// local imports
import './collectePage/collectes_page.dart';
import './profilePage/profile_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0; // of navigationBar

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _homePageBody(context, _currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 12,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        elevation: 20,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.location_pin), label: "Collectes"),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month), label: "Mes RDV"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile")
        ],
      ),
    );
  }

  // content of the home page
  Widget _homePageBody(BuildContext context, int index) {
    if (index == 0) {
      // les Collectes
      return const CollectesPage();
    } else if (index == 1) {
      // mes RDV
      return const RdvPage();
    } else if (index == 2) {
      // Profile
      return const ProfilePage();
    } else {
      return Container();
    }
  }
}
