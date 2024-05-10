import 'package:aplikasi_bakmi_jawa/utils/color.dart';
import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
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
            "Keranjang",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: AppColors.backgroundColor,
        ),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return Card(
                          color: Colors.white,
                          child: ListTile(
                            onTap: () {},
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                "assets/images/nasgor.jpg",
                              ),
                            ),
                            title: const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Bakmi Goreng",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold)),
                                Text(
                                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. ddddd",
                                    style: TextStyle(fontSize: 10))
                              ],
                            ),
                            subtitle: Row(
                              children: [
                                Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        color: Colors.grey[400],
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: InkWell(
                                      onTap: () {
                                        decreaseItem();
                                      },
                                      child: const Icon(
                                        Icons.remove,
                                        color: Colors.black,
                                        size: 15,
                                      ),
                                    )),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Text("$itemCount"),
                                ),
                                Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        color: Colors.grey[400],
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: InkWell(
                                      onTap: () {
                                        increaseItem();
                                      },
                                      child: const Icon(
                                        Icons.add,
                                        color: Colors.black,
                                        size: 15,
                                      ),
                                    )),
                              ],
                            ),
                            trailing: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {},
                                  child: const Icon(
                                    Icons.cancel,
                                    size: 15,
                                  ),
                                ),
                                const Text("Rp13.000",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: AppColors.primaryColor,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        );
                      } // Add this line
                      ),
                ),
              ],
            )));
  }
}
