import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:intl/intl.dart';

void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      textColor: Colors.white,
    );
  }

Future<String> formatDate(String dateStr) async {
  // Inisialisasi format tanggal untuk locale Indonesia
  await initializeDateFormatting('id_ID', 'en_US');

  // Parse the input date string to a DateTime object
  DateTime date = DateTime.parse(dateStr);

  // Define the desired output format
  DateFormat formatter = DateFormat('d MMMM yyyy', 'id_ID'); // 'id_ID' for Indonesian locale

  // Format the date and return the string
  return formatter.format(date);
}