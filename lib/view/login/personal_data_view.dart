

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:medicine_reminder_flutter_app/res/colors/app_colors.dart';
import 'package:medicine_reminder_flutter_app/res/font_size/app_font_size.dart';
import 'package:medicine_reminder_flutter_app/view_modal/controller/login/presonal_data_view_modal.dart';

class PersonalDataPage extends StatefulWidget {
  const PersonalDataPage({super.key});

  @override
  State<PersonalDataPage> createState() => _PersonalDataPageState();
}

class _PersonalDataPageState extends State<PersonalDataPage> {
  final _formKey = GlobalKey<FormState>();

  final personalDataViewModal = PersonalDataViewModal();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(size: 22,color: AppColors.white),
        title: Text(
          'Personal Detail',
          style: TextStyle(fontSize: 22, color: AppColors.white),
        ),
        backgroundColor: AppColors.orange800,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 30),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '  Full Name',
                  style: TextStyle(
                    fontSize: AppFontSize.medium,
                    color: AppColors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: Get.height * .01),
                TextFormField(
                  controller: personalDataViewModal.nameController.value,
                  style: TextStyle(fontSize: AppFontSize.medium),
                  decoration: InputDecoration(
                    hintText: 'Ravi...',
                    hintStyle: TextStyle(fontSize: AppFontSize.medium,color: AppColors.black26),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        width: 2,
                        color: AppColors.orange800,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(width: 2, color: AppColors.grey),
                    ),
                  ),
                  validator: (value) => value == null || value.isEmpty
                      ? 'Please enter name'
                      : null,
                ),
                SizedBox(height: 30),

                Text(
                  '  Phone Number',
                  style: TextStyle(
                    fontSize: AppFontSize.medium,
                    color: AppColors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: Get.height * .01),
                TextFormField(
                  controller: personalDataViewModal.phoneController.value,
                  keyboardType: TextInputType.number,
                  style: TextStyle(fontSize: AppFontSize.medium),
                  decoration: InputDecoration(
                    hintText: '9998887776',
                    hintStyle: TextStyle(fontSize: AppFontSize.medium,color: AppColors.black26),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        width: 2,
                        color: AppColors.orange800,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(width: 2, color: AppColors.grey),
                    ),
                  ),
                  validator: (value) => personalDataViewModal.validatePhoneNumber(value),
                ),
                SizedBox(height: Get.height * .01),

                Text(
                  '  Gender',
                  style: TextStyle(
                    fontSize: AppFontSize.medium,
                    color: AppColors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: Get.height * .01),
                DropdownButtonFormField<String>(
                  value: personalDataViewModal.selectedGender.toString(),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 8,
                    ),
                    // labelText: 'Gender',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        width: 2,
                        color: AppColors.orange800,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(width: 2, color: AppColors.grey),
                    ),
                  ),
                  // validator:
                  icon: Icon(Icons.arrow_drop_down, size: 30),
                  items:  personalDataViewModal.genderList.map((String value) {
                    return  DropdownMenuItem<String>(
                      value: value,
                      child:Obx(()=> Text(value, style: TextStyle(fontSize: AppFontSize.medium)),
                    ));
                    }).toList(),
                  onChanged: (newValue) {
                    personalDataViewModal.selectedGender = newValue! as RxString?;
                  },
                  isDense: false,
                  isExpanded: true,
                ),
                SizedBox(height: Get.height * .01),

                Text(
                  '  Date of Birth',
                  style: TextStyle(
                    fontSize: AppFontSize.medium,
                    color: AppColors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: Get.height * .01),
               Obx(()=> TextFormField(
                  controller: personalDataViewModal.dobController.value,
                  style: TextStyle(fontSize: 18),
                  decoration: InputDecoration(
                    hintText: '15oct2003 / 15/10/2003',
                    hintStyle: TextStyle(fontSize: AppFontSize.medium,color: AppColors.black26),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        width: 2,
                        color: AppColors.orange800,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(width: 2, color: AppColors.grey),
                    ),
                  ),
                  validator: (value) => value == null || value.isEmpty
                      ? 'Please enter Date of Birth'
                      : null,
                )),

                SizedBox(height: Get.height * .01),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.orange800,
                      padding: EdgeInsets.symmetric(vertical: 8),
                    ),
                    onPressed: (){
                      personalDataViewModal.send();
                    },
                    child:Obx(()=> personalDataViewModal.loading.value ?
                     CircularProgressIndicator() :
                     Text(
                      'Save & Send OTP',
                      style: TextStyle(fontSize: AppFontSize.medium, color: AppColors.white),
                    )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
