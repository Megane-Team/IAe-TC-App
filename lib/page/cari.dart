import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:inventara/actions/barang/read_barang_action.dart';
import 'package:inventara/actions/kendaraan/read_kendaraan_action.dart';
import 'package:inventara/actions/peminjaman/create_detail_peminjaman_action.dart';
import 'package:inventara/actions/peminjaman/create_peminjaman_action.dart';
import 'package:inventara/actions/peminjaman/read_detail_peminjaman_action.dart';
import 'package:inventara/actions/peminjaman/read_peminjaman_action.dart';
import 'package:inventara/actions/users/read_user_action.dart';
import 'package:inventara/structures/barang.dart';
import 'package:inventara/structures/detail_peminjaman.dart';
import 'package:inventara/structures/kendaraan.dart';
import 'package:inventara/structures/peminjaman.dart';
import 'package:inventara/structures/user.dart';
import 'package:inventara/utils/assets.dart';

class Cari extends StatefulWidget {
  final int id;
  final bool isRuangan;
  const Cari({required this.id, required this.isRuangan, super.key});

  @override
  State<Cari> createState() => CariState();
}

class CariState extends State<Cari> {
  late List<Barang> barangs;
  late List<Barang> bfilteredList;
  late List<Kendaraan> kendaraans;
  late List<Kendaraan> kfilteredList;
  late bool isRuangan = widget.isRuangan;
  late Future<void> fetchDataFuture;

  Future<void> fetchData() async {
    if (isRuangan) {
      barangs = await readBarangbyRuanganId('${widget.id}', context);
    } else {
      kendaraans = await readKendaraanByGedungId('${widget.id}', context);
    }
    _filterAndUpdateList('');
  }

  @override
  void initState() {
    super.initState();
    fetchDataFuture = fetchData();
  }

