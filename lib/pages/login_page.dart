import 'dart:convert';

import 'package:aplikasi_bakmi_jawa/models/api_response.dart';
import 'package:aplikasi_bakmi_jawa/models/user.dart';
import 'package:aplikasi_bakmi_jawa/services/base_client.dart';
import 'package:aplikasi_bakmi_jawa/services/db/db_helper.dart';
import 'package:aplikasi_bakmi_jawa/services/shared_preferences.dart';
import 'package:aplikasi_bakmi_jawa/utils/color.dart';
import 'package:aplikasi_bakmi_jawa/utils/util.dart';
import 'package:aplikasi_bakmi_jawa/widgets/custom_textfield_password.dart';
import 'package:aplikasi_bakmi_jawa/widgets/custom_textfield_phone.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Align(
              alignment: Alignment.topLeft,
              child: Image.asset(
                "assets/images/frame_atas.png",
                scale: 5,
              )),
          Align(
              alignment: Alignment.bottomRight,
              child: Image.asset("assets/images/frame_bawah.png", scale: 5)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/logo_bakmi.png",
                  width: 120,
                  height: 120,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: AppColors.primaryColor, width: 4))),
                      child: const Text(
                        "Masuk",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: AppColors.primaryColor),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    CustomTextFieldPhone(controller: phoneController),
                    CustomTextFieldPassword(
                        controller: passwordController, title: "Password"),
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {},
                        child: const Text("Lupa Password?",
                            style: TextStyle(
                                fontSize: 13, color: AppColors.primaryColor)),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          var response = await BaseClient().post(
                              "user/login",
                              jsonEncode({
                                "no_telp": phoneController.text,
                                "password": passwordController.text
                              }));

                          ApiResponse<dynamic> apiResponse =
                              ApiResponse.fromJson(
                            json.decode(response.body),
                            (data) => data,
                          );

                          if (response.statusCode == 200 &&
                              apiResponse.status == true) {
                            final token = apiResponse.data['token'];
                            final user = User.fromJson(
                                json.decode(response.body)['data']['user']);
                            await DBHelper.addUser(user);
                            SharedPreferencesHelper.saveToken(token);
                            showToast(apiResponse.message);
                            Navigator.pushNamedAndRemoveUntil(
                                // ignore: use_build_context_synchronously
                                context,
                                "/dashboard",
                                (route) => false);
                          } else {
                            showToast("Gagal masuk");
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        child: const Text("Masuk",
                            style:
                                TextStyle(fontSize: 16, color: Colors.white)),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Belum punya akun?",
                            style: TextStyle(
                                fontSize: 13, color: AppColors.textColor)),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, "/register");
                          },
                          child: const Text(" Daftar",
                              style: TextStyle(
                                  fontSize: 13, color: AppColors.primaryColor)),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
