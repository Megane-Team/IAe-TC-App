import 'dart:core';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:inventara/actions/ruangan/read_ruangan_action.dart';
import 'package:inventara/actions/tempat/read_tempat_action.dart';
import 'package:inventara/structures/ruangan.dart';
import 'package:inventara/structures/ruangan_category.dart';
import 'package:inventara/structures/tempat.dart';
import 'package:inventara/utils/actionwidget.dart';
import 'package:inventara/utils/assets.dart';

class Gedung extends StatefulWidget {
  final String id;
  const Gedung({required this.id, super.key});

  @override
  State<Gedung> createState() => GedungState();
}

class GedungState extends State<Gedung> {
  bool isKelasActive = false;
  bool isGudangActive = false;
  bool isLabActive = false;
  late List<Ruangans> filteredRuangan = [];
  late List<Ruangans> originalRuanganList = [];
  late List<Tempat> gedung = [];
  TextEditingController searchController = TextEditingController();

  bool isRuanganHasCapacity(Ruangans ruangan) {
    return ruangan.capacity != null;
  }

  void fetchData() async {
    var ruangan = await readRuangan(widget.id);
    gedung = await readTempatbyId(widget.id);
    setState(() {
      originalRuanganList = ruangan;
      filteredRuangan = List.from(originalRuanganList);
      _filterAndUpdateRuanganList(searchController.text);
    });
  }

  void _filterAndUpdateRuanganList(String value) {
    setState(() {
      print(value);
      if (isKelasActive || isLabActive || isGudangActive) {
        filteredRuangan = [];
        if (isKelasActive) {
          filteredRuangan.addAll(originalRuanganList
              .where((item) => item.category == RuanganCategory.kelas)
              .where((element) =>
              element.code.toLowerCase().contains(value.toLowerCase())));
        }
        if (isLabActive) {
          filteredRuangan.addAll(originalRuanganList
              .where((item) => item.category == RuanganCategory.lab)
              .where((element) =>
              element.code.toLowerCase().contains(value.toLowerCase())));
        }
        if (isGudangActive) {
          filteredRuangan.addAll(originalRuanganList
              .where((item) => item.category == RuanganCategory.gudang)
              .where((element) =>
              element.code.toLowerCase().contains(value.toLowerCase())));
        }
      } else {
        filteredRuangan = originalRuanganList
            .where((element) =>
            element.code.toLowerCase().contains(value.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

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
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 4,
                )
              ], color: Colors.white, shape: BoxShape.circle),
              child: IconButton(
                onPressed: () {
                  context.pop();
                },
                icon: const Icon(Icons.navigate_before),
              ),
            ),
            Text(
              gedung.isEmpty ? '' : gedung[0].name,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
            Container(
              width: 40,
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: MediaQuery.of(context).size.width - 48,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 0,
                  blurRadius: 2,
                  offset: const Offset(0, 0),
                )
              ],
            ),
            child: TextField(
              controller: searchController,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                hintStyle: const TextStyle(
                    color: Colors.black54,
                    fontSize: 16,
                    fontWeight: FontWeight.w100),
                hintText: 'Cari ruangan...',
                prefixIcon: const Icon(Icons.search),
                border: InputBorder.none,
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 10.0),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) {
                _filterAndUpdateRuanganList(value);
              },
            ),
          ),
          const Gap(12),
          Padding(
            padding: const EdgeInsets.only(right: 24, left: 24),
            child: Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isKelasActive = !isKelasActive;
                      _filterAndUpdateRuanganList(searchController.text);
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        isKelasActive ? const Color(0xFFFCA311) : Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    shadowColor: Colors.black,
                    elevation: 2,
                  ),
                  child: const Text(
                    "Kelas",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                const Gap(12),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isLabActive = !isLabActive;
                      _filterAndUpdateRuanganList(searchController.text);
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        isLabActive ? const Color(0xFFFCA311) : Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    shadowColor: Colors.black,
                    elevation: 2,
                  ),
                  child: const Text(
                    "Lab",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                const Gap(12),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isGudangActive = !isGudangActive;
                      _filterAndUpdateRuanganList(searchController.text);
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        isGudangActive ? const Color(0xFFFCA311) : Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    shadowColor: Colors.black,
                    elevation: 2,
                  ),
                  child: const Text(
                    "Gudang",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
          const Gap(20),
          Expanded(
            child: FutureBuilder<List<Ruangans>>(
              future: readRuangan(widget.id),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  // send error message to terminal
                  return noData();
                } else if (snapshot.hasData) {
                  // check if the data is empty
                  if (snapshot.data!.isEmpty) {
                    return noData();
                  }
                  return ListView.builder(
                    itemCount: filteredRuangan.length,
                    itemBuilder: (context, index) {
                      var ruangan = filteredRuangan[index];
                      return Container(
                        height: 61,
                        margin: const EdgeInsets.only(
                            left: 24, right: 24, bottom: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 4,
                            backgroundColor: ruangan.status == 'Digunakan'
                                ? Colors.grey
                                : Colors.white,
                          ),
                          onPressed: () {
                            if (ruangan.status == 'Digunakan') {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title:
                                        const Text('Ruangan Sedang Digunakan'),
                                    content: const Column(
                                      mainAxisSize: MainAxisSize.min,
                                      // children: Peminjaman.map((peminjaman) {
                                      //   return ListTile(
                                      //     title: Text(peminjaman['name']!),
                                      //     subtitle: Text(
                                      //         'Divisi: ${peminjaman['Divisi']!}\nEstimasi Peminjaman: ${peminjaman['estimasi peminjaman']!}'),
                                      //   );
                                      // }).toList(),
                                    ),
                                    actions: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            padding: EdgeInsets.zero,
                                            backgroundColor:
                                                const Color(0xFFFCA311),
                                          ),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text(
                                            'OK',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            } else {
                              setState(() {
                                var param1 = ruangan.id;

                                context.push(
                                    "/ruangan?id=$param1&category=ruangan");
                              });
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 60,
                                      height: 46,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: FutureBuilder<Widget>(
                                            future: Assets.ruangan(
                                                ruangan.photo ?? ''),
                                            builder: (context, snapshot) {
                                              if (snapshot.connectionState ==
                                                  ConnectionState.waiting) {
                                                return const CircularProgressIndicator(); // Show a loading indicator while waiting
                                              } else if (snapshot.hasError) {
                                                return Image.asset(Assets
                                                    .noImage()); // Show error message if any
                                              } else if (snapshot.hasData) {
                                                return snapshot
                                                    .data!; // Return the widget once the future completes
                                              } else {
                                                return const Text(
                                                    'No data available'); // Show message if no data
                                              }
                                            }),
                                      ),
                                    ),
                                    const Gap(16),
                                    Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            ruangan.code,
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black),
                                          ),
                                        ])
                                  ],
                                ),
                              ),
                              isRuanganHasCapacity(ruangan)
                                  ? Container(
                                      width: 46,
                                      height: 22,
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: const Color(0xFFFCA311)
                                                .withOpacity(1),
                                            spreadRadius: 1,
                                            blurRadius: 4,
                                            offset: const Offset(0, 0),
                                          )
                                        ],
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            Icons.person,
                                            color: Color(0xFFFCA311),
                                            size: 16,
                                          ),
                                          Text(
                                            ruangan.capacity.toString(),
                                            style: const TextStyle(
                                                fontSize: 12,
                                                color: Color(0xFFFCA311)),
                                          ),
                                        ],
                                      ),
                                    )
                                  : const SizedBox()
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return const Text('No data available');
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
