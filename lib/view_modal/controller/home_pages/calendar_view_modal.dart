

import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CalendarViewModal extends GetxController{
  DateTime selectedDate = DateTime.now();
  RxString get formattedSelectedDate => DateFormat('yyyy-MM-dd').format(selectedDate).obs;
}