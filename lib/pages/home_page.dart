// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:aplikasi_bakmi_jawa/models/api_response.dart';
import 'package:aplikasi_bakmi_jawa/models/menu.dart';
import 'package:aplikasi_bakmi_jawa/services/base_client.dart';
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
    List<Menu> tempMenus = [];
    if (query.isEmpty) {
      tempMenus = menus;
    } else {
      tempMenus = menus.where((menu) {
        return menu.nama.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
    setState(() {
      filteredMenus = tempMenus;
    });
  }

  @override
  void initState() {
    super.initState();
    getMenu();
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
              const Text(
                "Hi, Ivan Bhagaskara",
                style: TextStyle(fontSize: 18),
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
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Poin Kamu",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "1000 Pts",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const Spacer(),
                      ElevatedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                              elevation: MaterialStateProperty.all(5),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              backgroundColor: MaterialStateProperty.all(
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
                hintText: "Cari menu disini",
                elevation: const MaterialStatePropertyAll(0),
                leading: const Icon(Icons.search),
                textStyle:
                    MaterialStateProperty.all(const TextStyle(fontSize: 13)),
                padding: const MaterialStatePropertyAll(
                    EdgeInsets.symmetric(horizontal: 15)),
              ),
              const SizedBox(height: 15),
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
