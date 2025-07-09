


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:medicine_reminder_flutter_app/utils/utils.dart';

class AddMedicineViewModal extends GetxController{
  final pillController = TextEditingController();

  RxString selectedDose = "0.5".obs;
  RxString selectedShape = "Tablet".obs;
  RxString selectedHour = "11".obs;
  RxString selectedMinute = "30".obs;
  RxString selectedPeriod = "AM".obs;
  RxString selectedDays = "07".obs;
  RxString selectedUsage = "After eat".obs;

  RxBool loading = false.obs;

  RxList<Map<String, String>> timeList = [
    {"hour": "11", "minute": "30", "period": "AM"},
  ].obs;

  RxList<String> hours = <String>["01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12"].obs;
  RxList<String> minutes = <String>["00", "15", "30", "45"].obs;
  RxList<String> periods = <String>["AM", "PM"].obs;



  addData(String pill, String dose, String shape, String days, String usage) async {
    loading.value = true;
    final user = FirebaseAuth.instance.currentUser;
    if (pill == "") {
      loading.value = false;
      Utils.toastMessageTopRed("Please enter the medicine name");
      return;
    }

    List<String> timeFormattedList = timeList.map((time) {
      return "${time['hour']}:${time['minute']} ${time['period']}";
    }).toList();


    List<String> dateList = [];
    DateTime today = DateTime.now();
    int totalDays = int.tryParse(days) ?? 0;
    for (int i = 0; i < totalDays; i++) {
      final futureDate = today.add(Duration(days: i));
      dateList.add(DateFormat('yyyy-MM-dd').format(futureDate));
    }

    await FirebaseFirestore.instance
        .collection(user!.uid)
        .doc("Medicine")
        .collection("pills")
        .doc(pill)
        .set({
      "Pill": pill,
      "Dose": dose,
      "Shape": shape,
      "Days": days,
      "Usage": usage,
      "Times": timeFormattedList,
      "Dates": dateList,
    }).then((value) {
      loading.value = false;
      Utils.toastMessageTopGreen("Medicine Added Successfully");
    });
  }
}