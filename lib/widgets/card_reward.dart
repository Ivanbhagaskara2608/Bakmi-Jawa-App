import 'package:aplikasi_bakmi_jawa/services/base_client.dart';
import 'package:aplikasi_bakmi_jawa/utils/color.dart';
import 'package:aplikasi_bakmi_jawa/models/menu.dart';
import 'package:flutter/material.dart';

class CardReward extends StatelessWidget {
  final int points;
  final Menu menu;
  const CardReward({super.key, required this.points, required this.menu});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, "/detail-reward", arguments: {'menu': menu, 'points': points});
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(color: Colors.grey, blurRadius: 5, offset: Offset(0, 3))
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
                      child: Image.network(
                        "$baseUrl/menu/image/${menu.gambar}",
                        fit: BoxFit.cover,
                      )),
                ),
              ),
              const SizedBox(height: 2),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(menu.nama,
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold)),
                    Text(menu.deskripsi, style: const TextStyle(fontSize: 8)),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Image.asset(
                          "assets/images/reward.png",
                          scale: 20,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          "${points.toString()} Pts",
                          style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: AppColors.pointColor),
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
  }
}
