import 'package:aplikasi_bakmi_jawa/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomTextFieldCalendar extends StatefulWidget {
  final TextEditingController controller;
  final String title;
  const CustomTextFieldCalendar(
      {super.key, required this.controller, required this.title});

  @override
  State<CustomTextFieldCalendar> createState() =>
      _CustomTextFieldCalendarState();
}

class _CustomTextFieldCalendarState extends State<CustomTextFieldCalendar> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: const TextStyle(fontSize: 16, color: AppColors.primaryColor),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: TextFormField(
            controller: widget.controller,
            readOnly: true,
            onTap: () async {
              DateTime? date = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime(2100),
                  builder: (context, child) => Theme(
                      data: Theme.of(context).copyWith(
                        colorScheme: const ColorScheme.light(
                            primary: AppColors.primaryColor),
                      ),
                      child: child!));
              if (date != null) {
                String formattedDate = DateFormat('yyyy-MM-dd').format(date);

                setState(() {
                  widget.controller.text = formattedDate;
                });
              }
            },
            decoration: const InputDecoration(
                suffixIcon: Icon(Icons.calendar_today),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 10, vertical: 5)),
          ),
        ),
      ],
    );
  }
}
