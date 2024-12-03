import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:inventara/actions/barang/read_barang_action.dart';
import 'package:inventara/actions/kendaraan/read_kendaraan_action.dart';
import 'package:inventara/actions/peminjaman/delete_peminjaman_action.dart';
import 'package:inventara/actions/peminjaman/read_peminjaman_action.dart';
import 'package:inventara/actions/ruangan/read_ruangan_action.dart';
import 'package:inventara/actions/tempat/read_tempat_action.dart';
import 'package:inventara/structures/barang.dart';
import 'package:inventara/structures/kendaraan.dart';
import 'package:inventara/structures/peminjaman.dart';
import 'package:inventara/structures/peminjaman_category.dart';
import 'package:inventara/structures/ruangan.dart';
import 'package:inventara/structures/tempat.dart';
import 'package:inventara/utils/assets.dart';

class Keranjang extends StatefulWidget {
  const Keranjang({super.key});

  @override
  State<Keranjang> createState() => KeranjangState();
}

class KeranjangState extends State<Keranjang> {
  late Future<void> fetchDataFuture;
  late List<Tempat> tempat;
  late List<Ruangans> ruangan;
  late List<Barang> barang;
  late List<Kendaraan> kendaraan;

  @override
  void initState() {
    super.initState();
    fetchDataFuture = fetchData();
  }

  Future<void> fetchData() async {
    tempat = await readTempat('', context);
    ruangan = await readRuangan('', context);
    kendaraan = await readKendaraan('', context);
    barang = await readBarang('', context);
  }

  List<String> tempatNamesUsed(List<Peminjaman> peminjaman) {
    List<int> tempatIds = [];

    for (var item in peminjaman) {
      int? tempatId;

      if (item.category == PeminjamanCategory.ruangan) {
        tempatId = ruangan.firstWhere((r) => r.id == item.ruanganId).tempatId;
      } else if (item.category == PeminjamanCategory.barang) {
        var barangItem = barang.firstWhere((b) => b.id == item.barangId);
        tempatId =
            ruangan.firstWhere((r) => r.id == barangItem.ruanganId).tempatId;
      } else if (item.category == PeminjamanCategory.kendaraan) {
        tempatId =
            kendaraan.firstWhere((k) => k.id == item.kendaraanId).tempatId;
      }

      if (tempatId != null && !tempatIds.contains(tempatId)) {
        tempatIds.add(tempatId);
      }
    }
    return tempatIds
        .map((id) => tempat.firstWhere((t) => t.id == id).name)
        .toList()
      ..sort((a, b) => a.compareTo(b));
  }

  String tempatNameUsed(Peminjaman peminjaman) {
    int? tempatId;

    if (peminjaman.category == PeminjamanCategory.barang) {
      var barangItem = barang.firstWhere((b) => b.id == peminjaman.barangId);
      tempatId =
          ruangan.firstWhere((r) => r.id == barangItem.ruanganId).tempatId;
    } else if (peminjaman.category == PeminjamanCategory.kendaraan) {
      tempatId =
          kendaraan.firstWhere((k) => k.id == peminjaman.kendaraanId).tempatId;
    }

    return tempat.firstWhere((t) => t.id == tempatId).name;
  }

  String tempatPhotoUsed(Peminjaman peminjaman) {
    int itemId;
    String? photo;

    if (peminjaman.category == PeminjamanCategory.barang) {
      itemId = barang.firstWhere((b) => b.id == peminjaman.barangId).id;
      photo = barang.firstWhere((b) => b.id == itemId).photo;
    } else if (peminjaman.category == PeminjamanCategory.kendaraan) {
      itemId = kendaraan.firstWhere((k) => k.id == peminjaman.kendaraanId).id;
      photo = kendaraan.firstWhere((k) => k.id == itemId).photo;
    }

    return photo ?? '';
  }

