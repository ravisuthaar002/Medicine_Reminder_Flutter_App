import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HorizontalDateSelector extends StatefulWidget {
  final Function(DateTime) onDateSelected;

  HorizontalDateSelector({required this.onDateSelected});

  @override
  State<HorizontalDateSelector> createState() => _HorizontalDateSelectorState();
}

class _HorizontalDateSelectorState extends State<HorizontalDateSelector> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 15,
        itemBuilder: (_, index) {
          DateTime date = DateTime.now().add(Duration(days: index));
          bool isSelected = date.day == selectedDate.day &&
              date.month == selectedDate.month &&
              date.year == selectedDate.year;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedDate = date;
              });
              widget.onDateSelected(date);
            },
            child: Container(
              width: 50,
              margin: EdgeInsets.symmetric(horizontal: 8),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isSelected ? Colors.orange.shade800 : Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Text(DateFormat.E().format(date)), // Mon, Tue, etc
                  Text(date.day.toString()),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
