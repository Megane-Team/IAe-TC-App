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
import 'package:inventara/actions/ruangan/read_ruangan_action.dart';
import 'package:inventara/actions/tempat/read_tempat_action.dart';
import 'package:inventara/actions/users/read_user_action.dart';
import 'package:inventara/structures/barang.dart';
import 'package:inventara/structures/detailPeminjaman.dart';
import 'package:inventara/structures/kendaraan.dart';
import 'package:inventara/structures/peminjaman.dart';
import 'package:inventara/structures/ruangan.dart';
import 'package:inventara/structures/tempat.dart';
import 'package:inventara/structures/user.dart';
import 'package:inventara/utils/actionwidget.dart';
import 'package:inventara/utils/assets.dart';
import 'package:inventara/structures/ruangan_category.dart';
import 'package:inventara/utils/extension.dart';

class Ruangan extends StatefulWidget {
  final String id;
  final String category;

  const Ruangan({required this.id, required this.category, super.key});

  @override
  State<Ruangan> createState() => RuanganState();
}

class RuanganState extends State<Ruangan> {
  late List<Ruangans> ruangan = [];
  late List<Tempat> tempat = [];
  late List<Kendaraan> kendaraan = [];
  late List<Barang> barang = [];
  late Future<void> fetchDataFuture;
  var category = '';

  bool isRuangan() {
    if (category == 'ruangan') {
      return true;
    } else {
      return false;
    }
  }

  Future<void> fetchData() async {
    category = widget.category;

    if (isRuangan()) {
      ruangan = await readRuanganbyId(widget.id, context);
      final barangs = await readBarangbyRuanganId(widget.id, context);
      setState(() {
        barang = barangs;
      });
      return;
    } else {
      tempat = await readTempat(widget.id, context);
      final kendaraans = await readKendaraanByGedungId(widget.id, context);
      setState(() {
        kendaraan = kendaraans;
      });
      return;
    }
  }

