import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'horizontalDateSelector.dart';

class Calendar extends StatefulWidget {
  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  final user = FirebaseAuth.instance.currentUser;

  DateTime selectedDate = DateTime.now();
  String get formattedSelectedDate => DateFormat('yyyy-MM-dd').format(selectedDate);


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange.shade800,
        title: Text('Calendar', style: TextStyle(color: Colors.white, fontSize: 24)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(formattedSelectedDate, style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),

              HorizontalDateSelector(
                onDateSelected: (date) {
                  setState(() {
                    selectedDate = date;
                  });
                },
              ),

              SizedBox(height: 30),
              Text(
                "Pills for ${DateFormat('dd MMM yyyy').format(selectedDate)}",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),

              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection(user!.uid)
                    .doc("Medicine")
                    .collection("pills")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Text("No medicines available.");
                  }

                  final docs = snapshot.data!.docs;


                  final pillsForDate = docs.where((doc) {
                    try {
                      final List<dynamic> dates = doc.data()["Dates"] ?? [];
                      return dates.contains(formattedSelectedDate);
                    } catch (e) {
                      return false;
                    }
                  }).toList();

                  if (pillsForDate.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Text("No pills scheduled for this date."),
                    );
                  }

                  return ListView.builder(
                    itemCount: pillsForDate.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final doc = pillsForDate[index];
                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 6),
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.orange.shade100,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.orange.shade400),
                        ),
                        child: Row(
                          children: [
                            Image.asset('assets/images/medicine_tablet1.png', width: 50, height: 50),
                            SizedBox(width: 12),
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
