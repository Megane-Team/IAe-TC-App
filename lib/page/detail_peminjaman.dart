import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:inventara/actions/barang/read_barang_action.dart';
import 'package:inventara/actions/kendaraan/read_kendaraan_action.dart';
import 'package:inventara/actions/peminjaman/read_detail_peminjaman_action.dart';
import 'package:inventara/actions/peminjaman/read_peminjaman_action.dart';
import 'package:inventara/actions/peminjaman/update_canceled_detail_peminjaman.dart';
import 'package:inventara/actions/peminjaman/update_returned_detail_peminjaman.dart';
import 'package:inventara/actions/ruangan/read_ruangan_action.dart';
import 'package:inventara/actions/tempat/read_tempat_action.dart';
import 'package:inventara/structures/detailPeminjaman.dart';
import 'package:inventara/structures/peminjaman.dart';
import 'package:inventara/structures/peminjaman_category.dart';
import 'package:inventara/structures/peminjaman_status.dart';
import 'package:inventara/utils/assets.dart';

class DetailPeminjaman extends StatefulWidget {
  final int dpId;
  const DetailPeminjaman({required this.dpId, super.key});

  @override
  State<DetailPeminjaman> createState() => _DetailPeminjamanState();
}

class _DetailPeminjamanState extends State<DetailPeminjaman> {
  final TextEditingController _alasanController = TextEditingController();
  late int dpId;
  late DetailPeminjamans item;

  @override
  void initState() {
    super.initState();
    dpId = widget.dpId;
  }

