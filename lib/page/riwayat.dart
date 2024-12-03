import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:gap/gap.dart';
import 'package:inventara/actions/barang/read_barang_action.dart';
import 'package:inventara/actions/kendaraan/read_kendaraan_action.dart';
import 'package:inventara/actions/peminjaman/read_peminjaman_action.dart';
import 'package:inventara/actions/ruangan/read_ruangan_action.dart';
import 'package:inventara/actions/tempat/read_tempat_action.dart';
import 'package:inventara/structures/barang.dart';
import 'package:inventara/structures/kendaraan.dart';
import 'package:inventara/structures/peminjaman.dart';
import 'package:inventara/structures/peminjaman_category.dart';
import 'package:inventara/structures/peminjaman_status.dart';
import 'package:inventara/structures/ruangan.dart';
import 'package:inventara/structures/tempat.dart';

import 'package:inventara/utils/actionwidget.dart';
import 'package:inventara/utils/assets.dart';

class Riwayat extends StatefulWidget {
  const Riwayat({super.key});

  @override
  State<Riwayat> createState() => RiwayatState();
}

class RiwayatState extends State<Riwayat> {
  bool isBerlangsungActive = true;
  bool isSelesaiActive = false;
  late List<Barang> barangs;
  late List<Peminjaman> peminjamans;
  late List<Ruangans> ruangans;
  late List<Tempat> tempats;
  late List<Kendaraan> kendaraans;
  late Future<void> fetchDataFuture;

  String peminjamanStatusToString(PeminjamanStatus ps) {
    switch (ps) {
      case PeminjamanStatus.pending:
        return 'Menunggu Konfirmasi';
      case PeminjamanStatus.approved:
        return 'Disetujui';
      case PeminjamanStatus.rejected:
        return 'Ditolak';
      case PeminjamanStatus.canceled:
        return 'Dibatalkan';
      case PeminjamanStatus.returned:
        return 'Selesai';
      default:
        return 'Unknown';
    }
  }

  String getAsetName(Peminjaman peminjaman) {
    var name;

    if (peminjaman.category == PeminjamanCategory.barang) {
      name = barangs.firstWhere((b) => b.id == peminjaman.barangId).name;
    } else if (peminjaman.category == PeminjamanCategory.ruangan) {
      name = ruangans.firstWhere((r) => r.id == peminjaman.ruanganId).code;
    } else if (peminjaman.category == PeminjamanCategory.kendaraan) {
      name = kendaraans.firstWhere((t) => t.id == peminjaman.kendaraanId).name;
    }

    return name ?? '';
  }

  String tempatPhotoUsed(Peminjaman peminjaman) {
    int itemId;
    String? photo;

    if (peminjaman.category == PeminjamanCategory.barang) {
      itemId = barangs.firstWhere((b) => b.id == peminjaman.barangId).id;
      photo = barangs.firstWhere((b) => b.id == itemId).photo;
    } else if (peminjaman.category == PeminjamanCategory.kendaraan) {
      itemId = kendaraans.firstWhere((k) => k.id == peminjaman.kendaraanId).id;
      photo = kendaraans.firstWhere((k) => k.id == itemId).photo;
    } else {
      itemId = ruangans.firstWhere((r) => r.id == peminjaman.ruanganId).id;
      photo = ruangans.firstWhere((r) => r.id == itemId).photo;
    }

    return photo ?? '';
  }

  Future<Widget> asetPhoto(Peminjaman peminjaman) {
    var photoName = tempatPhotoUsed(peminjaman);
    if (peminjaman.category == PeminjamanCategory.barang) {
      return Assets.barang(photoName);
    } else if (peminjaman.category == PeminjamanCategory.kendaraan) {
      return Assets.kendaraan(photoName);
    } else {
      return Assets.ruangan(photoName);
    }
  }

  String getTempatName(Peminjaman peminjaman) {
    int? tempatId;

    if (peminjaman.category == PeminjamanCategory.barang) {
      var barangItem = barangs.firstWhere((b) => b.id == peminjaman.barangId);
      tempatId =
          ruangans.firstWhere((r) => r.id == barangItem.ruanganId).tempatId;
    } else if (peminjaman.category == PeminjamanCategory.kendaraan) {
      tempatId =
          kendaraans.firstWhere((k) => k.id == peminjaman.kendaraanId).tempatId;
    }

    return tempats.firstWhere((t) => t.id == tempatId).name;
  }

  Future<void> fetchData() async {
    barangs = await readBarang('', context);
    ruangans = await readRuangan('', context);
    tempats = await readTempat('', context);
    kendaraans = await readKendaraan('', context);
  }

