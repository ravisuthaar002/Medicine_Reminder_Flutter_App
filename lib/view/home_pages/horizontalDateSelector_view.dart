import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:medicine_reminder_flutter_app/res/colors/app_colors.dart';
import 'package:medicine_reminder_flutter_app/view_modal/controller/home_pages/horizontalDataSelector_view_modal.dart';

class HorizontalDateSelector extends StatefulWidget {
  final Function(DateTime) onDateSelected;

  const HorizontalDateSelector({super.key, required this.onDateSelected});

  @override
  State<HorizontalDateSelector> createState() => _HorizontalDateSelectorState();
}

class _HorizontalDateSelectorState extends State<HorizontalDateSelector> {

  final horizontalDataSelector = HorizontalDataSelectorViewModal();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 15,
        itemBuilder: (_, index) {
          DateTime date = DateTime.now().add(Duration(days: index));
              horizontalDataSelector.selected.value = date.day == horizontalDataSelector.selectedDate.day &&
              date.month == horizontalDataSelector.selectedDate.month &&
              date.year == horizontalDataSelector.selectedDate.year;

          return Obx(()=> GestureDetector(
            onTap: () {
                horizontalDataSelector.selectedDate = date;
              widget.onDateSelected(date);
            },
            child: Container(
              width: 50,
              margin: EdgeInsets.symmetric(horizontal: 8),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: horizontalDataSelector.selected.value ? AppColors.orange800 : AppColors.grey300,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Text(DateFormat.E().format(date)), // Mon, Tue, etc
                  Text(date.day.toString()),
                ],
              ),
            ),
          ));
        },
      ),
    );
  }
}
