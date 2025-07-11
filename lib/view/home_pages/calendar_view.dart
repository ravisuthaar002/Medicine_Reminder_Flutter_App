import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:medicine_reminder_flutter_app/res/font_size/app_font_size.dart';
import 'package:medicine_reminder_flutter_app/view_modal/controller/home_pages/calendar_view_modal.dart';
import '../../res/colors/app_colors.dart';
import 'horizontalDateSelector_view.dart';

class CalendarView extends StatefulWidget {
  const CalendarView({super.key});

  @override
  State<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  final user = FirebaseAuth.instance.currentUser;

  final calendarViewModal = Get.put(CalendarViewModal());



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.orange800,
        title: Text('Calendar', style: TextStyle(color: AppColors.white, fontSize: AppFontSize.mediumPlus)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() => Text(
                  DateFormat('yyyy-MM-dd').format(calendarViewModal.selectedDate.value),
                  style: TextStyle(fontSize: AppFontSize.smallPlus))),

              SizedBox(height: Get.height * .02),

              Obx(() => HorizontalDateSelector(
                selectedDate: calendarViewModal.selectedDate.value,
                onDateSelected: (date) {
                  calendarViewModal.selectedDate.value = date;
                },
              )),



              SizedBox(height: Get.height * .02),
              Obx(() => Text(
                "Pills for ${DateFormat('dd MMM yyyy').format(calendarViewModal.selectedDate.value)}",
                style: TextStyle(fontSize: AppFontSize.medium, fontWeight: FontWeight.bold),
              )),
              SizedBox(height: Get.height * .01),

              Obx(() {
                final selectedDateStr = DateFormat('yyyy-MM-dd').format(calendarViewModal.selectedDate.value);

                return StreamBuilder(
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
                      final dates = List<String>.from(doc.data()["Dates"] ?? []);
                      return dates.contains(selectedDateStr);
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
                            color: AppColors.orange100,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppColors.orange400),
                          ),
                          child: Row(
                            children: [
                              Image.asset('assets/images/medicine_tablet1.png', width: 50, height: 50),
                              SizedBox(width: Get.height * .01),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(doc["Pill"], style: TextStyle(fontSize: AppFontSize.smallPlus, fontWeight: FontWeight.bold)),
                                    SizedBox(height: Get.height * .002),
                                    Text("Dose: ${doc["Dose"]} - ${doc["Usage"]}", style: TextStyle(fontSize: AppFontSize.small)),
                                    Text(
                                      "Time: ${(doc["Times"] as List).join(", ")}",
                                      style: TextStyle(fontSize: AppFontSize.small),
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
                );
              }),





            ],
          ),
        ),
      ),
    );
  }
}
