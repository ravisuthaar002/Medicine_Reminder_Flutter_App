import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Add_Medicine extends StatefulWidget{
  @override
  State<Add_Medicine> createState() => _Add_MedicineState();
}

class _Add_MedicineState extends State<Add_Medicine> {
    TextEditingController pillController = TextEditingController();

    String selectedDose = "0.5";
    String selectedShape = "Tablet";
    String selectedHour = "11";
    String selectedMinute = "30";
    String selectedPeriod = "AM";
    String selectedDays = "07";
    String selectedUsage = "After eat";



    List<Map<String, String>> timeList = [
      {"hour": "11", "minute": "30", "period": "AM"},
    ];

    final hours = ["01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12"];
    final minutes = ["00", "15", "30", "45"];
    final periods = ["AM", "PM"];



    adddata(String pill, String dose, String shape, String days, String usage) async {
      final user = FirebaseAuth.instance.currentUser;
      if (pill == "") {
        log("Enter Required Field");
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Please enter the medicine name"),
          backgroundColor: Colors.red,
        ));
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
        log("Data Inserted");
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Medicine Added Successfully"),
          backgroundColor: Colors.green,
        ));
      });
    }


    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white,size: 24),
        backgroundColor: Colors.orange.shade800,
        title: Text('Add Medicine',style: TextStyle(color: Colors.white,),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              SizedBox(height: 20,),
              Align(
                alignment: Alignment.center,
                  child: Image.asset('assets/images/medicine.avif',width: 200,height: 200,)),
              SizedBox(height: 20,),
              Container(
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Pill name',style: TextStyle(fontSize: 22),),
                    TextField(
                      controller: pillController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          hintText: "Enter the pill name",
                          filled: true,
                          fillColor: Colors.grey[300],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide:
                              BorderSide(width: 3, color: Colors.orange.shade800)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(width: 0, color: Colors.grey.shade300))
                      ),
                    ),
                    SizedBox(height: 20,),
                    Row(
                      children: [
                        Expanded(
                          child: _buildDropdown(label: "dose", value: selectedDose, items: ["0.5", "1", "2"],onChanged: (val) {setState(() {selectedDose = val!;});},),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: _buildDropdown(label: "shape", value: selectedShape, items: ["Capsule", "Tablet", "Liquid"],onChanged: (val) {setState(() {selectedShape = val!;});},),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
        
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Time", style: TextStyle(fontSize: 16)),
                            IconButton(
                              icon: Icon(Icons.add_circle, color: Colors.orange, size: 28),
                              onPressed: () {
                                setState(() {
                                  timeList.add({"hour": "11", "minute": "00", "period": "AM"});
                                });
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 7),
        
                        /// All time dropdowns
                        Column(
                          children: List.generate(timeList.length, (index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: Row(
                                children: [
        
                                  /// Hour
                                  _timeDropdown(
                                    value: timeList[index]["hour"]!,
                                    items: hours,
                                    onChanged: (val) {
                                      setState(() => timeList[index]["hour"] = val!);
                                    },
                                  ),
        
                                  Text(" : ", style: TextStyle(fontSize: 18)),
        
                                  /// Minute
                                  _timeDropdown(
                                    value: timeList[index]["minute"]!,
                                    items: minutes,
                                    onChanged: (val) {
                                      setState(() => timeList[index]["minute"] = val!);
                                    },
                                  ),
        
                                  SizedBox(width: 10),
        
                                  /// AM/PM
                                  _timeDropdown(
                                    value: timeList[index]["period"]!,
                                    items: periods,
                                    onChanged: (val) {
                                      setState(() => timeList[index]["period"] = val!);
                                    },
                                  ),
                                  SizedBox(width: 10),
        
                                  IconButton(
                                    icon: Icon(Icons.delete, color: Colors.red),
                                    onPressed: () {
                                      setState(() {
                                        timeList.removeAt(index);
                                      });
                                    },
                                  ),
                                ],
                              ),
                            );
                          }),
                        ),
        
                      ],
                    ),
                    SizedBox(height: 12),
        
                    Text("How to use", style: TextStyle(fontSize: 16,)),
                    SizedBox(height: 6),
                    Row(
                      children: [
                        Expanded(child: _buildDropdown(label: "days", value: selectedDays, items: ["01", "03", "05", "07", "15", "20", "25", "30"],onChanged: (val) {setState(() {selectedDays = val!;});})),
                        SizedBox(width: 12),
                        Expanded(child: _buildDropdown(label: "", value: selectedUsage, items: ["Before eat", "After eat"],onChanged: (val) {setState(() {selectedUsage = val!;});})),
                      ],
                    ),
                    SizedBox(height: 50,),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
        
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)
                            ),
                              backgroundColor: Colors.orange.shade800,
                              padding: EdgeInsets.symmetric(vertical: 7)),
                          onPressed: () {
                                adddata(pillController.text.toString(),selectedDose,selectedShape,selectedDays,selectedUsage);
                                pillController.clear();
                            },
                          child: Text("Add Medicine",style: TextStyle(fontSize: 22,color: Colors.white)),
                        ),
                    ),
        
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
              .map((e) => DropdownMenuItem(child: Text(e), value: e))
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
          color: Colors.grey[200],
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