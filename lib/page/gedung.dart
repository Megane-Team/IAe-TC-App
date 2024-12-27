import 'dart:core';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:inventara/actions/peminjaman/read_detail_peminjaman_action.dart';
import 'package:inventara/actions/peminjaman/read_peminjaman_action.dart';
import 'package:inventara/actions/ruangan/read_ruangan_action.dart';
import 'package:inventara/actions/tempat/read_tempat_action.dart';
import 'package:inventara/actions/users/read_user_action.dart';
import 'package:inventara/structures/detail_peminjaman.dart';
import 'package:inventara/structures/peminjaman.dart';
import 'package:inventara/structures/peminjaman_status.dart';
import 'package:inventara/structures/ruangan.dart';
import 'package:inventara/structures/ruangan_category.dart';
import 'package:inventara/structures/tempat.dart';
import 'package:inventara/utils/actionwidget.dart';
import 'package:inventara/utils/assets.dart';

class Gedung extends StatefulWidget {
  final String id;
  final int? rId;
  const Gedung({required this.id, this.rId, super.key});

  @override
  State<Gedung> createState() => GedungState();
}

class GedungState extends State<Gedung> {
  bool isKelasActive = false;
  bool isGudangActive = false;
  bool isLabActive = false;
  late List<Ruangans> filteredRuangan = [];
  late DetailPeminjamans? dpeminjaman;
  late List<Ruangans> originalRuanganList = [];
  late List<Tempat> gedung = [];
  TextEditingController searchController = TextEditingController();

  bool isRuanganHasCapacity(Ruangans ruangan) {
    return ruangan.capacity != null;
  }

  void fetchData() async {
    var ruangan = await readRuanganbyGedungId(widget.id, context);
    if (mounted) {
      gedung = await readTempat(context);
    }
    setState(() {
      originalRuanganList = ruangan;
      filteredRuangan = List.from(originalRuanganList);
      _filterAndUpdateRuanganList(searchController.text);
    });
    if (widget.rId != null &&
        widget.rId! <= ruangan.length &&
        widget.rId != 0 &&
        mounted) {
      var ruangan = await readRuanganbyId(widget.rId!, context);
      if (mounted) {
        onPressed(context, ruangan!, true);
      }
    }
  }

