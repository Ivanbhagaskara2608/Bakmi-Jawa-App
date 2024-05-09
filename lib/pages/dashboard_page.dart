import 'package:aplikasi_bakmi_jawa/pages/home_page.dart';
import 'package:aplikasi_bakmi_jawa/pages/order_page.dart';
import 'package:aplikasi_bakmi_jawa/pages/cart_page.dart';
import 'package:aplikasi_bakmi_jawa/pages/profile_page.dart';
import 'package:aplikasi_bakmi_jawa/utils/color.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _currentIndex = 0;
  late List<Widget> tabs = [
    const HomePage(),
    const OrderPage(),
    const CartPage(),
    const ProfilePage()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[_currentIndex],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            boxShadow: [
              BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
            ]),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: _currentIndex,
            unselectedItemColor: Colors.grey[800],
            selectedItemColor: AppColors.primaryColor,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home_filled, size: 30), label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.assignment, size: 30), label: "Order"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart, size: 30), label: "Cart"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person, size: 30), label: "Profile"),
            ],
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }
}
