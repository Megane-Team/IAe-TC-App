import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:gap/gap.dart';

class Riwayat extends StatefulWidget {
  const Riwayat({super.key});

  @override
  State<Riwayat> createState() => RiwayatState();
}

class RiwayatState extends State<Riwayat> {
  bool isBerlangsungActive = true;
  bool isSelesaiActive = false;
  @override
  Widget build(BuildContext context) {
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
                    onPressed: () {},
                    icon: const Icon(Icons.navigate_before),
                  ),
                ),
                Text(
                  'Riwayat',
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                Gap(40),
              ],
            )),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 2,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                          color: isBerlangsungActive
                              ? const Color(0xFFFCA311)
                              : Colors.transparent,
                          width: 2.0),
                    ),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isBerlangsungActive = true;
                        isSelesaiActive = false;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      "Berlangsung",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 2,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                          color: isSelesaiActive
                              ? const Color(0xFFFCA311)
                              : Colors.transparent,
                          width: 2.0),
                    ),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isSelesaiActive = true;
                        isBerlangsungActive = false;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                      elevation: 0,
                    ),
                    child: const Text("Selesai",
                        style: TextStyle(color: Colors.black)),
                  ),
                )
              ],
            ),
            const Gap(20),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: isBerlangsungActive
                    ? peminjaman.where((item) => item['kategori'] == 'Berlangsung')
                    .length
                    : peminjaman.where((item) => item['kategori'] == 'Selesai')
                    .length,
                itemBuilder: (context, index) {
                  var filteredList = isBerlangsungActive
                      ? peminjaman.where((item) => item['kategori'] == 'Berlangsung')
                      .toList()
                      : peminjaman.where((item) => item['kategori'] == 'Selesai')
                      .toList();
                  var p = filteredList[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Tanggal: ${DateFormat('dd MMM yyyy').format(p['tanggal'])}',
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          ...p['barang'].map<Widget>((item) {
                            return Row(
                              children: [
                                Image.asset(
                                  item['img'],
                                  width: 50,
                                  height: 50,
                                ),
                                const SizedBox(width: 8),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item['nama'],
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                    Text(
                                      'Asal: ${item['asal']}',
                                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          }).toList(),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ));
  }

  List<Map<String, dynamic>> peminjaman = <Map<String, dynamic>>[
    {
      'tanggal': DateTime.parse('2024-11-31'),
      'kategori': 'Selesai',
      'barang': [
        {'nama': 'A 1', 'asal': 'Gedung 1', 'img' : 'assets/images/logos/inventara.png'},
        {'nama': 'C 2', 'asal': 'Gedung 2', 'img' : 'assets/images/logos/inventara.png'},
        {'nama': 'B 3', 'asal': 'Gedung 1', 'img' : 'assets/images/logos/inventara.png'},
      ],
    },
    {
      'tanggal': DateTime.parse('2024-01-31'),
      'kategori': 'Berlangsung',
      'barang': [
        {'nama': 'B 1', 'asal': 'Gedung 3', 'img' : 'assets/images/logos/inventara.png'},
        {'nama': 'A 2', 'asal': 'Gedung 2', 'img' : 'assets/images/logos/inventara.png'},
        {'nama': 'C 3', 'asal': 'Gedung 4', 'img' : 'assets/images/logos/inventara.png'},
      ],
    },
  ];
}