import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicine_reminder_flutter_app/res/routes/routes_name.dart';
import 'package:medicine_reminder_flutter_app/view/home_pages/add_medicine_view.dart';
import 'package:medicine_reminder_flutter_app/view/home_pages/calendar_view.dart';
import 'package:medicine_reminder_flutter_app/view/home_pages/home_screen.dart';
import 'package:medicine_reminder_flutter_app/res/colors/app_colors.dart';

class HomePage extends StatefulWidget{
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomeScreen(),
    AddMedicinePage(),
    CalendarView(),
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
        backgroundColor: AppColors.grey300,
        iconSize: 25,
        currentIndex: _currentIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
      onTap: (index) {
        if (index == 1) {

          Get.toNamed(RoutesName.addMedicinePage);

     } else {
          setState(() {
            _currentIndex = index;
          });
        }
      },
        selectedItemColor: AppColors.orange800,
        unselectedItemColor: AppColors.black87,

        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon:Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.orange800,
                      borderRadius: BorderRadius.circular(10),
                  ),
                 child:  Icon(Icons.add,color: AppColors.white,),
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