  @override
  void initState() {
    super.initState();
    fetchDataFuture = fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(
          automaticallyImplyLeading: false,
        ),
      ),
      body: FutureBuilder(
          future: fetchDataFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 247,
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50),
                    ),
                  ),
                  child: FutureBuilder<Widget>(
                      future: isRuangan() && ruangan.isNotEmpty
                          ? Assets.ruangan(ruangan[0].photo ?? '')
                          : tempat.isNotEmpty
                              ? Assets.tempat(tempat[0].photo ?? '')
                              : Future.value(Center(
                                  child: Image.asset(Assets.noImage()),
                                )),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator(); // Show a loading indicator while waiting
                        } else if (snapshot.hasError) {
                          return Image.asset(
                              Assets.noImage()); // Show error message if any
                        } else if (snapshot.hasData) {
                          return snapshot
                              .data!; // Return the widget once the future completes
                        } else {
                          return const Text('Data tidak tersedia!');
                        }
                      }),
                ),
                SafeArea(
                  bottom: isRuangan(),
                  child: Column(children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 16, right: 16, top: 8),
                      child: Column(
                        children: [
                          Row(
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
                                    context.pop();
                                  },
                                  icon: const Icon(Icons.navigate_before),
                                ),
                              ),
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
                                    int param1 = isRuangan()
                                        ? ruangan[0].id
                                        : tempat[0].id;
                                    bool param2 = isRuangan();
                                    context.push(
                                        '/cari?id=$param1&isRuangan=$param2');
                                  },
                                  icon: const Icon(Icons.search),
                                ),
                              ),
                            ],
                          ),
                          const Gap(110),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 80,
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
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 12, right: 16),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  isRuangan()
                                      ? Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              ruangan.isNotEmpty
                                                  ? ruangan[0].code
                                                  : tempat.isNotEmpty
                                                      ? tempat[0].name
                                                      : '',
                                              style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            if (ruangan[0].category !=
                                                RuanganCategory.gudang) ...[
                                              ...[
                                                Text(
                                                  ruangan.isEmpty
                                                      ? ''
                                                      : ruangan[0].status ==
                                                              false
                                                          ? 'Tidak Digunakan'
                                                          : 'Digunakan',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                )
                                              ]
                                            ]
                                          ],
                                        )
                                      : Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              tempat.isNotEmpty
                                                  ? tempat[0].name
                                                  : '',
                                              style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                  isRuangan()
                                      ? ruangan.isNotEmpty
                                          ? ruangan[0].category !=
                                                  RuanganCategory.gudang
                                              ? Container(
                                                  width: 46,
                                                  height: 22,
                                                  decoration: BoxDecoration(
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: const Color(
                                                                0xFFFCA311)
                                                            .withOpacity(1),
                                                        spreadRadius: 1,
                                                        blurRadius: 4,
                                                        offset:
                                                            const Offset(0, 0),
                                                      ),
                                                    ],
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      const Icon(
                                                        Icons.person,
                                                        color:
                                                            Color(0xFFFCA311),
                                                        size: 16,
                                                      ),
                                                      Text(
                                                        ruangan.isEmpty
                                                            ? ''
                                                            : ruangan[0]
                                                                .capacity
                                                                .toString(),
                                                        style: const TextStyle(
                                                          fontSize: 12,
                                                          color:
                                                              Color(0xFFFCA311),
                                                        ),
                                                      ),
                                                    ],
                                                  ))
                                              : Container()
                                          : Container()
                                      : Container()
                                ],
                              ),
                            ),
                          ),
                          const Gap(22),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Stack(
                        children: [
                          SingleChildScrollView(
                            child: isRuangan()
                                ? Column(
                                    children: [
                                      barang.isNotEmpty
                                          ? ListView.builder(
                                              shrinkWrap: true,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              itemCount: barang
                                                  .map((item) =>
                                                      item.name.capitalize())
                                                  .toSet()
                                                  .length,
                                              itemBuilder: (context, index) {
                                                final uniqueNames = barang
                                                    .map((item) =>
                                                        item.name.capitalize())
                                                    .toSet()
                                                    .toList()
                                                  ..sort();
                                                return Container(
                                                  margin: const EdgeInsets.only(
                                                      bottom: 24),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 24,
                                                                right: 24),
                                                        child: Text(
                                                          uniqueNames[index],
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                      ),
                                                      const Divider(
                                                        color: Colors.black,
                                                        thickness: 1,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 24,
                                                                right: 24),
                                                        child: ListView.builder(
                                                          physics:
                                                              const NeverScrollableScrollPhysics(),
                                                          shrinkWrap: true,
                                                          itemCount: barang
                                                              .where((item) =>
                                                                  item.name
                                                                      .capitalize() ==
                                                                  uniqueNames[
                                                                      index])
                                                              .length,
                                                          itemBuilder: (context,
                                                              index2) {
                                                            final items = barang
                                                                .where((item) =>
                                                                    item.name
                                                                        .capitalize() ==
                                                                    uniqueNames[
                                                                        index])
                                                                .toList()
                                                              ..sort((a, b) {
                                                                if (a.status ==
                                                                        true &&
                                                                    b.status !=
                                                                        true) {
                                                                  return 1;
                                                                }
                                                                if (a.status !=
                                                                        true &&
                                                                    b.status ==
                                                                        false) {
                                                                  return -1;
                                                                }
                                                                return a.id
                                                                    .compareTo(
                                                                        b.id);
                                                              });
                                                            return Container(
                                                              margin:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      top: 10),
                                                              width:
                                                                  MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width,
                                                              height: 60,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            16),
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                    color: Colors
                                                                        .black
                                                                        .withOpacity(
                                                                            0.1),
                                                                    spreadRadius:
                                                                        1,
                                                                    blurRadius:
                                                                        4,
                                                                    offset:
                                                                        const Offset(
                                                                            0,
                                                                            0),
                                                                  ),
                                                                ],
                                                              ),
                                                              child:
                                                                  ElevatedButton(
                                                                style: ElevatedButton
                                                                    .styleFrom(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .only(
                                                                          left:
                                                                              10,
                                                                          right:
                                                                              10),
                                                                  shape:
                                                                      RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            16),
                                                                  ),
                                                                  elevation: 4,
                                                                  backgroundColor: items[index2]
                                                                              .status ==
                                                                          true
                                                                      ? Colors
                                                                          .black12
                                                                      : Colors
                                                                          .white,
                                                                  shadowColor: Colors
                                                                      .black
                                                                      .withOpacity(
                                                                          0.1),
                                                                ),
                                                                onPressed: () {
                                                                  if (items[index2]
                                                                          .status ==
                                                                      true) {
                                                                    showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (BuildContext
                                                                              context) {
                                                                        return AlertDialog(
                                                                          title:
                                                                              const Text(
                                                                            'Asset sedang Dipinjam',
                                                                            style:
                                                                                TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                                                                          ),
                                                                          content: FutureBuilder(
                                                                              future: readPeminjamanbyBarangId(items[index2].id),
                                                                              builder: (context, snapshot) {
                                                                                if (snapshot.connectionState == ConnectionState.waiting) {
                                                                                  return const CircularProgressIndicator(); // Show a loading indicator while waiting
                                                                                } else if (snapshot.hasError) {
                                                                                  return const Text('Data tidak tersedia'); // Show error message if any
                                                                                } else if (snapshot.hasData) {
                                                                                  final Peminjaman peminjaman = snapshot.data!;
                                                                                  return FutureBuilder(
                                                                                      future: readUserById('${peminjaman.userId}'),
                                                                                      builder: (context, snapshot) {
                                                                                        if (snapshot.connectionState == ConnectionState.waiting) {
                                                                                          return const CircularProgressIndicator(); // Show a loading indicator while waiting
                                                                                        } else if (snapshot.hasError) {
                                                                                          return const Text('Data tidak tersedia'); // Show error message if any
                                                                                        } else if (snapshot.hasData) {
                                                                                          final User user = snapshot.data!;
                                                                                          return FutureBuilder(
                                                                                              future: readDetailPeminjamanbyId(peminjaman.detailPeminjamanId),
                                                                                              builder: (context, snapshot) {
                                                                                                if (snapshot.connectionState == ConnectionState.waiting) {
                                                                                                  return const CircularProgressIndicator(); // Show a loading indicator while waiting
                                                                                                } else if (snapshot.hasError) {
                                                                                                  return const Text('Data tidak tersedia'); // Show error message if any
                                                                                                } else if (snapshot.hasData) {
                                                                                                  final DetailPeminjaman dpeminjaman = snapshot.data!;
                                                                                                  return Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
                                                                                                    Text('Digunakan oleh: ${user.name}'),
                                                                                                    Text('Divisi: ${user.unit}\nEstimasi : ${dpeminjaman.estimatedTime != null ? DateFormat('d MMMM yyyy', 'id_ID').format(dpeminjaman.estimatedTime!) : 'draft'}')
                                                                                                  ]);
                                                                                                } else {
                                                                                                  return const Text('Data tidak tersedia');
                                                                                                }
                                                                                              });
                                                                                        } else {
                                                                                          return const Text('Data tidak tersedia');
                                                                                        }
                                                                                      });
                                                                                } else {
                                                                                  return const Text('Data tidak tersedia');
                                                                                }
                                                                              }),
                                                                          actions: [
                                                                            SizedBox(
                                                                              width: MediaQuery.of(context).size.width,
                                                                              child: ElevatedButton(
                                                                                style: ElevatedButton.styleFrom(
                                                                                  padding: EdgeInsets.zero,
                                                                                  backgroundColor: const Color(0xFFFCA311),
                                                                                ),
                                                                                onPressed: () {
                                                                                  context.pop();
                                                                                },
                                                                                child: const Text(
                                                                                  'OK',
                                                                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        );
                                                                      },
                                                                    );
                                                                  } else {
                                                                    showModalBottomSheet(
                                                                      showDragHandle:
                                                                          true,
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (BuildContext
                                                                              context) {
                                                                        return Padding(
                                                                          padding: const EdgeInsets
                                                                              .only(
                                                                              left: 24,
                                                                              right: 24,
                                                                              bottom: 32),
                                                                          child:
                                                                              SizedBox(
                                                                            width:
                                                                                MediaQuery.of(context).size.width,
                                                                            height:
                                                                                MediaQuery.of(context).size.height / 2.6,
                                                                            child:
                                                                                Column(
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                SizedBox(
                                                                                  width: MediaQuery.of(context).size.width,
                                                                                  height: 218,
                                                                                  child: SizedBox(
                                                                                      width: 60,
                                                                                      height: 46,
                                                                                      child: ClipRRect(
                                                                                        borderRadius: BorderRadius.circular(10),
                                                                                        child: FutureBuilder<Widget>(
                                                                                            future: Assets.barang(barang[index2].photo ?? ''),
                                                                                            builder: (context, snapshot) {
                                                                                              if (snapshot.connectionState == ConnectionState.waiting) {
                                                                                                return const CircularProgressIndicator(); // Show a loading indicator while waiting
                                                                                              } else if (snapshot.hasError) {
                                                                                                return Image.asset(Assets.noImage()); // Show error message if any
                                                                                              } else if (snapshot.hasData) {
                                                                                                return snapshot.data!; // Return the widget once the future completes
                                                                                              } else {
                                                                                                return const Text('No data available'); // Show message if no data
                                                                                              }
                                                                                            }),
                                                                                      )),
                                                                                ),
                                                                                Row(
                                                                                  children: [
                                                                                    Text(
                                                                                      items[index2].name,
                                                                                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                                                                                    ),
                                                                                    Text(
                                                                                      ' ${items[index2].code}',
                                                                                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                                Text('Kondisi ${items[index2].condition}'),
                                                                                Expanded(
                                                                                  child: Align(
                                                                                    alignment: Alignment.bottomCenter,
                                                                                    child: Row(
                                                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                      children: [
                                                                                        SizedBox(
                                                                                          width: MediaQuery.of(context).size.width / 2.3,
                                                                                          child: ElevatedButton(
                                                                                            onPressed: () async {
                                                                                              DetailPeminjaman dp = await createDetailPeminjaman(status: 'draft');

                                                                                              var res = await createPeminjaman(dp.id, items[0].id, null, null, 'barang');

                                                                                              if (res) {
                                                                                                WidgetsBinding.instance.addPostFrameCallback((_) {
                                                                                                  if (context.mounted) {
                                                                                                    context.pop();
                                                                                                  }
                                                                                                });
                                                                                                ScaffoldMessenger.of(context).showSnackBar(
                                                                                                  const SnackBar(
                                                                                                    content: Text('Barang Disimpan di Keranjang'),
                                                                                                  ),
                                                                                                );
                                                                                              } else {
                                                                                                WidgetsBinding.instance.addPostFrameCallback((_) {
                                                                                                  if (context.mounted) {
                                                                                                    context.pop();
                                                                                                  }
                                                                                                });
                                                                                                ScaffoldMessenger.of(context).showSnackBar(
                                                                                                  const SnackBar(
                                                                                                    content: Text('Barang sudah berada di keranjang!'),
                                                                                                  ),
                                                                                                );
                                                                                              }
                                                                                            },
                                                                                            style: ElevatedButton.styleFrom(
                                                                                              padding: EdgeInsets.zero,
                                                                                              side: const BorderSide(color: Color(0xFFFCA311)),
                                                                                            ),
                                                                                            child: const Text(
                                                                                              'Masukan keranjang',
                                                                                              style: TextStyle(color: Color(0xFFFCA311), fontWeight: FontWeight.w600),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        SizedBox(
                                                                                          width: MediaQuery.of(context).size.width / 3,
                                                                                          child: ElevatedButton(
                                                                                            onPressed: () {
                                                                                              var param = items[index2].id;
                                                                                              context.push('/KonfA?id=$param&category=barang');
                                                                                            },
                                                                                            style: ElevatedButton.styleFrom(
                                                                                              padding: EdgeInsets.zero,
                                                                                              backgroundColor: const Color(0xFFFCA311),
                                                                                            ),
                                                                                            child: const Text(
                                                                                              'Pinjam Barang',
                                                                                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        );
                                                                      },
                                                                    );
                                                                  }
                                                                },
                                                                child: Row(
                                                                  children: [
                                                                    SizedBox(
                                                                        width:
                                                                            60,
                                                                        height:
                                                                            46,
                                                                        child:
                                                                            ClipRRect(
                                                                          borderRadius:
                                                                              BorderRadius.circular(10),
                                                                          child: FutureBuilder<Widget>(
                                                                              future: Assets.barang(barang[index2].photo ?? ''),
                                                                              builder: (context, snapshot) {
                                                                                if (snapshot.connectionState == ConnectionState.waiting) {
                                                                                  return const CircularProgressIndicator(); // Show a loading indicator while waiting
                                                                                } else if (snapshot.hasError) {
                                                                                  return Image.asset(Assets.noImage()); // Show error message if any
                                                                                } else if (snapshot.hasData) {
                                                                                  return snapshot.data!; // Return the widget once the future completes
                                                                                } else {
                                                                                  return const Text('No data available'); // Show message if no data
                                                                                }
                                                                              }),
                                                                        )),
                                                                    const Gap(
                                                                        4),
                                                                    Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Row(
                                                                          children: [
                                                                            Text(
                                                                              items[index2].name,
                                                                              style: const TextStyle(color: Colors.black),
                                                                            ),
                                                                            Text(
                                                                              ' ${items[index2].code}',
                                                                              style: const TextStyle(color: Colors.black),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        Text(
                                                                          items[index2]
                                                                              .condition,
                                                                          style:
                                                                              const TextStyle(color: Colors.black),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                            )
                                          : Text('Tidak ada data!')
                                    ],
                                  )
                                : Column(children: [
                                    kendaraan.isNotEmpty
                                        ? ListView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemCount: kendaraan
                                                .map((item) => item.category
                                                    .toString()
                                                    .split('.')
                                                    .last
                                                    .capitalize())
                                                .toSet()
                                                .length,
                                            itemBuilder: (context, index) {
                                              final uniqueNames = kendaraan
                                                  .map((item) => item.category
                                                      .toString()
                                                      .split('.')
                                                      .last
                                                      .capitalize())
                                                  .toSet()
                                                  .toList()
                                                ..sort();
                                              return Container(
                                                margin: const EdgeInsets.only(
                                                    bottom: 24),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 24,
                                                              right: 24),
                                                      child: Text(
                                                        uniqueNames[index],
                                                        style: const TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    ),
                                                    const Divider(
                                                      color: Colors.black,
                                                      thickness: 1,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 24,
                                                              right: 24),
                                                      child: ListView.builder(
                                                        physics:
                                                            const NeverScrollableScrollPhysics(),
                                                        shrinkWrap: true,
                                                        itemCount: kendaraan
                                                            .where((item) =>
                                                                item.category
                                                                    .toString()
                                                                    .split('.')
                                                                    .last
                                                                    .capitalize() ==
                                                                uniqueNames[
                                                                    index])
                                                            .length,
                                                        itemBuilder:
                                                            (context, index2) {
                                                          final items = kendaraan
                                                              .where((item) =>
                                                                  item.category
                                                                      .toString()
                                                                      .split(
                                                                          '.')
                                                                      .last
                                                                      .capitalize() ==
                                                                  uniqueNames[
                                                                      index])
                                                              .toList()
                                                            ..sort((a, b) {
                                                              if (a.status ==
                                                                      true &&
                                                                  b.status !=
                                                                      true) {
                                                                return 1;
                                                              }
                                                              if (a.status !=
                                                                      true &&
                                                                  b.status ==
                                                                      true) {
                                                                return -1;
                                                              }
                                                              return a.id
                                                                  .compareTo(
                                                                      b.id);
                                                            });
                                                          return Container(
                                                            margin:
                                                                const EdgeInsets
                                                                    .only(
                                                                    top: 10),
                                                            width:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                            height: 60,
                                                            decoration:
                                                                BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          16),
                                                              boxShadow: [
                                                                BoxShadow(
                                                                  color: Colors
                                                                      .black
                                                                      .withOpacity(
                                                                          0.1),
                                                                  spreadRadius:
                                                                      1,
                                                                  blurRadius: 4,
                                                                  offset:
                                                                      const Offset(
                                                                          0, 0),
                                                                ),
                                                              ],
                                                            ),
                                                            child:
                                                                ElevatedButton(
                                                              style:
                                                                  ElevatedButton
                                                                      .styleFrom(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        left:
                                                                            10,
                                                                        right:
                                                                            10),
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              16),
                                                                ),
                                                                elevation: 4,
                                                                backgroundColor:
                                                                    items[index2].status ==
                                                                            true
                                                                        ? Colors
                                                                            .black12
                                                                        : Colors
                                                                            .white,
                                                                shadowColor: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                        0.1),
                                                              ),
                                                              onPressed: () {
                                                                if (items[index2]
                                                                        .status ==
                                                                    true) {
                                                                  showDialog(
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (BuildContext
                                                                            context) {
                                                                      return AlertDialog(
                                                                        title:
                                                                            const Text(
                                                                          'Asset sedang Digunakan',
                                                                          style:
                                                                              TextStyle(fontWeight: FontWeight.w600),
                                                                        ),
                                                                        content: FutureBuilder(
                                                                            future: readPeminjamanbyKendaraanId(items[index2].id),
                                                                            builder: (context, snapshot) {
                                                                              if (snapshot.connectionState == ConnectionState.waiting) {
                                                                                return const CircularProgressIndicator(); // Show a loading indicator while waiting
                                                                              } else if (snapshot.hasError) {
                                                                                return const Text('Data tidak tersedia'); // Show error message if any
                                                                              } else if (snapshot.hasData) {
                                                                                final Peminjaman peminjaman = snapshot.data!;
                                                                                return FutureBuilder(
                                                                                    future: readUserById('${peminjaman.userId}'),
                                                                                    builder: (context, snapshot) {
                                                                                      if (snapshot.connectionState == ConnectionState.waiting) {
                                                                                        return const CircularProgressIndicator(); // Show a loading indicator while waiting
                                                                                      } else if (snapshot.hasError) {
                                                                                        return const Text('Data tidak tersedia'); // Show error message if any
                                                                                      } else if (snapshot.hasData) {
                                                                                        final User user = snapshot.data!;
                                                                                        return FutureBuilder(
                                                                                            future: readDetailPeminjamanbyId(peminjaman.detailPeminjamanId),
                                                                                            builder: (context, snapshot) {
                                                                                              if (snapshot.connectionState == ConnectionState.waiting) {
                                                                                                return const CircularProgressIndicator(); // Show a loading indicator while waiting
                                                                                              } else if (snapshot.hasError) {
                                                                                                return const Text('Data tidak tersedia'); // Show error message if any
                                                                                              } else if (snapshot.hasData) {
                                                                                                final DetailPeminjaman dpeminjaman = snapshot.data!;
                                                                                                return Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
                                                                                                  Text('Digunakan oleh: ${user.name}'),
                                                                                                  Text('Divisi: ${user.unit}\nEstimasi : ${dpeminjaman.estimatedTime != null ? DateFormat('d MMMM yyyy', 'id_ID').format(dpeminjaman.estimatedTime!) : 'draft'}')
                                                                                                ]);
                                                                                              } else {
                                                                                                return const Text('Data tidak tersedia');
                                                                                              }
                                                                                            });
                                                                                      } else {
                                                                                        return const Text('Data tidak tersedia');
                                                                                      }
                                                                                    });
                                                                              } else {
                                                                                return const Text('Data tidak tersedia');
                                                                              }
                                                                            }),
                                                                        actions: [
                                                                          SizedBox(
                                                                            width:
                                                                                MediaQuery.of(context).size.width,
                                                                            child:
                                                                                ElevatedButton(
                                                                              style: ElevatedButton.styleFrom(
                                                                                padding: EdgeInsets.zero,
                                                                                backgroundColor: const Color(0xFFFCA311),
                                                                              ),
                                                                              onPressed: () {
                                                                                Navigator.of(context).pop();
                                                                              },
                                                                              child: const Text(
                                                                                'OK',
                                                                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      );
                                                                    },
                                                                  );
                                                                } else {
                                                                  showModalBottomSheet(
                                                                    showDragHandle:
                                                                        true,
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (BuildContext
                                                                            context) {
                                                                      return Padding(
                                                                        padding: const EdgeInsets
                                                                            .only(
                                                                            left:
                                                                                24,
                                                                            right:
                                                                                24,
                                                                            bottom:
                                                                                32),
                                                                        child:
                                                                            SizedBox(
                                                                          width: MediaQuery.of(context)
                                                                              .size
                                                                              .width,
                                                                          height:
                                                                              MediaQuery.of(context).size.height / 2.6,
                                                                          child:
                                                                              Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              SizedBox(
                                                                                width: MediaQuery.of(context).size.width,
                                                                                height: 218,
                                                                                child: SizedBox(
                                                                                    width: 60,
                                                                                    height: 46,
                                                                                    child: ClipRRect(
                                                                                      borderRadius: BorderRadius.circular(10),
                                                                                      child: FutureBuilder<Widget>(
                                                                                          future: Assets.kendaraan(kendaraan[index2].photo ?? ''),
                                                                                          builder: (context, snapshot) {
                                                                                            if (snapshot.connectionState == ConnectionState.waiting) {
                                                                                              return const CircularProgressIndicator(); // Show a loading indicator while waiting
                                                                                            } else if (snapshot.hasError) {
                                                                                              return Image.asset(Assets.noImage()); // Show error message if any
                                                                                            } else if (snapshot.hasData) {
                                                                                              return snapshot.data!; // Return the widget once the future completes
                                                                                            } else {
                                                                                              return const Text('No data available'); // Show message if no data
                                                                                            }
                                                                                          }),
                                                                                    )),
                                                                              ),
                                                                              Row(
                                                                                children: [
                                                                                  Text(
                                                                                    items[index2].name,
                                                                                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                                                                                  ),
                                                                                  Text(
                                                                                    ' ${items[index2].name}',
                                                                                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              Text('Kondisi ${items[index2].condition}'),
                                                                              Expanded(
                                                                                child: Align(
                                                                                  alignment: Alignment.bottomCenter,
                                                                                  child: Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                    children: [
                                                                                      SizedBox(
                                                                                        width: MediaQuery.of(context).size.width / 2.3,
                                                                                        child: ElevatedButton(
                                                                                          onPressed: () async {
                                                                                            DetailPeminjaman dp = await createDetailPeminjaman(status: 'draft');

                                                                                            var res = await createPeminjaman(dp.id, null, null, items[0].id, 'kendaraan');

                                                                                            if (res) {
                                                                                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                                                                                if (context.mounted) {
                                                                                                  context.pop();
                                                                                                }
                                                                                              });
                                                                                              ScaffoldMessenger.of(context).showSnackBar(
                                                                                                const SnackBar(
                                                                                                  content: Text('Kendaraan Disimpan di Keranjang'),
                                                                                                ),
                                                                                              );
                                                                                            } else {
                                                                                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                                                                                if (context.mounted) {
                                                                                                  context.pop();
                                                                                                }
                                                                                              });
                                                                                              ScaffoldMessenger.of(context).showSnackBar(
                                                                                                const SnackBar(
                                                                                                  content: Text('Kendaraan sudah berada di keranjang!'),
                                                                                                ),
                                                                                              );
                                                                                            }
                                                                                          },
                                                                                          style: ElevatedButton.styleFrom(
                                                                                            padding: EdgeInsets.zero,
                                                                                            side: const BorderSide(color: Color(0xFFFCA311)),
                                                                                          ),
                                                                                          child: const Text(
                                                                                            'Masukan Keranjang',
                                                                                            style: TextStyle(color: Color(0xFFFCA311), fontWeight: FontWeight.w600),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                      SizedBox(
                                                                                        width: MediaQuery.of(context).size.width / 2.3,
                                                                                        child: ElevatedButton(
                                                                                          onPressed: () {
                                                                                            var param = items[index2].id;
                                                                                            context.push('/KonfK?id=$param&category=kendaraan');
                                                                                          },
                                                                                          style: ElevatedButton.styleFrom(
                                                                                            padding: EdgeInsets.zero,
                                                                                            backgroundColor: const Color(0xFFFCA311),
                                                                                          ),
                                                                                          child: const Text(
                                                                                            'Pinjam Barang',
                                                                                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      );
                                                                    },
                                                                  );
                                                                }
                                                              },
                                                              child: Row(
                                                                children: [
                                                                  SizedBox(
                                                                      width: 60,
                                                                      height:
                                                                          46,
                                                                      child:
                                                                          ClipRRect(
                                                                        borderRadius:
                                                                            BorderRadius.circular(10),
                                                                        child: FutureBuilder<
                                                                                Widget>(
                                                                            future: Assets.kendaraan(kendaraan[index2].photo ??
                                                                                ''),
                                                                            builder:
                                                                                (context, snapshot) {
                                                                              if (snapshot.connectionState == ConnectionState.waiting) {
                                                                                return const CircularProgressIndicator(); // Show a loading indicator while waiting
                                                                              } else if (snapshot.hasError) {
                                                                                return Image.asset(Assets.noImage()); // Show error message if any
                                                                              } else if (snapshot.hasData) {
                                                                                return snapshot.data!; // Return the widget once the future completes
                                                                              } else {
                                                                                return const Text('No data available'); // Show message if no data
                                                                              }
                                                                            }),
                                                                      )),
                                                                  const Gap(4),
                                                                  Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Row(
                                                                        children: [
                                                                          Text(
                                                                            items[index2].name,
                                                                            style:
                                                                                const TextStyle(color: Colors.black),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Text(
                                                                        items[index2]
                                                                            .condition,
                                                                        style: const TextStyle(
                                                                            color:
                                                                                Colors.black),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          )
                                        : noData()
                                  ]),
                          )
                        ],
                      ),
                    ),
                    isRuangan()
                        ? Container(
                            padding: const EdgeInsets.only(right: 24, left: 24),
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
                                        var param = ruangan[0].id;

                                        context.push(
                                            "/konfA?id=$param&category=ruangan");
                                      },
                                      child: const Text(
                                        "Pinjam Ruangan",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600),
                                      )),
                                )
                              ],
                            ),
                          )
                        : const SizedBox()
                  ]),
                ),
              ],
            );
          }),
    );
  }
}
