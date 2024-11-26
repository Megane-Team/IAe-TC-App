import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class Konfirmasiasset extends StatefulWidget {
  const Konfirmasiasset({super.key});

  @override
  State<Konfirmasiasset> createState() => KonfimasiassetState();
}

class KonfimasiassetState extends State<Konfirmasiasset> {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 40,
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: const Offset(0, 0),
                  )
                ], color: Colors.white, shape: BoxShape.circle),
                child: IconButton(
                  onPressed: () {
                    context.pop();
                  },
                  icon: const Icon(Icons.navigate_before),
                ),
              ),
              const Text(
                'Riwayat',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              const Gap(40),
            ],
          )),
      body: Column(
        children: const [
          Gap(16),
          Text('Konfirmasi Asset'),
        ],
      ),
    );
  }
}