  Future<Widget> itemPhoto(Peminjaman peminjaman) {
    var photoName = tempatPhotoUsed(peminjaman);
    if (peminjaman.category == PeminjamanCategory.barang) {
      return Assets.barang(photoName);
    } else {
      return Assets.kendaraan(photoName);
    }
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
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 4,
                      offset: const Offset(0, 0),
                    )
                  ],
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  onPressed: () {
                    context.pop();
                  },
                  icon: const Icon(Icons.navigate_before),
                ),
              ),
              Center(
                child: const Text(
                  'Keranjang Peminjaman',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ),
              const Gap(40)
            ],
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  fetchData();
                },
                child: SingleChildScrollView(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 24, left: 24, right: 24),
                    child: Column(
                      children: [
                        FutureBuilder<void>(
                          future: fetchDataFuture,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (snapshot.hasError) {
                              return Center(
                                child: SizedBox(),
                              );
                            } else {
                              return FutureBuilder<List<Peminjaman>>(
                                future: readDraftPeminjaman(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  } else if (snapshot.hasError) {
                                    return Center(
                                      child: Text(snapshot.error.toString()),
                                    );
                                  } else if (snapshot.hasData) {
                                    var peminjaman = snapshot.data!;
                                    return ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount:
                                          tempatNamesUsed(peminjaman).length,
                                      itemBuilder: (context, index) {
                                        final uniqueAsal =
                                            tempatNamesUsed(peminjaman);
                                        return Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.1),
                                                spreadRadius: 1,
                                                blurRadius: 4,
                                                offset: const Offset(0, 0),
                                              )
                                            ],
                                          ),
                                          padding: const EdgeInsets.only(
                                              left: 8,
                                              right: 8,
                                              top: 8,
                                              bottom: 24),
                                          margin:
                                              const EdgeInsets.only(bottom: 20),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                uniqueAsal[index],
                                                style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 4),
                                                child: ListView.builder(
                                                  shrinkWrap: true,
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  itemCount: peminjaman
                                                      .where((item) =>
                                                          tempatNameUsed(
                                                              item) ==
                                                          uniqueAsal[index])
                                                      .length,
                                                  itemBuilder:
                                                      (context, subIndex) {
                                                    final itemsInTempat =
                                                        peminjaman
                                                            .where((item) =>
                                                                tempatNameUsed(
                                                                    item) ==
                                                                uniqueAsal[
                                                                    index])
                                                            .toList();
                                                    final item =
                                                        itemsInTempat[subIndex];
                                                    return Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              top: 4),
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 12),
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      height: 60,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.black
                                                                .withOpacity(
                                                                    0.1),
                                                            spreadRadius: 1,
                                                            blurRadius: 4,
                                                            offset:
                                                                const Offset(
                                                                    0, 0),
                                                          )
                                                        ],
                                                        border: const Border(
                                                          left: BorderSide(
                                                            color: Color(
                                                                0xFFFCA311),
                                                            width: 3,
                                                          ),
                                                        ),
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Container(
                                                                width: 60,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8),
                                                                ),
                                                                child:
                                                                    FutureBuilder(
                                                                  future:
                                                                      itemPhoto(
                                                                          item),
                                                                  builder: (context,
                                                                      snapshot) {
                                                                    if (snapshot
                                                                            .connectionState ==
                                                                        ConnectionState
                                                                            .waiting) {
                                                                      return const Center(
                                                                        child:
                                                                            CircularProgressIndicator(),
                                                                      );
                                                                    } else if (snapshot
                                                                        .hasError) {
                                                                      return snapshot
                                                                          .data!;
                                                                    } else if (snapshot
                                                                        .hasData) {
                                                                      return snapshot
                                                                          .data!;
                                                                    } else {
                                                                      return snapshot
                                                                          .data!;
                                                                    }
                                                                  },
                                                                ),
                                                              ),
                                                              const Gap(10),
                                                              Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  if (item.category ==
                                                                      PeminjamanCategory
                                                                          .barang) ...[
                                                                    Text(
                                                                      '${barang.firstWhere((b) => b.id == item.barangId).name} (${barang.firstWhere((b) => b.id == item.barangId).code})',
                                                                      style: const TextStyle(
                                                                          fontSize:
                                                                              16,
                                                                          fontWeight:
                                                                              FontWeight.w500),
                                                                    ),
                                                                    Text(
                                                                      ruangan
                                                                          .firstWhere((r) =>
                                                                              r.id ==
                                                                              barang.firstWhere((b) => b.id == item.barangId).ruanganId)
                                                                          .code,
                                                                      style: const TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          color:
                                                                              Colors.black54),
                                                                    ),
                                                                  ] else if (item
                                                                          .category ==
                                                                      PeminjamanCategory
                                                                          .ruangan) ...[
                                                                    Text(
                                                                      ruangan
                                                                          .firstWhere((r) =>
                                                                              r.id ==
                                                                              item.ruanganId)
                                                                          .code,
                                                                      style: const TextStyle(
                                                                          fontSize:
                                                                              16,
                                                                          fontWeight:
                                                                              FontWeight.w500),
                                                                    ),
                                                                    Text(
                                                                      ruangan
                                                                          .firstWhere((r) =>
                                                                              r.id ==
                                                                              item.ruanganId)
                                                                          .status ? 'Tidak digunakan' : 'Digunakan',
                                                                      style: const TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          color:
                                                                              Colors.black54),
                                                                    ),
                                                                  ] else if (item
                                                                          .category ==
                                                                      PeminjamanCategory
                                                                          .kendaraan) ...[
                                                                    Text(
                                                                      kendaraan
                                                                          .firstWhere((k) =>
                                                                              k.id ==
                                                                              item.kendaraanId)
                                                                          .name,
                                                                      style: const TextStyle(
                                                                          fontSize:
                                                                              16,
                                                                          fontWeight:
                                                                              FontWeight.w500),
                                                                    ),
                                                                    Text(
                                                                      kendaraan
                                                                          .firstWhere((k) =>
                                                                              k.id ==
                                                                              item.kendaraanId)
                                                                          .category
                                                                          .toString()
                                                                          .split('.')
                                                                          .last,
                                                                      style: const TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          color:
                                                                              Colors.black54),
                                                                    ),
                                                                  ]
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          IconButton(
                                                            onPressed: () {
                                                              // show an pop up confirmation
                                                              showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) {
                                                                  return AlertDialog(
                                                                    title: const Text(
                                                                        'Konfirmasi'),
                                                                    content:
                                                                        const Text(
                                                                            'Apakah anda yakin ingin menghapus item ini?'),
                                                                    actions: [
                                                                      TextButton(
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.of(context)
                                                                              .pop();
                                                                        },
                                                                        child:
                                                                            const Text(
                                                                          'Batal',
                                                                          style:
                                                                              TextStyle(color: Colors.black54),
                                                                        ),
                                                                      ),
                                                                      TextButton(
                                                                        onPressed:
                                                                            () async {
                                                                          await deletePeminjaman(
                                                                              item.id);
                                                                          Navigator.of(context)
                                                                              .pop();
                                                                          setState(
                                                                              () {});
                                                                        },
                                                                        child:
                                                                            const Text(
                                                                          'Hapus',
                                                                          style:
                                                                              TextStyle(color: Colors.red),
                                                                        ),
                                                                      )
                                                                    ],
                                                                  );
                                                                },
                                                              );
                                                            },
                                                            icon: const Icon(
                                                              Icons.delete,
                                                              color: Colors.red,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                ),
                                              )
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  } else {
                                    return const SizedBox();
                                  }
                                },
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(
                width: MediaQuery.of(context).size.width,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 4,
                      offset: const Offset(0, 0),
                    )
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(right: 24, left: 24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: FloatingActionButton(
                          backgroundColor: const Color(0xFFFCA311),
                          onPressed: () {},
                          child: const Text(
                            'Ajukan Peminjaman',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ],
                  ),
                ))
          ],
        ));
  }
}
