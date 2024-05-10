import 'package:flutter/material.dart';
import 'package:aplikasi_bakmi_jawa/utils/color.dart';

class DetailMenuPage extends StatefulWidget {
  const DetailMenuPage({super.key});

  @override
  State<DetailMenuPage> createState() => _DetailMenuPageState();
}

class _DetailMenuPageState extends State<DetailMenuPage> {
  int itemCount = 1;

  void decreaseItem() {
    setState(() {
      if (itemCount > 1) {
        itemCount--;
      }
    });
  }

  void increaseItem() {
    setState(() {
      itemCount++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Detail",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: AppColors.backgroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
                child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                "assets/images/nasgor.jpg",
              ),
            )),
            const SizedBox(height: 20),
            const Row(
              children: [
                Text(
                  "Nasi Goreng",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Spacer(),
                Text(
                  "Rp 13.000",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              "Topping",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: const Text(
                    "Ati ampela",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(width: 5),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: const Text(
                    "Kepala",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              "Deskripsi",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              "Nasi goreng adalah makanan yang terbuat dari nasi yang digoreng dan dicampur dengan bumbu-bumbu tertentu. Nasi goreng adalah makanan yang terbuat dari nasi yang digoreng dan dicampur dengan bumbu-bumbu tertentu.",
              style: TextStyle(fontSize: 14),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: InkWell(
                            onTap: () {
                              decreaseItem();
                            },
                            child: const Icon(
                              Icons.remove,
                              color: Colors.white,
                              size: 15,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text("$itemCount"),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: InkWell(
                            onTap: () {
                              increaseItem();
                            },
                            child: const Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(AppColors.primaryColor),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                        elevation: MaterialStateProperty.all(5)),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        "Tambah ke keranjang",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
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