  Future<String> itemsTempat(
      int id, PeminjamanCategory peminjamanCategory) async {
    if (peminjamanCategory == PeminjamanCategory.barang) {
      var ruangan = await readRuanganbyId(id, context);
      var tempat = await readTempatbyId(ruangan!.id, context);
      return tempat!.name;
    } else if (peminjamanCategory == PeminjamanCategory.kendaraan ||
        peminjamanCategory == PeminjamanCategory.ruangan) {
      var tempat = await readTempatbyId(id, context);
      return tempat!.name;
    }
    return '';
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
        padding: EdgeInsets.only(right: 24, left: 24, top: 20),
        child: FutureBuilder(
            future: readDetailPeminjamanbyId(dpId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              }
              item = snapshot.data!;
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Status Peminjaman',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w600)),
                              if (item.status == PeminjamanStatus.pending) ...[
                                Text('Menunggu Persetujuan',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12)),
                              ] else if (item.status ==
                                  PeminjamanStatus.approved) ...[
                                Text('Berlangsung',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12)),
                              ] else if (item.status ==
                                  PeminjamanStatus.rejected) ...[
                                Text('Ditolak',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12)),
                              ] else if (item.status ==
                                  PeminjamanStatus.returned) ...[
                                Text('Selesai',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12)),
                              ] else if (item.status ==
                                  PeminjamanStatus.canceled) ...[
                                Text('Dibatalkan User',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12)),
                              ],
                            ],
                          ),
                          Gap(8),
                          Divider(height: 1, thickness: 1, color: Colors.black),
                          Gap(8),
                          Text('Informasi Pengajuan',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 12)),
                          ...[
                            Gap(4),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Tanggal Pengajuan',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w600)),
                                Text(
                                    DateFormat('dd MMM yyyy')
                                        .format(item.createdAt),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12)),
                              ],
                            ),
                          ],
                          if (item.borrowedDate != null) ...[
                            Gap(4),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Tanggal Peminjaman',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w600)),
                                Text(
                                    DateFormat('dd MMM yyyy')
                                        .format(item.borrowedDate!),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12)),
                              ],
                            ),
                          ],
                          if (item.estimatedTime != null) ...[
                            Gap(4),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Estimasi Pengembalian',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w600)),
                                Text(
                                    DateFormat('dd MMM yyyy')
                                        .format(item.estimatedTime!),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12)),
                              ],
                            ),
                          ],
                          if (item.returnDate != null) ...[
                            Gap(4),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Tanggal Pengembalian',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w600)),
                                Text(
                                    DateFormat('dd MMM yyyy')
                                        .format(item.returnDate!),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12)),
                              ],
                            ),
                          ],
                          if (item.status == PeminjamanStatus.pending) ...[
                            Gap(4),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Batal Otomatis',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w600)),
                                Text(
                                    DateFormat('dd MMM yyyy').format(
                                        item.createdAt.add(Duration(days: 2))),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12)),
                              ],
                            ),
                          ],
                          Gap(8),
                          Divider(height: 1, thickness: 1, color: Colors.black),
                          Gap(8),
                          Text('Detail Asset',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 12)),
                          FutureBuilder<List<Peminjaman>>(
                              future: readPeminjamanbyDetailId(dpId),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                if (snapshot.hasError) {
                                  return Center(
                                    child: Text('Error: ${snapshot.error}'),
                                  );
                                }
                                List<Peminjaman> peminjamans = snapshot.data!;
                                return ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: peminjamans.length,
                                  itemBuilder: (context, index) {
                                    var peminjaman = peminjamans[index];
                                    if (peminjaman.category ==
                                        PeminjamanCategory.barang) {
                                      return FutureBuilder(
                                          future: readBarangbyId(
                                              peminjaman.barangId.toString()),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              );
                                            }
                                            if (snapshot.hasError) {
                                              return Center(
                                                child: Text(
                                                    'Error: ${snapshot.error}'),
                                              );
                                            }
                                            var asset = snapshot.data!;
                                            return Container(
                                              margin:
                                                  const EdgeInsets.only(top: 8),
                                              decoration: BoxDecoration(),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    width: 60,
                                                    height: 46,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      color: Colors.white,
                                                    ),
                                                    child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        child: FutureBuilder(
                                                          future: Assets.barang(
                                                              asset.photo ??
                                                                  ''),
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
                                                            }
                                                            if (snapshot
                                                                .hasError) {
                                                              return Center(
                                                                child: Text(
                                                                    'Error: ${snapshot.error}'),
                                                              );
                                                            }
                                                            return snapshot
                                                                .data!;
                                                          },
                                                        )),
                                                  ),
                                                  Gap(4),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(asset.name,
                                                          style: TextStyle(
                                                              fontSize: 8,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color:
                                                                  Colors.grey)),
                                                      Text(asset.code,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 12)),
                                                      FutureBuilder<String>(
                                                        future: itemsTempat(
                                                            asset.ruanganId,
                                                            peminjaman
                                                                .category),
                                                        builder: (context,
                                                            snapshot) {
                                                          if (snapshot
                                                                  .connectionState ==
                                                              ConnectionState
                                                                  .waiting) {
                                                            return const CircularProgressIndicator();
                                                          }
                                                          if (snapshot
                                                              .hasError) {
                                                            return Text(
                                                                'Error: ${snapshot.error}');
                                                          }
                                                          return Text(
                                                            snapshot.data!,
                                                            style: TextStyle(
                                                              fontSize: 8,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            );
                                          });
                                    }
                                    if (peminjaman.category ==
                                        PeminjamanCategory.kendaraan) {
                                      return FutureBuilder(
                                          future: readKendaraanbyId(peminjaman
                                              .kendaraanId
                                              .toString()),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              );
                                            }
                                            if (snapshot.hasError) {
                                              return Center(
                                                child: Text(
                                                    'Error: ${snapshot.error}'),
                                              );
                                            }
                                            var asset = snapshot.data!;
                                            return Container(
                                              margin:
                                                  const EdgeInsets.only(top: 8),
                                              decoration: BoxDecoration(),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    width: 60,
                                                    height: 46,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      color: Colors.white,
                                                    ),
                                                    child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        child: FutureBuilder(
                                                          future:
                                                              Assets.kendaraan(
                                                                  asset.photo ??
                                                                      ''),
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
                                                            }
                                                            if (snapshot
                                                                .hasError) {
                                                              return Center(
                                                                child: Text(
                                                                    'Error: ${snapshot.error}'),
                                                              );
                                                            }
                                                            return snapshot
                                                                .data!;
                                                          },
                                                        )),
                                                  ),
                                                  Gap(4),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(asset.name,
                                                          style: TextStyle(
                                                              fontSize: 8,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color:
                                                                  Colors.grey)),
                                                      Text(asset.plat,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 12)),
                                                      FutureBuilder<String>(
                                                        future: itemsTempat(
                                                            asset.tempatId,
                                                            peminjaman
                                                                .category),
                                                        builder: (context,
                                                            snapshot) {
                                                          if (snapshot
                                                                  .connectionState ==
                                                              ConnectionState
                                                                  .waiting) {
                                                            return const CircularProgressIndicator();
                                                          }
                                                          if (snapshot
                                                              .hasError) {
                                                            return Text(
                                                                'Error: ${snapshot.error}');
                                                          }
                                                          return Text(
                                                            snapshot.data!,
                                                            style: TextStyle(
                                                              fontSize: 8,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            );
                                          });
                                    }
                                    if (peminjaman.category ==
                                        PeminjamanCategory.ruangan) {
                                      return FutureBuilder(
                                          future: readRuanganbyId(
                                              peminjaman.ruanganId!, context),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              );
                                            }
                                            if (snapshot.hasError) {
                                              return Center(
                                                child: Text(
                                                    'Error: ${snapshot.error}'),
                                              );
                                            }
                                            var asset = snapshot.data!;
                                            return Container(
                                              margin:
                                                  const EdgeInsets.only(top: 8),
                                              decoration: BoxDecoration(),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    width: 60,
                                                    height: 46,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      color: Colors.white,
                                                    ),
                                                    child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        child: FutureBuilder(
                                                          future:
                                                              Assets.ruangan(
                                                                  asset.photo ??
                                                                      ''),
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
                                                            }
                                                            if (snapshot
                                                                .hasError) {
                                                              return Center(
                                                                child: Text(
                                                                    'Error: ${snapshot.error}'),
                                                              );
                                                            }
                                                            return snapshot
                                                                .data!;
                                                          },
                                                        )),
                                                  ),
                                                  Gap(4),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(asset.code,
                                                          style: TextStyle(
                                                              fontSize: 8,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color:
                                                                  Colors.grey)),
                                                      FutureBuilder<String>(
                                                        future: itemsTempat(
                                                            asset.tempatId,
                                                            peminjaman
                                                                .category),
                                                        builder: (context,
                                                            snapshot) {
                                                          if (snapshot
                                                                  .connectionState ==
                                                              ConnectionState
                                                                  .waiting) {
                                                            return const CircularProgressIndicator();
                                                          }
                                                          if (snapshot
                                                              .hasError) {
                                                            return Text(
                                                                'Error: ${snapshot.error}');
                                                          }
                                                          return Text(
                                                            snapshot.data!,
                                                            style: TextStyle(
                                                              fontSize: 8,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            );
                                          });
                                    }
                                    return null;
                                  },
                                );
                              }),
                          Gap(12),
                          Divider(height: 1, thickness: 1, color: Colors.black),
                          Gap(8),
                          Text('Keterangan',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 12)),
                          if (item.destination != null) ...[
                            Gap(8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Tempat Tujuan',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w600)),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  child: Text(
                                    item.destination!,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12),
                                    textAlign: TextAlign.right,
                                    overflow: TextOverflow.visible,
                                  ),
                                ),
                              ],
                            ),
                          ],
                          if (item.passenger != null) ...[
                            Gap(8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Penumpang',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w600)),
                                Text('${item.passenger} Orang'.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12)),
                              ],
                            ),
                          ],
                          if (item.objective != null) ...[
                            Gap(8),
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('Tujuan',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.w600)),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                      child: Text(
                                        item.objective!,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12),
                                        textAlign: TextAlign.right,
                                        overflow: TextOverflow.visible,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                          if (item.canceledReason != null) ...[
                            Gap(8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Alasan Ditolak',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w600)),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  child: Text(
                                    item.canceledReason!,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12),
                                    textAlign: TextAlign.right,
                                    overflow: TextOverflow.visible,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                  if (item.status == PeminjamanStatus.pending ||
                      DateTime.now().isAfter(item.borrowedDate ??
                          DateTime.now().subtract(Duration(days: 1))))
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 80,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: FloatingActionButton(
                              backgroundColor: const Color(0xFFFCA311),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            8), // Adjust the radius as needed
                                      ),
                                      title: Text(
                                        'Alasan Pembatalan',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 20),
                                      ),
                                      content: Container(
                                        margin: const EdgeInsets.only(top: 28),
                                        width:
                                            MediaQuery.of(context).size.width -
                                                48,
                                        height: 50,
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                          color: Colors.black.withOpacity(0.5),
                                        ))),
                                        child: TextField(
                                          controller: _alasanController,
                                          cursorColor: Colors.black,
                                          decoration: InputDecoration(
                                            hintStyle: const TextStyle(
                                                color: Colors.black54,
                                                fontSize: 16),
                                            hintText:
                                                'ketik alasan dibatalkan...',
                                            border: InputBorder.none,
                                            filled: true,
                                            fillColor: Colors.white,
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 0, horizontal: 0),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide.none,
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              borderSide: BorderSide.none,
                                            ),
                                          ),
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                          child: Text(
                                            'Batal',
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          onPressed: () {
                                            context.pop();
                                          },
                                        ),
                                        TextButton(
                                          child: Text(
                                            'OK',
                                            style: TextStyle(
                                                color: const Color(0xFFFCA311),
                                                fontWeight: FontWeight.w600),
                                          ),
                                          onPressed: () async {
                                            if (await updateCanceledDetailPeminjaman(
                                                    item.id,
                                                    _alasanController.text) ==
                                                true) {
                                              WidgetsBinding.instance
                                                  .addPostFrameCallback((_) {
                                                if (context.mounted) {
                                                  context.pop();
                                                  if (mounted) {
                                                    context.pop();
                                                  }
                                                }
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                    content: Text(
                                                        'Peminjaman berhasil di batalkan!'),
                                                  ),
                                                );
                                              });
                                            }
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: Text(
                                'Batalkan Pengajuan',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  if (item.status == PeminjamanStatus.approved)
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 80,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: FloatingActionButton(
                              backgroundColor: const Color(0xFFFCA311),
                              onPressed: () async {
                                if (await updateReturnedDetailPeminjaman(
                                        item.id) ==
                                    true) {
                                  WidgetsBinding.instance
                                      .addPostFrameCallback((_) {
                                    if (context.mounted) {
                                      context.pop();
                                    }
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                            'Peminjaman berhasil di selesaikan!'),
                                      ),
                                    );
                                  });
                                }
                              },
                              child: Text(
                                'Selesaikan Peminjaman',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                ],
              );
            }),
      ),
    );
  }
}
