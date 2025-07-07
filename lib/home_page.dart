import 'package:flutter/material.dart';
import 'package:medicine_reminder_flutter_app/add_medicine.dart';
import 'package:medicine_reminder_flutter_app/calendar.dart';
import 'package:medicine_reminder_flutter_app/home_screen.dart';

class HomePage extends StatefulWidget{
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _currentIndex = 0;

  final List<Widget> _pages = [
    Home_Screen(),
    Add_Medicine(),
    Calendar(),
  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      _pages[_currentIndex],
      bottomNavigationBar : ClipRRect(
      borderRadius: BorderRadius.circular(50),
    child: BottomNavigationBar(
      elevation: 1 ,
        backgroundColor: Colors.grey.shade300,
        iconSize: 35,
        currentIndex: _currentIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
      onTap: (index) {
        if (index == 1) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Add_Medicine()),
          );
        } else {
          setState(() {
            _currentIndex = index;
          });
        }
      },
        selectedItemColor: Colors.orange.shade800,
        unselectedItemColor: Colors.black87,

        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon:Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade800,
                      borderRadius: BorderRadius.circular(20),
                  ),
                 child:  Icon(Icons.add,color: Colors.white,),
            ),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_outlined,),
            label: 'Profile',
          ),
        ],
      ),
      ),
    );
  }
}