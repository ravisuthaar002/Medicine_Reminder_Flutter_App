


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomeScreenVieModal extends GetxController{
  RxString? nextPillName = ''.obs;
  RxString? nextPillTime = ''.obs;
  RxBool isNextPillSet = false.obs;
  RxBool nextPillCalculated = false.obs;



  void findNextPill(QuerySnapshot<Map<String, dynamic>> snapshot) {
    DateTime now = DateTime.now();
    DateFormat timeFormat = DateFormat('hh:mm a');

    DateTime? nextTime;
    RxString? nextPill;
    RxString? nextTimeStr;

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

    if (nextPill != null) {
      nextPillName = nextPill!;
      nextPillTime = nextTimeStr!;
    } else {
      nextPillName?.value = "No more pills today";
      nextPillTime?.value = "";
    }
  }


}