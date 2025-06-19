import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medicine_reminder_flutter_app/threeline_menu_page.dart';

class Home_Screen extends StatefulWidget {
  @override
  State<Home_Screen> createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<Home_Screen> {
  final user = FirebaseAuth.instance.currentUser;



  String? nextPillName = '';
  String? nextPillTime = '';
  bool isNextPillSet = false;
  bool nextPillCalculated = false;



  void findNextPill(QuerySnapshot<Map<String, dynamic>> snapshot) {
    DateTime now = DateTime.now();
    DateFormat timeFormat = DateFormat('hh:mm a');

    DateTime? nextTime;
    String? nextPill;
    String? nextTimeStr;

    for (var doc in snapshot.docs) {
      List times = doc["Times"];

      for (var timeStr in times) {
        try {
          DateTime pillTime = timeFormat.parse(timeStr);
          pillTime = DateTime(now.year, now.month, now.day, pillTime.hour, pillTime.minute);

          if (pillTime.isAfter(now)) {
            if (nextTime == null || pillTime.isBefore(nextTime)) {
              nextTime = pillTime;
              nextPill = doc["Pill"];
              nextTimeStr = timeStr;
            }
          }
        } catch (e) {
          print("Time parse error: $e");
        }
      }
    }

    setState(() {
      if (nextPill != null) {
        nextPillName = nextPill!;
        nextPillTime = nextTimeStr!;
      } else {
        nextPillName = "No more pills today";
        nextPillTime = "";
      }
    });
  }


  @override
  void initState() {
    super.initState();

    FirebaseFirestore.instance
        .collection(user!.uid)
        .doc("Medicine")
        .collection("pills")
        .get()
        .then((snapshot){
      findNextPill(snapshot);
      fetchUserName();

    });
  }

  String? _name;

  void fetchUserName() async {
    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection(user!.uid)
          .doc("user_data")
          .get();

      setState(() {
        _name = userDoc['Name'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd MMMM').format(now);



    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Profile Section
              Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.grey,
                    child: Icon(Icons.person, size: 40, color: Colors.white),
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Hii ${_name ?? '...'}!', style: TextStyle(fontSize: 24)),
                      Text('How do you feel today?', style: TextStyle(fontSize: 14)),
                    ],
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ThreeLine_Menu_Page()),
                      );
                    },
                    icon: Icon(Icons.menu, size: 30, color: Colors.orange.shade800),
                  ),
                ],
              ),

              SizedBox(height: 30),
              Text(formattedDate, style: TextStyle(fontSize: 14)),
              Text("Your Next Pill", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Text(
                nextPillName == "" ? "Loading next pill..." : "Next Pill: $nextPillName at $nextPillTime",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.teal),
              ),

              SizedBox(height: 30),
              Text("All Medicines", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),

              StreamBuilder(
                stream: FirebaseFirestore.instance.collection(user!.uid).doc("Medicine").collection("pills").snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(child: Text("No Data Found"));
                  }

                  var docs = snapshot.data!.docs;

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: docs.length,
                    itemBuilder: (context, index) {
                      var doc = docs[index];
                      bool isNextPill = doc["Pill"] == nextPillName;

                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: isNextPill ? Colors.green.shade100 : Colors.orange.shade200,
                          borderRadius: BorderRadius.circular(15),
                          border: isNextPill
                              ? Border.all(color: Colors.green, width: 2)
                              : Border.all(color: Colors.transparent),
                        ),
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/images/medicine_tablet1.png',
                              width: 50,
                              height: 50,
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(doc["Pill"], style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                  SizedBox(height: 4),
                                  Text("Dose: ${doc["Dose"]} - ${doc["Usage"]}", style: TextStyle(fontSize: 14)),
                                  Text(
                                    "Time: ${(doc["Times"] as List).join(", ")}",
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                            PopupMenuButton<String>(
                              onSelected: (value) {
                                if (value == 'info') {
                                  showDialog(
                                    context: context,
                                    builder: (_) => AlertDialog(
                                      title: Text("More Information"),
                                      content: Text(
                                          "Pill: ${doc["Pill"]}\nDose: ${doc["Dose"]}\nShape: ${doc["Shape"]}\nDays: ${doc["Days"]}\nUsage: ${doc["Usage"]}\nTimes: ${(doc["Times"] as List).join(", ")}"),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Navigator.pop(context),
                                          child: Text("Close"),
                                        )
                                      ],
                                    ),
                                  );
                                } else if (value == 'delete') {
                                  FirebaseFirestore.instance
                                      .collection(user!.uid)
                                      .doc("Medicine")
                                      .collection("pills")
                                      .doc(doc.id)
                                      .delete();
                                }
                              },
                              itemBuilder: (context) => [
                                PopupMenuItem(value: 'info', child: Text('More Information')),
                                PopupMenuItem(value: 'delete', child: Text('Delete')),
                              ],
                              icon: Icon(Icons.more_vert),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

}