  @override
  void initState() {
    super.initState();
    fetchDataFuture = fetchData();
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
                        width: 2.0,
                      ),
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
                      padding: EdgeInsets.zero,
                      minimumSize: const Size(double.infinity, 48),
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
                      padding: EdgeInsets.zero,
                      minimumSize: const Size(double.infinity, 48),
                    ),
                    child: const Text("Selesai",
                        style: TextStyle(color: Colors.black)),
                  ),
                )
              ],
            ),
            const Gap(20),
            Expanded(
              child: FutureBuilder<void>(
                  future: fetchDataFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapshot.hasError) {
                      return Center(child: noData());
                    } else {
                      return FutureBuilder(
                          future: readDetailPeminjaman(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            if (snapshot.hasError) {
                              print(snapshot.error.toString());
                              return noData();
                            }
                            if (snapshot.hasData) {
                              var peminjaman = snapshot.data!;
                              if (peminjaman.isEmpty) {
                                return Center(child: SizedBox());
                              }
                              return ListView.builder(
                                shrinkWrap: true,
                                itemCount: isBerlangsungActive
                                    ? peminjaman
                                        .where((item) =>
                                            item.status ==
                                                PeminjamanStatus.approved ||
                                            item.status ==
                                                PeminjamanStatus.pending)
                                        .length
                                    : peminjaman
                                        .where((item) =>
                                            item.status ==
                                                PeminjamanStatus.canceled ||
                                            item.status ==
                                                PeminjamanStatus.returned ||
                                            item.status ==
                                                PeminjamanStatus.rejected)
                                        .length,
                                itemBuilder: (context, index) {
                                  var filteredList = isBerlangsungActive
                                      ? peminjaman
                                          .where((item) =>
                                              item.status ==
                                                  PeminjamanStatus.approved ||
                                              item.status ==
                                                  PeminjamanStatus.pending)
                                          .toList()
                                      : peminjaman
                                          .where((item) =>
                                              item.status ==
                                                  PeminjamanStatus.canceled ||
                                              item.status ==
                                                  PeminjamanStatus.returned ||
                                              item.status ==
                                                  PeminjamanStatus.rejected)
                                          .toList();
                                  filteredList.sort((a, b) =>
                                      b.createdAt.compareTo(a.createdAt));
                                  var p = filteredList[index];
                                  return FutureBuilder(
                                    future: readPeminjamanbyDetailId(p.id),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                      if (snapshot.hasError) {
                                        return Center(child: noData());
                                      }
                                      if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                                        peminjamans = snapshot.data!;
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 24),
                                          child: SingleChildScrollView(
                                            child: Container(
                                              margin:
                                              const EdgeInsets.only(bottom: 8),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color:
                                                    Colors.black.withOpacity(0.1),
                                                    spreadRadius: 1,
                                                    blurRadius: 4,
                                                    offset: const Offset(0, 0),
                                                  ),
                                                ],
                                                borderRadius:
                                                BorderRadius.circular(8),
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  // Header
                                                  Container(
                                                    decoration: const BoxDecoration(
                                                      border: Border(
                                                          bottom: BorderSide(
                                                              color: Colors.black12,
                                                              width: 1)),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                      const EdgeInsets.symmetric(
                                                          horizontal: 8,
                                                          vertical: 8),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                        children: [
                                                          Text(
                                                            DateFormat('dd MMM yyyy')
                                                                .format(p.createdAt),
                                                            style: const TextStyle(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                FontWeight.w500),
                                                          ),
                                                          Text(
                                                            peminjamanStatusToString(
                                                                p.status),
                                                            style: const TextStyle(
                                                                fontSize: 14,
                                                                color: Colors.black),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                    children: [
                                                      Expanded(
                                                        child: Padding(
                                                          padding:
                                                          const EdgeInsets.only(
                                                              bottom: 8,
                                                              left: 8,
                                                              top: 8),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Container(
                                                                    width: 60,
                                                                    height: 50,
                                                                    decoration:
                                                                    BoxDecoration(
                                                                      color: Colors
                                                                          .grey[200],
                                                                      borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                          8),
                                                                    ),
                                                                    child:
                                                                    ClipRRect(
                                                                      borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                          8),
                                                                      child: FutureBuilder
                                                                        (future: asetPhoto(peminjamans[0]),
                                                                          builder: (context, snapshot) {
                                                                            if (snapshot.connectionState == ConnectionState.waiting) {
                                                                              return const Center(
                                                                                child: CircularProgressIndicator(),
                                                                              );
                                                                            }
                                                                            if (snapshot.hasError) {
                                                                              return Center(child: noData());
                                                                            }
                                                                            if (snapshot.hasData) {
                                                                              return snapshot.data!;
                                                                            } else {
                                                                              return const SizedBox();
                                                                            }
                                                                          }
                                                                      ),
                                                                    )
                                                                  ),
                                                                  const SizedBox(
                                                                      width: 8),
                                                                  Expanded(
                                                                    child: Column(
                                                                      crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                      children: [
                                                                        Text(
                                                                          getAsetName(peminjamans[0]),
                                                                          style:
                                                                          const TextStyle(
                                                                            fontSize:
                                                                            16,
                                                                            fontWeight:
                                                                            FontWeight
                                                                                .w600,
                                                                          ),
                                                                        ),
                                                                        Text(
                                                                          getTempatName(peminjamans[0]),
                                                                          style:
                                                                          const TextStyle(
                                                                            fontSize:
                                                                            14,
                                                                            color: Colors
                                                                                .grey,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              const SizedBox(
                                                                  height: 8),
                                                              if (peminjamans.length > 1)
                                                                Text(
                                                                  '+${peminjamans.length - 1} Barang lainnya',
                                                                  style: const TextStyle(
                                                                      fontSize: 14,
                                                                      color: Colors.grey),
                                                                ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                        const EdgeInsets.only(
                                                            bottom: 8, right: 8),
                                                        child: Container(
                                                          width: 100,
                                                          height: 30,
                                                          decoration: BoxDecoration(
                                                            borderRadius:
                                                            BorderRadius.circular(
                                                                8),
                                                          ),
                                                          child: ElevatedButton(
                                                            onPressed: () {},
                                                            style: ElevatedButton
                                                                .styleFrom(
                                                              padding:
                                                              EdgeInsets.zero,
                                                              maximumSize:
                                                              const Size(100, 40),
                                                              backgroundColor:
                                                              Colors.orange,
                                                              shape:
                                                              RoundedRectangleBorder(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(8),
                                                              ),
                                                            ),
                                                            child: const Text(
                                                              'Detail',
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      } else {
                                        return Center(child: Text(snapshot.data.toString()));
                                      }
                                    }
                                  );
                                },
                              );
                            } else {
                              return Center(child: SizedBox());
                            }
                          });
                    }
                  }),
            ),
          ],
        ));
  }
}
