import 'package:aplikasi_bakmi_jawa/models/user.dart';
import 'package:aplikasi_bakmi_jawa/services/db/db_helper.dart';
import 'package:aplikasi_bakmi_jawa/utils/color.dart';
import 'package:aplikasi_bakmi_jawa/utils/util.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User? userData;
  void getData() async {
    final user = await DBHelper.getUser();
    setState(() {
      userData = user;
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
          "Profil",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.backgroundColor,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Center(
                child: Image.asset(
                  "assets/images/user.png",
                  scale: 4,
                ),
              ),
            ),
            Text(
              userData?.nama ?? "undefined",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Icon(
                Icons.phone,
                size: 12,
              ),
              Text("+62${userData?.noTelp ?? "undefined"}")
            ]),
            const SizedBox(height: 5),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Icon(
                Icons.cake,
                size: 12,
              ),
              Text(userData?.tanggalLahir ?? "undefined")
            ]),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  ListTile(
                    onTap: () {
                      Navigator.pushNamed(context, "/edit-profile");
                    },
                    leading: Image.asset(
                      "assets/images/user-2.png",
                      scale: 5,
                    ),
                    title: const Text("Edit Profile"),
                    trailing: const Icon(
                      Icons.chevron_right,
                      size: 35,
                    ),
                  ),
                  const SizedBox(height: 15),
                  ListTile(
                    onTap: () {
                      Navigator.pushNamed(context, "/change-password");
                    },
                    leading: Image.asset(
                      "assets/images/lock.png",
                      scale: 5,
                    ),
                    title: const Text("Ubah Password"),
                    trailing: const Icon(
                      Icons.chevron_right,
                      size: 35,
                    ),
                  ),
                  const SizedBox(height: 15),
                  ListTile(
                    onTap: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, "/login", (route) => false);
                    },
                    leading: Image.asset(
                      "assets/images/power.png",
                      scale: 5,
                    ),
                    title: const Text("Keluar Akun"),
                    trailing: const Icon(
                      Icons.chevron_right,
                      size: 35,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
