

import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CalendarViewModal extends GetxController {
  Rx<DateTime> selectedDate = DateTime.now().obs;


  String get formattedSelectedDate =>
      DateFormat('yyyy-MM-dd').format(selectedDate.value);
}
