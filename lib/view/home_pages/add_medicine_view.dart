import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:medicine_reminder_flutter_app/res/font_size/app_font_size.dart';
import 'package:medicine_reminder_flutter_app/view_modal/controller/home_pages/add_medicine_view_modal.dart';

import '../../res/colors/app_colors.dart';

class AddMedicinePage extends StatefulWidget{
  const AddMedicinePage({super.key});

  @override
  State<AddMedicinePage> createState() => _AddMedicinePageState();
}

class _AddMedicinePageState extends State<AddMedicinePage> {

  final addMedicineViewModal = AddMedicineViewModal();


    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.white,size: AppFontSize.mediumPlus),
        backgroundColor: AppColors.orange800,
        title: Text('Add Medicine',style: TextStyle(color: AppColors.white,),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              SizedBox(height: Get.height * .02,),
              Align(
                alignment: Alignment.center,
                  child: Image.asset('assets/images/medicine.avif',width: 200,height: 200,)),
              SizedBox(height: Get.height * .02,),
              Container(
                color: AppColors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Pill name',style: TextStyle(fontSize: AppFontSize.medium),),
                    TextField(
                      controller: addMedicineViewModal.pillController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          hintText: "Enter the pill name",
                          filled: true,
                          fillColor: AppColors.grey300,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide:
                              BorderSide(width: 3, color: AppColors.orange800)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(width: 0, color: AppColors.grey300))
                      ),
                    ),
                    SizedBox(height: Get.height * .02,),
                    Row(
                      children: [
                        Expanded(
                          child: _buildDropdown(label: "dose", value: addMedicineViewModal.selectedDose.value, items: ["0.5", "1", "2"],onChanged: (val) {setState(() {addMedicineViewModal.selectedDose.value = val!;});},),
                        ),
                        SizedBox(width: Get.width * .012),
                        Expanded(
                          child: _buildDropdown(label: "shape", value: addMedicineViewModal.selectedShape.value, items: ["Capsule", "Tablet", "Liquid"],onChanged: (val) {setState(() {addMedicineViewModal.selectedShape.value = val!;});},),
                        ),
                      ],
                    ),
                    SizedBox(height: Get.height * .012),
        
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Time", style: TextStyle(fontSize: AppFontSize.small)),
                            IconButton(
                              icon: Icon(Icons.add_circle, color: AppColors.orange, size: 28),
                              onPressed: () {
                                setState(() {
                                  addMedicineViewModal.timeList.add({"hour": "11", "minute": "00", "period": "AM"});
                                });
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: Get.height * .007),
        
                        /// All time dropdowns
                        Column(
                          children: List.generate(addMedicineViewModal.timeList.length, (index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: Row(
                                children: [
        
                                  /// Hour
                                  Obx(()=>  _timeDropdown(
                                    value: addMedicineViewModal.timeList[index]["hour"]!,
                                    items: addMedicineViewModal.hours.value,
                                    onChanged: (val) {
                                    addMedicineViewModal.timeList[index]["hour"] = val!;
                                    },
                                  )),
        
                                  Text(" : ", style: TextStyle(fontSize: 18)),
        
                                  /// Minute
                                   Obx(()=> _timeDropdown(
                                    value: addMedicineViewModal.timeList[index]["minute"]!,
                                    items: addMedicineViewModal.minutes.value,
                                    onChanged: (val) {
                                      addMedicineViewModal.timeList[index]["minute"] = val!;
                                    },
                                  )),
        
                                  SizedBox(width: Get.width * .01),
        
                                  /// AM/PM
                                  Obx(()=> _timeDropdown(
                                    value: addMedicineViewModal.timeList[index]["period"]!,
                                    items: addMedicineViewModal.periods.value,
                                    onChanged: (val) {
                                      addMedicineViewModal.timeList[index]["period"] = val!;
                                    },
                                  )),
                                  SizedBox(width: Get.width * .01),
        
                                  Obx(()=> IconButton(
                                    icon: Icon(Icons.delete, color: Colors.red),
                                    onPressed: () {
                                        addMedicineViewModal.timeList.removeAt(index);
                                    },
                                  )),
                                ],
                              ),
                            );
                          }),
                        ),
        
                      ],
                    ),
                    SizedBox(height: Get.height * .01),
        
                    Text("How to use", style: TextStyle(fontSize: 16,)),
                    SizedBox(height: Get.height * .006),
                    Row(
                      children: [
                        Expanded(child: _buildDropdown(label: "days", value: addMedicineViewModal.selectedDays.value, items: ["01", "03", "05", "07", "15", "20", "25", "30"],onChanged: (val) {setState(() {addMedicineViewModal.selectedDays.value = val!;});})),
                        SizedBox(width: Get.width * .012),
                        Expanded(child: _buildDropdown(label: "", value: addMedicineViewModal.selectedUsage.value, items: ["Before eat", "After eat"],onChanged: (val) {setState(() {addMedicineViewModal.selectedUsage.value = val!;});})),
                      ],
                    ),
                    SizedBox(height: Get.height * .03,),
                    Obx(()=> SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
        
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)
                            ),
                              backgroundColor: AppColors.orange800,
                              padding: EdgeInsets.symmetric(vertical: 7)),
                          onPressed: () {
                                addMedicineViewModal.addData(addMedicineViewModal.pillController.text.toString(),addMedicineViewModal.selectedDose.value,addMedicineViewModal.selectedShape.value,addMedicineViewModal.selectedDays.value,addMedicineViewModal.selectedUsage.value);
                                addMedicineViewModal.pillController.clear();
                            },
                          child: addMedicineViewModal.loading.value ?
                          CircularProgressIndicator(color: AppColors.white,) :
                          Text("Add Medicine",style: TextStyle(fontSize: AppFontSize.medium,color: AppColors.white)),
                        ),
                    )),
        
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      
    );
  }
    Widget _buildDropdown({required String label, required String value, required List<String> items, required void Function(String?) onChanged,}) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
        ),
        child: DropdownButtonFormField<String>(
          decoration: InputDecoration(
            labelText: label.isNotEmpty ? label : null,
            border: InputBorder.none,
          ),
          value: value,
          items: items
              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
              .toList(),
          onChanged: onChanged,  // <-- Call it here
        ),
      );
    }

    Widget _timeDropdown({
      required String value,
      required List<String> items,
      required void Function(String?) onChanged,
    }) {
      return Container(
        margin: EdgeInsets.only(right: 10),
        padding: EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: AppColors.grey300,
          borderRadius: BorderRadius.circular(12),
        ),
        child: DropdownButton<String>(
          value: value,
          onChanged: onChanged,
          underline: SizedBox(),
          items: items.map((item) {
            return DropdownMenuItem(value: item, child: Text(item));
          }).toList(),
        ),
      );
    }
}