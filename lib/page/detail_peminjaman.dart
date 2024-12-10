import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class DetailPeminjaman extends StatefulWidget {
  const DetailPeminjaman({super.key});

  @override
  State<DetailPeminjaman> createState() => _DetailPeminjamanState();
}

class _DetailPeminjamanState extends State<DetailPeminjaman> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 40,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 4,
                      offset: const Offset(0, 0),
                    ),
                  ],
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      context.pop();
                    });
                  },
                  icon: const Icon(Icons.navigate_before, color: Colors.black),
                ),
              ),
              const Text(
                'Detail Peminjaman',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              const Gap(40),
            ],
          ),
        ),
      body: Padding(
        padding: EdgeInsets.only(right: 24, left: 24, top: 20, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              child: Column(
                children: [
                  Row(
                    children: [
                      Text('Status Peminjaman')
                      // Text('')
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

List<Map<String, dynamic>> data = [
  {
    'status': 'Menunggu Konfirmasi',
    'createdAt': 'gedung',
    'borrowedDate': 'assets/images/logos/inventara.png',
    'estimatedTime': 'gedung',
    'returnDate': 'gedung',
    'destination': 'gedung',
    'canceledReason': 'gedung',
    'objective': 'Hidup Sehat Bersama',
    'penumpang': 2,
    'barang': [
      {
        'name': 'Barang 1',
        'photo': 'assets/images/logos/inventara.png',
        'kategori': 'elektronik'
      },
      {
        'name': 'Barang 2',
        'photo': 'assets/images/logos/inventara.png',
        'kategori': 'furniture'
      },
    ]
  },
  {
    'name': 'Gedung 2',
    'photo': 'assets/images/logos/inventara.png',
    'kategori': 'gedung',
    'barang': [
      {
        'name': 'Barang 3',
        'photo': 'assets/images/logos/inventara.png',
        'kategori': 'elektronik'
      },
      {
        'name': 'Barang 4',
        'photo': 'assets/images/logos/inventara.png',
        'kategori': 'furniture'
      },
    ]
  },
];