  void _filterAndUpdateRuanganList(String value) {
    setState(() {
      filteredRuangan = originalRuanganList.where((item) {
        bool matchesCategory =
            (isKelasActive && item.category == RuanganCategory.kelas) ||
                (isLabActive && item.category == RuanganCategory.lab) ||
                (isGudangActive && item.category == RuanganCategory.gudang) ||
                (!isKelasActive && !isLabActive && !isGudangActive);
        bool matchesSearch =
            item.code.toLowerCase().contains(value.toLowerCase());
        return matchesCategory && matchesSearch;
      }).toList()
        ..sort((a, b) => a.code.compareTo(b.code));
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
                  child: Text(
                    "Kelas",
                    style: TextStyle(
                        color: isKelasActive ? Colors.white : Colors.black),
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
                  child: Text(
                    "Lab",
                    style: TextStyle(
                        color: isLabActive ? Colors.white : Colors.black),
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
                  child: Text(
                    "Gudang",
                    style: TextStyle(
                        color: isGudangActive ? Colors.white : Colors.black),
                  ),
                ),
              ],
            ),
          ),
          const Gap(20),
          Expanded(
            child: FutureBuilder<List<Ruangans>>(
              future: readRuanganbyGedungId(widget.id, context),
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
                  return RefreshIndicator(
                    onRefresh: () async {
                      fetchData();
                    },
                    child: ListView.builder(
                      itemCount: filteredRuangan.length,
                      itemBuilder: (context, index) {
                        var ruangan = filteredRuangan[index];
                        return Padding(
                          padding: EdgeInsets.only(right: 24, left: 24),
                          child: Container(
                            height: 61,
                            margin: const EdgeInsets.only(bottom: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  spreadRadius: 1,
                                  blurRadius: 4,
                                  offset: const Offset(0, 0),
                                ),
                              ],
                            ),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                elevation: 4,
                                backgroundColor: Colors.white,
                                shadowColor: Colors.black.withOpacity(0.1),
                              ),
                              onPressed: () {
                                onPressed(context, ruangan, false);
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 60,
                                          height: 46,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            child: FutureBuilder<Widget>(
                                                future: Assets.ruangan(
                                                    ruangan.photo ?? ''),
                                                builder: (context, snapshot) {
                                                  if (snapshot
                                                          .connectionState ==
                                                      ConnectionState.waiting) {
                                                    return const CircularProgressIndicator(); // Show a loading indicator while waiting
                                                  } else if (snapshot
                                                      .hasError) {
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
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.black),
                                              ),
                                              if (ruangan.category !=
                                                  RuanganCategory.gudang)
                                                Text(
                                                  ruangan.status
                                                      ? 'Digunakan'
                                                      : 'Tidak Digunakan',
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.grey,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                            ])
                                      ],
                                    ),
                                  ),
                                  if (ruangan.category !=
                                      RuanganCategory.gudang)
                                    IconButton(
                                      icon: const Icon(Icons.info_outline),
                                      color: Color(0xFFFCA311),
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: const Text(
                                                  'Informasi Ruangan',
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w600)),
                                              content: FutureBuilder(
                                                  future:
                                                      readPeminjamanbyRuanganId(
                                                          ruangan.id),
                                                  builder: (context, snapshot) {
                                                    if (snapshot
                                                            .connectionState ==
                                                        ConnectionState
                                                            .waiting) {
                                                      return const CircularProgressIndicator();
                                                    } else if (snapshot
                                                        .hasError) {
                                                      return SizedBox();
                                                    } else if (snapshot
                                                        .hasData) {
                                                      final Peminjaman
                                                          peminjaman =
                                                          snapshot.data!;
                                                      return FutureBuilder(
                                                          future: readUserById(
                                                              '${peminjaman.userId}'),
                                                          builder: (context,
                                                              snapshot) {
                                                            if (snapshot
                                                                    .connectionState ==
                                                                ConnectionState
                                                                    .waiting) {
                                                              return const CircularProgressIndicator();
                                                            } else if (snapshot
                                                                .hasError) {
                                                              return SizedBox();
                                                            } else if (snapshot
                                                                .hasData) {
                                                              final user =
                                                                  snapshot
                                                                      .data!;
                                                              return FutureBuilder(
                                                                  future: readDetailPeminjamanbyId(
                                                                      peminjaman
                                                                          .detailPeminjamanId),
                                                                  builder: (context,
                                                                      snapshot) {
                                                                    if (snapshot
                                                                            .connectionState ==
                                                                        ConnectionState
                                                                            .waiting) {
                                                                      return const CircularProgressIndicator();
                                                                    } else if (snapshot
                                                                        .hasError) {
                                                                      return SizedBox();
                                                                    } else if (snapshot
                                                                        .hasData) {
                                                                      dpeminjaman =
                                                                          snapshot
                                                                              .data;
                                                                      if ((dpeminjaman!.borrowedDate!.isBefore(DateTime.now()) ||
                                                                              dpeminjaman!.borrowedDate!.isAtSameMomentAs(DateTime
                                                                                  .now())) &&
                                                                          (dpeminjaman!.status ==
                                                                              PeminjamanStatus.approved)) {
                                                                        return SizedBox(
                                                                          height:
                                                                              180,
                                                                          child:
                                                                              Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              Row(
                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                children: [
                                                                                  Text('Kode', style: TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.w600)),
                                                                                  Text(ruangan.code, style: TextStyle(fontSize: 12, color: Colors.black, fontWeight: FontWeight.w600)),
                                                                                ],
                                                                              ),
                                                                              Row(
                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                children: [
                                                                                  Text('Kategori', style: TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.w600)),
                                                                                  Text(ruangan.category.toString().split('.').last, style: TextStyle(fontSize: 12, color: Colors.black, fontWeight: FontWeight.w600)),
                                                                                ],
                                                                              ),
                                                                              Row(
                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                children: [
                                                                                  Text('Kapasitas', style: TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.w600)),
                                                                                  Text('${ruangan.capacity.toString()} Orang', style: TextStyle(fontSize: 12, color: Colors.black, fontWeight: FontWeight.w600)),
                                                                                ],
                                                                              ),
                                                                              Row(
                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                children: [
                                                                                  Text('Status', style: TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.w600)),
                                                                                  Text(ruangan.status ? 'Digunakan' : 'Tidak Digunakan', style: TextStyle(fontSize: 12, color: Colors.black, fontWeight: FontWeight.w600)),
                                                                                ],
                                                                              ),
                                                                              const Gap(4),
                                                                              Text('Peminjaman', style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w600)),
                                                                              Gap(4),
                                                                              Row(
                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                children: [
                                                                                  Text('Dipinjam', style: TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.w600)),
                                                                                  Text(user.name, style: TextStyle(fontSize: 12, color: Colors.black, fontWeight: FontWeight.w600)),
                                                                                ],
                                                                              ),
                                                                              Row(
                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                children: [
                                                                                  Text('Divisi', style: TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.w600)),
                                                                                  Text(user.unit, style: TextStyle(fontSize: 12, color: Colors.black, fontWeight: FontWeight.w600)),
                                                                                ],
                                                                              ),
                                                                              Row(
                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                children: [
                                                                                  Text('Estimasi Selesai', style: TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.w600)),
                                                                                  Text(DateFormat('d MMMM yy', 'id_ID').format(dpeminjaman!.estimatedTime!), style: TextStyle(fontSize: 12, color: Colors.black, fontWeight: FontWeight.w600)),
                                                                                ],
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        );
                                                                      } else {
                                                                        return SizedBox(
                                                                          height:
                                                                              80,
                                                                          child:
                                                                              Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              Row(
                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                children: [
                                                                                  Text('Kode', style: TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.w600)),
                                                                                  Text(ruangan.code, style: TextStyle(fontSize: 12, color: Colors.black, fontWeight: FontWeight.w600)),
                                                                                ],
                                                                              ),
                                                                              Row(
                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                children: [
                                                                                  Text('Kategori', style: TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.w600)),
                                                                                  Text(ruangan.category.toString().split('.').last, style: TextStyle(fontSize: 12, color: Colors.black, fontWeight: FontWeight.w600)),
                                                                                ],
                                                                              ),
                                                                              Row(
                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                children: [
                                                                                  Text('Kapasitas', style: TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.w600)),
                                                                                  Text('${ruangan.capacity.toString()} Orang', style: TextStyle(fontSize: 12, color: Colors.black, fontWeight: FontWeight.w600)),
                                                                                ],
                                                                              ),
                                                                              Row(
                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                children: [
                                                                                  Text('Status', style: TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.w600)),
                                                                                  Text(ruangan.status ? 'Digunakan' : 'Tidak Digunakan', style: TextStyle(fontSize: 12, color: Colors.black, fontWeight: FontWeight.w600)),
                                                                                ],
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        );
                                                                      }
                                                                    } else {
                                                                      return SizedBox(
                                                                        height:
                                                                            80,
                                                                        child:
                                                                            Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: [
                                                                                const Text('Kode', style: TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.w600)),
                                                                                Text(ruangan.code, style: const TextStyle(fontSize: 12, color: Colors.black, fontWeight: FontWeight.w600)),
                                                                              ],
                                                                            ),
                                                                            Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: [
                                                                                Text('Kategori', style: TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.w600)),
                                                                                Text(ruangan.category.toString().split('.').last, style: TextStyle(fontSize: 12, color: Colors.black, fontWeight: FontWeight.w600)),
                                                                              ],
                                                                            ),
                                                                            Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: [
                                                                                Text('Kapasitas', style: TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.w600)),
                                                                                Text('${ruangan.capacity.toString()} Orang', style: TextStyle(fontSize: 12, color: Colors.black, fontWeight: FontWeight.w600)),
                                                                              ],
                                                                            ),
                                                                            Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: [
                                                                                const Text('Status', style: TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.w600)),
                                                                                Text(ruangan.status ? 'Digunakan' : 'Tidak Digunakan', style: const TextStyle(fontSize: 12, color: Colors.black, fontWeight: FontWeight.w600)),
                                                                              ],
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      );
                                                                    }
                                                                  });
                                                            } else {
                                                              return SizedBox(
                                                                height: 80,
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        const Text(
                                                                            'Kode',
                                                                            style: TextStyle(
                                                                                fontSize: 12,
                                                                                color: Colors.grey,
                                                                                fontWeight: FontWeight.w600)),
                                                                        Text(
                                                                            ruangan
                                                                                .code,
                                                                            style: const TextStyle(
                                                                                fontSize: 12,
                                                                                color: Colors.black,
                                                                                fontWeight: FontWeight.w600)),
                                                                      ],
                                                                    ),
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Text(
                                                                            'Kategori',
                                                                            style: TextStyle(
                                                                                fontSize: 12,
                                                                                color: Colors.grey,
                                                                                fontWeight: FontWeight.w600)),
                                                                        Text(ruangan.category.toString().split('.').last,
                                                                            style: TextStyle(
                                                                                fontSize: 12,
                                                                                color: Colors.black,
                                                                                fontWeight: FontWeight.w600)),
                                                                      ],
                                                                    ),
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Text(
                                                                            'Kapasitas',
                                                                            style: TextStyle(
                                                                                fontSize: 12,
                                                                                color: Colors.grey,
                                                                                fontWeight: FontWeight.w600)),
                                                                        Text(
                                                                            '${ruangan.capacity.toString()} Orang',
                                                                            style: TextStyle(
                                                                                fontSize: 12,
                                                                                color: Colors.black,
                                                                                fontWeight: FontWeight.w600)),
                                                                      ],
                                                                    ),
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        const Text(
                                                                            'Status',
                                                                            style: TextStyle(
                                                                                fontSize: 12,
                                                                                color: Colors.grey,
                                                                                fontWeight: FontWeight.w600)),
                                                                        Text(
                                                                            ruangan.status
                                                                                ? 'Digunakan'
                                                                                : 'Tidak Digunakan',
                                                                            style: const TextStyle(
                                                                                fontSize: 12,
                                                                                color: Colors.black,
                                                                                fontWeight: FontWeight.w600)),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              );
                                                            }
                                                          });
                                                    } else {
                                                      return SizedBox(
                                                        height: 80,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                const Text(
                                                                    'Kode',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        color: Colors
                                                                            .grey,
                                                                        fontWeight:
                                                                            FontWeight.w600)),
                                                                Text(
                                                                    ruangan
                                                                        .code,
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        color: Colors
                                                                            .black,
                                                                        fontWeight:
                                                                            FontWeight.w600)),
                                                              ],
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Text('Kategori',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        color: Colors
                                                                            .grey,
                                                                        fontWeight:
                                                                            FontWeight.w600)),
                                                                Text(
                                                                    ruangan
                                                                        .category
                                                                        .toString()
                                                                        .split(
                                                                            '.')
                                                                        .last,
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        color: Colors
                                                                            .black,
                                                                        fontWeight:
                                                                            FontWeight.w600)),
                                                              ],
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Text(
                                                                    'Kapasitas',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        color: Colors
                                                                            .grey,
                                                                        fontWeight:
                                                                            FontWeight.w600)),
                                                                Text(
                                                                    '${ruangan.capacity.toString()} Orang',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        color: Colors
                                                                            .black,
                                                                        fontWeight:
                                                                            FontWeight.w600)),
                                                              ],
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                const Text(
                                                                    'Status',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        color: Colors
                                                                            .grey,
                                                                        fontWeight:
                                                                            FontWeight.w600)),
                                                                Text(
                                                                    ruangan.status
                                                                        ? 'Digunakan'
                                                                        : 'Tidak Digunakan',
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        color: Colors
                                                                            .black,
                                                                        fontWeight:
                                                                            FontWeight.w600)),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    }
                                                  }),
                                              actions: [
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  child: ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      padding: EdgeInsets.zero,
                                                      backgroundColor:
                                                          const Color(
                                                              0xFFFCA311),
                                                    ),
                                                    onPressed: () {
                                                      context.pop();
                                                    },
                                                    child: const Text(
                                                      'OK',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                    )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
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

void onPressed(BuildContext context, Ruangans ruangan, bool isDeeplink) {
  if (!isDeeplink) {
    var param1 = ruangan.id;

    context.push("/ruangan?id=$param1&category=ruangan");
  }
}
