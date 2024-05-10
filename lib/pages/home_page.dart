import 'package:aplikasi_bakmi_jawa/utils/color.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
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
                    const SizedBox(width: 10), // Add this line
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
            const SizedBox(
              height: 15,
            ),
            Expanded(
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisExtent: 175,
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 15),
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, "/detail-menu");
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: const [
                              BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 5,
                                  offset: Offset(0, 3))
                            ]),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: SizedBox(
                                  height: 90,
                                  width: double.infinity,
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: Image.asset(
                                        "assets/images/nasgor.jpg",
                                        fit: BoxFit.cover,
                                      )),
                                ),
                              ),
                              const SizedBox(height: 2),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Menu $index',
                                        style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold)),
                                    const Text(
                                        "lorem ipsum dolor sit amet, consectetur ssss.",
                                        style: TextStyle(fontSize: 8)),
                                    const SizedBox(height: 5),
                                    Row(
                                      children: [
                                        const Text(
                                          "Rp13000",
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.primaryColor),
                                        ),
                                        const Spacer(),
                                        CircleAvatar(
                                          backgroundColor: AppColors.primaryColor,
                                          radius: 15,
                                          child: IconButton(
                                            padding: EdgeInsets.zero,
                                            icon: const Icon(Icons.add),
                                            color: Colors.white,
                                            onPressed: () {},
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
