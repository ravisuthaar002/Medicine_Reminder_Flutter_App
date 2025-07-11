


import 'package:get/get.dart';

class HorizontalDataSelectorViewModal extends GetxController{
  Rx<DateTime> selectedDate = DateTime.now().obs;
  RxBool selected = false.obs;
}