  void _filterAndUpdateList(String value) {
    setState(() {
      if (isRuangan) {
        if (value.isEmpty) {
          bfilteredList = List.from(barangs);
        } else {
          bfilteredList = barangs
              .where((item) =>
                  item.name.toLowerCase().contains(value.toLowerCase()) ||
                  item.code.toLowerCase().contains(value.toLowerCase()))
              .toList();
        }
      } else {
        if (value.isEmpty) {
          kfilteredList = List.from(kendaraans);
        } else {
          kfilteredList = kendaraans
              .where((item2) =>
                  item2.name.toLowerCase().contains(value.toLowerCase()) ||
                  item2.plat.toLowerCase().contains(value.toLowerCase()))
              .toList();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 12),
                width: MediaQuery.of(context).size.width - 110,
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
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    hintStyle: const TextStyle(
                        color: Colors.black54,
                        fontSize: 16,
                        fontWeight: FontWeight.w100),
                    hintText:
                        isRuangan ? 'Cari barang...' : 'Cari kendaraan...',
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
                  onChanged: _filterAndUpdateList,
                ),
              ),
              TextButton(
                onPressed: () {
                  context.pop();
                },
                child: const Column(
                  children: [
                    Gap(12),
                    Text(
                      'Batal',
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: FutureBuilder(
            future: fetchDataFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView.builder(
                itemCount:
                    isRuangan ? bfilteredList.length : kfilteredList.length,
                itemBuilder: (context, index) {
                  late Barang item;
                  late Kendaraan item2;
                  if (isRuangan) {
                    item = bfilteredList[index];
                  } else {
                    item2 = kfilteredList[index];
                  }
                  return Container(
                    margin: const EdgeInsets.only(top: 10),
                    width: MediaQuery.of(context).size.width,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
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
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 4,
                        backgroundColor: Colors.white,
                        shadowColor: Colors.black.withOpacity(0.1),
                      ),
                      onPressed: () {
                        if (isRuangan) {
                          showModalBottomSheet(
                            showDragHandle: true,
                            context: context,
                            builder: (BuildContext context) {
                              return SingleChildScrollView(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 24, right: 24, bottom: 32),
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    height: 380,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 218,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: FutureBuilder<Widget>(
                                                future: Assets.barang(
                                                    item.photo ?? ''),
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
                                        Gap(8),
                                        Text(
                                          item.code,
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Gap(4),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('Nama'),
                                            Text(item.name,
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w600)),
                                          ],
                                        ),
                                        Gap(4),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('Kondisi'),
                                            Text(item.condition,
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w600)),
                                          ],
                                        ),
                                        Gap(4),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('Garansi'),
                                            Text(
                                                DateFormat('dd MMM yy')
                                                    .format(item.warranty),
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w600)),
                                          ],
                                        ),
                                        Expanded(child: SizedBox()),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2.4,
                                              child: ElevatedButton(
                                                onPressed: () async {
                                                  DetailPeminjamans dp =
                                                      await createDetailPeminjaman(
                                                          status: 'draft');

                                                  var res =
                                                      await createPeminjaman(
                                                          dp.id,
                                                          item.id,
                                                          null,
                                                          null,
                                                          'barang');

                                                  if (res == 200) {
                                                    WidgetsBinding.instance
                                                        .addPostFrameCallback(
                                                            (_) {
                                                      if (context.mounted) {
                                                        context.pop();
                                                      }
                                                    });
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      const SnackBar(
                                                        content: Text(
                                                            'Barang Disimpan di Keranjang'),
                                                      ),
                                                    );
                                                  } else {
                                                    WidgetsBinding.instance
                                                        .addPostFrameCallback(
                                                            (_) {
                                                      if (context.mounted) {
                                                        context.pop();
                                                      }
                                                    });
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      const SnackBar(
                                                        content: Text(
                                                            'Barang sudah berada di keranjang!'),
                                                      ),
                                                    );
                                                  }
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  padding: EdgeInsets.zero,
                                                  side: const BorderSide(
                                                      color: Color(0xFFFCA311)),
                                                ),
                                                child: const Text(
                                                  'Masukan keranjang',
                                                  style: TextStyle(
                                                      color: Color(0xFFFCA311),
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2.4,
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  var param = item.id;
                                                  context.push(
                                                      '/KonfA?id=$param&category=barang');
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  padding: EdgeInsets.zero,
                                                  backgroundColor:
                                                      const Color(0xFFFCA311),
                                                  side: const BorderSide(
                                                      color: Color(0xFFFCA311)),
                                                ),
                                                child: const Text(
                                                  'Pinjam Barang',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w600),
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
                            },
                          );
                        } else {
                          showModalBottomSheet(
                            showDragHandle: true,
                            context: context,
                            builder: (BuildContext context) {
                              return SingleChildScrollView(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 24, right: 24, bottom: 24),
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    height: 420,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: 218,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: FutureBuilder<Widget>(
                                                  future: Assets.kendaraan(
                                                      item2.photo ?? ''),
                                                  builder: (context, snapshot) {
                                                    if (snapshot
                                                            .connectionState ==
                                                        ConnectionState
                                                            .waiting) {
                                                      return const CircularProgressIndicator(); // Show a loading indicator while waiting
                                                    } else if (snapshot
                                                        .hasError) {
                                                      return Image.asset(Assets
                                                          .noImage()); // Show error message if any
                                                    } else if (snapshot
                                                        .hasData) {
                                                      return snapshot
                                                          .data!; // Return the widget once the future completes
                                                    } else {
                                                      return const Text(
                                                          'No data available'); // Show message if no data
                                                    }
                                                  },
                                                ),
                                              ),
                                            ),
                                            Gap(8),
                                            Text(
                                              item2.plat,
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            Gap(4),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text('Nama'),
                                                Text(item2.name,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600)),
                                              ],
                                            ),
                                            Gap(4),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text('Kategori'),
                                                Text(
                                                    item2.category
                                                        .toString()
                                                        .split('.')
                                                        .last,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600)),
                                              ],
                                            ),
                                            Gap(4),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text('Kondisi'),
                                                Text(item2.condition,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600)),
                                              ],
                                            ),
                                            Gap(4),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text('Pajak'),
                                                Text(
                                                    DateFormat('yyyy MMM dd')
                                                        .format(item2.tax),
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600)),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Container(
                                          padding:
                                              const EdgeInsets.only(top: 16),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2.4,
                                                child: ElevatedButton(
                                                  onPressed: () async {
                                                    DetailPeminjamans dp =
                                                        await createDetailPeminjaman(
                                                            status: 'draft');

                                                    var res =
                                                        await createPeminjaman(
                                                            dp.id,
                                                            null,
                                                            null,
                                                            item2.id,
                                                            'kendaraan');

                                                    if (res == 200) {
                                                      WidgetsBinding.instance
                                                          .addPostFrameCallback(
                                                              (_) {
                                                        if (context.mounted) {
                                                          context.pop();
                                                        }
                                                      });
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        const SnackBar(
                                                          content: Text(
                                                              'Kendaraan Disimpan di Keranjang'),
                                                        ),
                                                      );
                                                    } else {
                                                      WidgetsBinding.instance
                                                          .addPostFrameCallback(
                                                              (_) {
                                                        if (context.mounted) {
                                                          context.pop();
                                                        }
                                                      });
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        const SnackBar(
                                                          content: Text(
                                                              'Kendaraan sudah berada di keranjang!'),
                                                        ),
                                                      );
                                                    }
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    padding: EdgeInsets.zero,
                                                    side: const BorderSide(
                                                        color:
                                                            Color(0xFFFCA311)),
                                                  ),
                                                  child: const Text(
                                                    'Masukan Keranjang',
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xFFFCA311),
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2.4,
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    var param = item2.id;
                                                    context.push(
                                                        '/KonfK?id=$param&category=kendaraan');
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    padding: EdgeInsets.zero,
                                                    backgroundColor:
                                                        const Color(0xFFFCA311),
                                                    side: const BorderSide(
                                                        color:
                                                            Color(0xFFFCA311)),
                                                  ),
                                                  child: const Text(
                                                    'Pinjam Barang',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                  width: 60,
                                  height: 46,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: isRuangan
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: FutureBuilder(
                                              future: Assets.barang(
                                                  item.photo ?? ''),
                                              builder: (context, snapshot) {
                                                if (snapshot.connectionState ==
                                                    ConnectionState.done) {
                                                  return snapshot.data
                                                      as Widget;
                                                } else {
                                                  return const Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  );
                                                }
                                              }),
                                        )
                                      : ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: FutureBuilder(
                                              future: Assets.kendaraan(
                                                  item2.photo ?? ''),
                                              builder: (context, snapshot) {
                                                if (snapshot.connectionState ==
                                                    ConnectionState.done) {
                                                  return snapshot.data
                                                      as Widget;
                                                } else {
                                                  return const Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  );
                                                }
                                              }),
                                        )),
                              const Gap(4),
                              if (isRuangan) ...[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.code,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      item.condition,
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 12),
                                    ),
                                  ],
                                ),
                              ] else ...[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item2.plat,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      item2.condition,
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 12),
                                    ),
                                  ],
                                ),
                              ],
                            ],
                          ),
                          if (isRuangan) ...[
                            if (item.status)
                              IconButton(
                                icon: Icon(Icons.info_outline,
                                    color: Color(0xFFFCA311)),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text(
                                          'Asset sedang Digunakan',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600),
                                        ),
                                        content: FutureBuilder(
                                            future: readPeminjamanbyBarangId(
                                                item.id),
                                            builder: (context, snapshot) {
                                              if (snapshot.connectionState ==
                                                  ConnectionState.waiting) {
                                                return const CircularProgressIndicator(); // Show a loading indicator while waiting
                                              } else if (snapshot.hasError) {
                                                return const Text(
                                                    'Data tidak tersedia'); // Show error message if any
                                              } else if (snapshot.hasData) {
                                                final Peminjaman peminjaman =
                                                    snapshot.data!;
                                                return FutureBuilder(
                                                    future: readUserById(
                                                        '${peminjaman.userId}'),
                                                    builder:
                                                        (context, snapshot) {
                                                      if (snapshot
                                                              .connectionState ==
                                                          ConnectionState
                                                              .waiting) {
                                                        return const CircularProgressIndicator(); // Show a loading indicator while waiting
                                                      } else if (snapshot
                                                          .hasError) {
                                                        return const Text(
                                                            'Data tidak tersedia'); // Show error message if any
                                                      } else if (snapshot
                                                          .hasData) {
                                                        final User user =
                                                            snapshot.data!;
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
                                                                return const CircularProgressIndicator(); // Show a loading indicator while waiting
                                                              } else if (snapshot
                                                                  .hasError) {
                                                                return const Text(
                                                                    'Data tidak tersedia'); // Show error message if any
                                                              } else if (snapshot
                                                                  .hasData) {
                                                                final DetailPeminjamans
                                                                    dpeminjaman =
                                                                    snapshot
                                                                        .data!;
                                                                return Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .min,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(
                                                                          'Digunakan oleh: ${user.name}'),
                                                                      Text(
                                                                          'Divisi: ${user.unit}\nEstimasi : ${dpeminjaman.estimatedTime != null ? DateFormat('d MMMM yyyy', 'id_ID').format(dpeminjaman.estimatedTime!) : 'draft'}')
                                                                    ]);
                                                              } else {
                                                                return const Text(
                                                                    'Data tidak tersedia');
                                                              }
                                                            });
                                                      } else {
                                                        return const Text(
                                                            'Data tidak tersedia');
                                                      }
                                                    });
                                              } else {
                                                return const Text(
                                                    'Data tidak tersedia');
                                              }
                                            }),
                                        actions: [
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                padding: EdgeInsets.zero,
                                                backgroundColor:
                                                    const Color(0xFFFCA311),
                                              ),
                                              onPressed: () {
                                                context.pop();
                                              },
                                              child: Text(
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
                              ),
                          ] else ...[
                            if (item2.status)
                              IconButton(
                                icon: Icon(Icons.info_outline,
                                    color: Color(0xFFFCA311)),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text(
                                          'Asset sedang Digunakan',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600),
                                        ),
                                        content: FutureBuilder(
                                            future: readPeminjamanbyKendaraanId(
                                                item2.id),
                                            builder: (context, snapshot) {
                                              if (snapshot.connectionState ==
                                                  ConnectionState.waiting) {
                                                return const CircularProgressIndicator(); // Show a loading indicator while waiting
                                              } else if (snapshot.hasError) {
                                                return const Text(
                                                    'Data tidak tersedia'); // Show error message if any
                                              } else if (snapshot.hasData) {
                                                final Peminjaman peminjaman =
                                                    snapshot.data!;
                                                return FutureBuilder(
                                                    future: readUserById(
                                                        '${peminjaman.userId}'),
                                                    builder:
                                                        (context, snapshot) {
                                                      if (snapshot
                                                              .connectionState ==
                                                          ConnectionState
                                                              .waiting) {
                                                        return const CircularProgressIndicator(); // Show a loading indicator while waiting
                                                      } else if (snapshot
                                                          .hasError) {
                                                        return const Text(
                                                            'Data tidak tersedia'); // Show error message if any
                                                      } else if (snapshot
                                                          .hasData) {
                                                        final User user =
                                                            snapshot.data!;
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
                                                                return const CircularProgressIndicator(); // Show a loading indicator while waiting
                                                              } else if (snapshot
                                                                  .hasError) {
                                                                return const Text(
                                                                    'Data tidak tersedia'); // Show error message if any
                                                              } else if (snapshot
                                                                  .hasData) {
                                                                final DetailPeminjamans
                                                                    dpeminjaman =
                                                                    snapshot
                                                                        .data!;
                                                                return Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .min,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(
                                                                          'Digunakan oleh: ${user.name}'),
                                                                      Text(
                                                                          'Divisi: ${user.unit}\nEstimasi : ${dpeminjaman.estimatedTime != null ? DateFormat('d MMMM yyyy', 'id_ID').format(dpeminjaman.estimatedTime!) : 'draft'}')
                                                                    ]);
                                                              } else {
                                                                return const Text(
                                                                    'Data tidak tersedia');
                                                              }
                                                            });
                                                      } else {
                                                        return const Text(
                                                            'Data tidak tersedia');
                                                      }
                                                    });
                                              } else {
                                                return const Text(
                                                    'Data tidak tersedia');
                                              }
                                            }),
                                        actions: [
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                padding: EdgeInsets.zero,
                                                backgroundColor:
                                                    const Color(0xFFFCA311),
                                              ),
                                              onPressed: () {
                                                context.pop();
                                              },
                                              child: Text(
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
                              ),
                          ]
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
      ),
    );
  }
}
