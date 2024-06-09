import 'dart:convert';
import 'package:aplikasi_bakmi_jawa/models/api_response.dart';
import 'package:aplikasi_bakmi_jawa/models/menu.dart';
import 'package:aplikasi_bakmi_jawa/services/base_client.dart';
import 'package:aplikasi_bakmi_jawa/utils/color.dart';
import 'package:aplikasi_bakmi_jawa/widgets/card_reward.dart';
import 'package:flutter/material.dart';

class RewardPage extends StatefulWidget {
  const RewardPage({super.key});

  @override
  State<RewardPage> createState() => _RewardPageState();
}

class _RewardPageState extends State<RewardPage> {
  TextEditingController searchController = TextEditingController();
  List<dynamic> rewards = [];
  List<dynamic> filteredRewards = [];
  bool isLoading = true;
  bool hasError = false;

  Future<void> getRewards() async {
    setState(() {
      isLoading = true;
      hasError = false;
    });

    var response = await BaseClient().get('reward/index').catchError((err) {
      print('Error: $err');
      setState(() {
        hasError = true;
      });
    });

    if (response != null) {
      ApiResponse<dynamic> apiResponse =
          ApiResponse.fromJson(json.decode(response.body), (data) => data);
      if (response.statusCode == 200 && apiResponse.status == true) {
        setState(() {
          rewards = apiResponse.data;
          filteredRewards = apiResponse.data;
        });
      }
    }

    setState(() {
      isLoading = false;
    });
  }

  void filterRewards(String query) {
    List<dynamic> tempRewards = rewards;
    if (query.isNotEmpty) {
      tempRewards = tempRewards.where((reward) {
        return reward['menu']['nama']
            .toLowerCase()
            .contains(query.toLowerCase());
      }).toList();
    }
    setState(() {
      filteredRewards = tempRewards;
    });
  }

  @override
  void initState() {
    super.initState();
    getRewards();
    searchController.addListener(() {
      filterRewards(searchController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Tukar Poin",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.backgroundColor,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
        child: Column(
          children: [
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
              textStyle: WidgetStateProperty.all(const TextStyle(fontSize: 13)),
              padding: const WidgetStatePropertyAll(
                  EdgeInsets.symmetric(horizontal: 15)),
            ),
            const SizedBox(height: 15),
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : hasError
                      ? const Center(
                          child: Text("Terjadi kesalahan, coba lagi."))
                      : filteredRewards.isEmpty
                          ? const Center(child: Text("Reward tidak ditemukan."))
                          : GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      mainAxisExtent: 175,
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 15),
                              itemCount: filteredRewards.length,
                              itemBuilder: (context, index) {
                                var reward = filteredRewards[index];
                                var menu = Menu.fromJson(reward['menu']);
                                return CardReward(
                                  points: reward['point'],
                                  menu: menu,
                                );
                              }),
            ),
          ],
        ),
      ),
    );
  }
}
