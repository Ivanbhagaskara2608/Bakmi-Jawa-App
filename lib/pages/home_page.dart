// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:aplikasi_bakmi_jawa/models/api_response.dart';
import 'package:aplikasi_bakmi_jawa/models/menu.dart';
import 'package:aplikasi_bakmi_jawa/models/user.dart';
import 'package:aplikasi_bakmi_jawa/services/base_client.dart';
import 'package:aplikasi_bakmi_jawa/services/db/db_helper.dart';
import 'package:aplikasi_bakmi_jawa/utils/color.dart';
import 'package:aplikasi_bakmi_jawa/widgets/card_menu.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController searchController = TextEditingController();
  List<Menu> menus = [];
  List<Menu> filteredMenus = [];
  bool isLoading = true;
  bool hasError = false;
  String selectedCategory = 'Semua';

  Future<void> getMenu() async {
    setState(() {
      isLoading = true;
      hasError = false;
    });

    var response = await BaseClient().get('menu/index').catchError((err) {
      print('Error: $err');
      setState(() {
        hasError = true;
      });
    });

    if (response != null) {
      ApiResponse<dynamic> apiResponse =
          ApiResponse.fromJson(json.decode(response.body), (data) => data);
      if (response.statusCode == 200 && apiResponse.status == true) {
        List<dynamic> menuJson = apiResponse.data;
        List<Menu> menuList =
            menuJson.map((json) => Menu.fromJson(json)).toList();
        setState(() {
          menus = menuList;
          filteredMenus = menuList;
        });
      }
    }

    setState(() {
      isLoading = false;
    });
  }

  void filterMenus(String query) {
    List<Menu> tempMenus = menus;
    if (selectedCategory != 'Semua') {
      tempMenus = tempMenus.where((menu) {
        return menu.kategori == selectedCategory;
      }).toList();
    }
    if (query.isNotEmpty) {
      tempMenus = tempMenus.where((menu) {
        return menu.nama.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
    setState(() {
      filteredMenus = tempMenus;
    });
  }

  void filterByCategory(String category) {
    setState(() {
      selectedCategory = category;
    });
    filterMenus(searchController.text);
  }

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
    getMenu();
    getData();
    searchController.addListener(() {
      filterMenus(searchController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(const Duration(seconds: 1));
          getMenu();
        },
        child: Padding(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hi, ${userData?.nama ?? "undefined"}",
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 15),
              Container(
                padding: const EdgeInsets.all(15),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: AppColors.secondaryColor,
                    borderRadius: BorderRadius.circular(15)),
                child: Center(
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/images/reward.png",
                        scale: 8,
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Poin Kamu",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "${userData?.point ?? 0} Pts",
                            style: const TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const Spacer(),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/reward');
                          },
                          style: ButtonStyle(
                              elevation: WidgetStateProperty.all(5),
                              shape: WidgetStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              backgroundColor: WidgetStateProperty.all(
                                  AppColors.primaryColor)),
                          child: const Row(
                            children: [
                              Text("Tukar Poin",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                              Icon(Icons.arrow_forward_ios_rounded,
                                  color: Colors.white),
                            ],
                          ))
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15),
              SearchBar(
                controller: searchController,
                backgroundColor: WidgetStateProperty.all(Colors.white),
                hintText: "Cari menu disini",
                elevation: const WidgetStatePropertyAll(0),
                leading: const Icon(Icons.search),
                textStyle:
                    WidgetStateProperty.all(const TextStyle(fontSize: 13)),
                padding: const WidgetStatePropertyAll(
                    EdgeInsets.symmetric(horizontal: 15)),
              ),
              const SizedBox(height: 15),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => filterByCategory('Semua'),
                    child: Container(
                      width: 80,
                      height: 74,
                      margin: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        color: selectedCategory == 'Semua'
                            ? AppColors.primaryColor
                            : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("assets/images/all-menu.png", scale: 4),
                          Text("Semua",
                              style: TextStyle(
                                  color: selectedCategory == 'Semua'
                                      ? Colors.white
                                      : Colors.black)),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => filterByCategory('Makanan'),
                    child: Container(
                      width: 80,
                      height: 74,
                      margin: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        color: selectedCategory == 'Makanan'
                            ? AppColors.primaryColor
                            : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("assets/images/food-menu.png", scale: 4),
                          Text("Makanan",
                              style: TextStyle(
                                  color: selectedCategory == 'Makanan'
                                      ? Colors.white
                                      : Colors.black)),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => filterByCategory('Minuman'),
                    child: Container(
                      width: 80,
                      height: 74,
                      margin: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        color: selectedCategory == 'Minuman'
                            ? AppColors.primaryColor
                            : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("assets/images/drink-menu.png", scale: 4),
                          Text("Minuman",
                              style: TextStyle(
                                  color: selectedCategory == 'Minuman'
                                      ? Colors.white
                                      : Colors.black)),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => filterByCategory('Cemilan'),
                    child: Container(
                      width: 80,
                      height: 74,
                      margin: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        color: selectedCategory == 'Cemilan'
                            ? AppColors.primaryColor
                            : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("assets/images/snack-menu.png", scale: 4),
                          Text("Snack",
                              style: TextStyle(
                                  color: selectedCategory == 'Cemilan'
                                      ? Colors.white
                                      : Colors.black)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : hasError
                        ? const Center(
                            child: Text("Terjadi kesalahan, coba lagi."))
                        : filteredMenus.isEmpty
                            ? const Center(child: Text("Menu tidak ditemukan."))
                            : GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        mainAxisExtent: 175,
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 10,
                                        mainAxisSpacing: 15),
                                itemCount: filteredMenus.length,
                                itemBuilder: (context, index) {
                                  return CardMenu(menu: filteredMenus[index]);
                                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
