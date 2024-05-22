import 'dart:convert';

import 'package:aplikasi_bakmi_jawa/models/api_response.dart';
import 'package:aplikasi_bakmi_jawa/models/user.dart';
import 'package:aplikasi_bakmi_jawa/services/base_client.dart';
import 'package:aplikasi_bakmi_jawa/services/db/db_helper.dart';
import 'package:aplikasi_bakmi_jawa/services/shared_preferences.dart';
import 'package:aplikasi_bakmi_jawa/utils/color.dart';
import 'package:aplikasi_bakmi_jawa/utils/util.dart';
import 'package:aplikasi_bakmi_jawa/widgets/custom_textfield.dart';
import 'package:aplikasi_bakmi_jawa/widgets/custom_textfield_calendar.dart';
import 'package:aplikasi_bakmi_jawa/widgets/custom_textfield_phone.dart';
import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();
  User? userData;

  void getData() async {
    final user = await DBHelper.getUser();
    setState(() {
      userData = user;
      // Update text controllers after userData is set
      nameController.text = userData?.nama ?? "";
      phoneController.text = userData?.noTelp ?? "";
      birthDateController.text = userData?.tanggalLahir ?? "";
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Edit Profil",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: AppColors.backgroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Center(child: Image.asset("assets/images/user.png", scale: 4)),
            const SizedBox(height: 40),
            CustomTextFieldPhone(controller: phoneController),
            CustomTextField(controller: nameController, title: "Nama"),
            CustomTextFieldCalendar(
                controller: birthDateController, title: "Tanggal Lahir"),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  final token = await SharedPreferencesHelper.getToken();
                  var response = await BaseClient().postWithToken(
                      'user/update-profile',
                      jsonEncode({
                        "nama": nameController.text,
                        "no_telp": phoneController.text,
                        "tanggal_lahir": birthDateController.text
                      }),
                      token!);
                  ApiResponse<User> apiResponse = ApiResponse.fromJson(
                    json.decode(response.body),
                    (data) => User.fromJson(data),
                  );

                  if (response.statusCode == 200 &&
                      apiResponse.status == true) {
                    await DBHelper.updateUser(apiResponse.data);
                    showToast(apiResponse.message);
                  } else {
                    showToast("Gagal menyimpan data");
                  }
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                child: const Text("Simpan",
                    style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
