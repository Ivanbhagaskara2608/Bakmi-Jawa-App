import 'package:aplikasi_bakmi_jawa/pages/change_password_page.dart';
import 'package:aplikasi_bakmi_jawa/pages/dashboard_page.dart';
import 'package:aplikasi_bakmi_jawa/pages/detail_menu_page.dart';
import 'package:aplikasi_bakmi_jawa/pages/edit_profile_page.dart';
import 'package:aplikasi_bakmi_jawa/pages/login_page.dart';
import 'package:aplikasi_bakmi_jawa/pages/register_page.dart';
import 'package:aplikasi_bakmi_jawa/pages/splashscreen_page.dart';
import 'package:aplikasi_bakmi_jawa/pages/checkout_page.dart';
import 'package:aplikasi_bakmi_jawa/utils/color.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: 'splashscreen',
      routes: {
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/dashboard': (context) => const DashboardPage(),
        '/edit-profile': (context) => const EditProfilePage(),
        '/change-password': (context) => const ChangePasswordPage(),
        '/detail-menu': (context) => const DetailMenuPage(),
        '/checkout': (context) => const CheckoutPage(),
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.backgroundColor,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
        useMaterial3: true,
      ),
      home: const SplashScreenPage(),
    );
  }
}
