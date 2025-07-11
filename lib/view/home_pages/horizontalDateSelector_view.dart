import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../res/colors/app_colors.dart';

class HorizontalDateSelector extends StatelessWidget {
  final Function(DateTime) onDateSelected;
  final DateTime selectedDate;

  const HorizontalDateSelector({
    super.key,
    required this.onDateSelected,
    required this.selectedDate,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 15,
        itemBuilder: (_, index) {
          DateTime date = DateTime.now().add(Duration(days: index));
          bool isSelected = DateFormat('yyyy-MM-dd').format(date) ==
              DateFormat('yyyy-MM-dd').format(selectedDate);

          return GestureDetector(
            onTap: () => onDateSelected(date),
            child: Container(
              width: 50,
              margin: const EdgeInsets.symmetric(horizontal: 8),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.orange800 : AppColors.grey300,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    DateFormat.E().format(date),
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    date.day.toString(),
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
