import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:inventara/actions/barang/read_barang_action.dart';
import 'package:inventara/actions/ruangan/read_ruangan_action.dart';
import 'package:inventara/actions/tempat/read_tempat_action.dart';
import 'package:inventara/structures/barang.dart';
import 'package:inventara/structures/kendaraan.dart';
import 'package:inventara/structures/ruangan.dart';
import 'package:inventara/structures/tempat.dart';
import 'package:inventara/utils/assets.dart';

class Ruangan extends StatefulWidget {
  final String id;
  final String category;

  const Ruangan({required this.id, required this.category, super.key});

  @override
  State<Ruangan> createState() => RuanganState();
}

class RuanganState extends State<Ruangan> {
  late List<Barang> list = [];
  late List<Barang> originalList = [];
  late List<Ruangans> ruangan = [];
  late List<Tempat> tempat = [];
  late List<Kendaraan> kendaraan = [];
  var category = '';

  bool isRuangan() {
    if (category == 'ruangan') {
      return true;
    } else {
      return false;
    }
  }

  void fetchData() async {
    category = widget.category;

    if (isRuangan()) {
      ruangan = await readRuanganbyId(widget.id);
      final barangs = await readBarang(widget.id);
      setState(() {
        list = barangs;
        originalList = barangs;
      });
      return;
    } else {
      tempat = await readTempatbyId(widget.id);
      final kendaraans = await readBarang(widget.id);
      setState(() {
        list = kendaraans;
        originalList = kendaraans;
      });
      return;
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
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
      body: Stack(
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
                    ? Assets.ruangan(ruangan[0].photo)
                    : tempat.isNotEmpty
                    ? Assets.kendaraan(tempat[0].photo)
                    : Future.value(const Text('No data available')),
                builder: (context, snapshot) {
                  if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const CircularProgressIndicator(); // Show a loading indicator while waiting
                  } else if (snapshot.hasError) {
                    return Image.asset(Assets.icons(
                        'no_image')); // Show error message if any
                  } else if (snapshot.hasData) {
                    return snapshot
                        .data!; // Return the widget once the future completes
                  } else {
                    return const Text(
                        'No data available'); // Show message if no data
                  }
                }),
          ),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
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
                                // TODO: Create a search function

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
                          padding: const EdgeInsets.only(left: 12, right: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              isRuangan()
                                ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                    Text(
                                      ruangan.isEmpty ? '' : ruangan[0].status,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                )
                                : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                    ),
                                  ],
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.person,
                                      color: Color(0xFFFCA311),
                                      size: 16,
                                    ),
                                    Text(
                                      ruangan.isEmpty ? '' : ruangan[0].capacity.toString(),
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Color(0xFFFCA311),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                              : Container(),
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
                        child: Column(
                          children: [
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: Kelas_1.map((item) => item['name'])
                                  .toSet()
                                  .length,
                              itemBuilder: (context, index) {
                                final uniqueNames =
                                    Kelas_1.map((item) => item['name'])
                                        .toSet()
                                        .toList()
                                      ..sort();
                                return Container(
                                  margin: const EdgeInsets.only(bottom: 24),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 24, right: 24),
                                        child: Text(
                                          uniqueNames[index]!,
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      const Divider(
                                        color: Colors.black,
                                        thickness: 1,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 24, right: 24),
                                        child: ListView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: Kelas_1.where((item) =>
                                              item['name'] ==
                                              uniqueNames[index]).length,
                                          itemBuilder: (context, index2) {
                                            final items = Kelas_1.where(
                                                (item) =>
                                                    item['name'] ==
                                                    uniqueNames[index]).toList()
                                              ..sort((a, b) {
                                                if (a['status'] ==
                                                        'Digunakan' &&
                                                    b['status'] !=
                                                        'Digunakan') {
                                                  return 1;
                                                }
                                                if (a['status'] !=
                                                        'Digunakan' &&
                                                    b['status'] ==
                                                        'Digunakan') {
                                                  return -1;
                                                }
                                                return int.parse(
                                                        a['kode_barang']!)
                                                    .compareTo(int.parse(
                                                        b['kode_barang']!));
                                              });
                                            return Container(
                                              margin: const EdgeInsets.only(
                                                  top: 10),
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: 60,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(0.1),
                                                    spreadRadius: 1,
                                                    blurRadius: 4,
                                                    offset: const Offset(0, 0),
                                                  ),
                                                ],
                                              ),
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10, right: 10),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16),
                                                  ),
                                                  elevation: 4,
                                                  backgroundColor: items[index2]
                                                              ['status'] ==
                                                          'Digunakan'
                                                      ? Colors.black12
                                                      : Colors.white,
                                                  shadowColor: Colors.black
                                                      .withOpacity(0.1),
                                                ),
                                                onPressed: () {
                                                  if (items[index2]['status'] ==
                                                      'Digunakan') {
                                                    showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return AlertDialog(
                                                          title: const Text(
                                                            'Asset sedang Digunakan',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                          content: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: Peminjaman
                                                                .map((item) =>
                                                                    Text(
                                                                      'Name: ${item['name']}\nDivisi: ${item['Divisi']}\nEstimasi Peminjaman: ${item['estimasi peminjaman']}',
                                                                      style: const TextStyle(
                                                                          height:
                                                                              2),
                                                                    )).toList(),
                                                          ),
                                                          actions: [
                                                            SizedBox(
                                                              width:
                                                                  MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width,
                                                              child:
                                                                  ElevatedButton(
                                                                style: ElevatedButton
                                                                    .styleFrom(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .zero,
                                                                  backgroundColor:
                                                                      const Color(
                                                                          0xFFFCA311),
                                                                ),
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                },
                                                                child:
                                                                    const Text(
                                                                  'OK',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    );
                                                  } else {
                                                    showModalBottomSheet(
                                                      showDragHandle: true,
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 24,
                                                                  right: 24,
                                                                  bottom: 32),
                                                          child: SizedBox(
                                                            width:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height /
                                                                2.6,
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Container(
                                                                  width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width,
                                                                  height: 218,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Colors
                                                                        .black,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                  ),
                                                                  child: Image
                                                                      .asset(
                                                                    items[index2]
                                                                        [
                                                                        'photo']!,
                                                                    width: 50,
                                                                    height: 50,
                                                                  ),
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    Text(
                                                                      items[index2]
                                                                          [
                                                                          'name']!,
                                                                      style: const TextStyle(
                                                                          fontSize:
                                                                              20,
                                                                          fontWeight:
                                                                              FontWeight.w600),
                                                                    ),
                                                                    Text(
                                                                      ' ${items[index2]['kode_barang']!}',
                                                                      style: const TextStyle(
                                                                          fontSize:
                                                                              20,
                                                                          fontWeight:
                                                                              FontWeight.w600),
                                                                    ),
                                                                  ],
                                                                ),
                                                                Text(
                                                                    'Kondisi ${items[index2]['kondisi']!}'),
                                                                Expanded(
                                                                  child: Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .bottomCenter,
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        SizedBox(
                                                                          width:
                                                                              MediaQuery.of(context).size.width / 2.3,
                                                                          child:
                                                                              ElevatedButton(
                                                                            onPressed:
                                                                                () {
                                                                              Navigator.pop(context);
                                                                              ScaffoldMessenger.of(context).showSnackBar(
                                                                                const SnackBar(
                                                                                  content: Text('Barang Disimpan di Keranjang'),
                                                                                ),
                                                                              );
                                                                            },
                                                                            style:
                                                                                ElevatedButton.styleFrom(
                                                                              padding: EdgeInsets.zero,
                                                                              side: const BorderSide(color: Color(0xFFFCA311)),
                                                                            ),
                                                                            child:
                                                                                const Text(
                                                                              'Masukan Keranjang',
                                                                              style: TextStyle(color: Color(0xFFFCA311), fontWeight: FontWeight.w600),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              MediaQuery.of(context).size.width / 2.3,
                                                                          child:
                                                                              ElevatedButton(
                                                                            onPressed:
                                                                                () {
                                                                              Navigator.pop(context);
                                                                            },
                                                                            style:
                                                                                ElevatedButton.styleFrom(
                                                                              padding: EdgeInsets.zero,
                                                                              backgroundColor: const Color(0xFFFCA311),
                                                                            ),
                                                                            child:
                                                                                const Text(
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
                                                    Container(
                                                      width: 60,
                                                      height: 46,
                                                      decoration: BoxDecoration(
                                                        color: Colors.black,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      child: Image.asset(
                                                        items[index2]['photo']!,
                                                        width: 50,
                                                        height: 50,
                                                      ),
                                                    ),
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
                                                              items[index2]
                                                                  ['name']!,
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .black),
                                                            ),
                                                            Text(
                                                              ' ${items[index2]['kode_barang']!}',
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .black),
                                                            ),
                                                          ],
                                                        ),
                                                        Text(
                                                          items[index2]
                                                              ['kondisi']!,
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .black),
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
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
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
                              // Add your onPressed code here!
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
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Map<String, String>> Peminjaman = [
    {
      'name': 'User 1',
      'Divisi': 'HC3000',
      'estimasi peminjaman': '31-11-2024',
    },
  ];

  List<Map<String, String>> Kelas_1 = [
    {
      'name': 'Kursi',
      'kode_barang': '1',
      'photo': 'assets/images/logos/inventara.png',
      'kondisi': 'Bagus',
      'status': 'Tidak Digunakan',
    },
    {
      'name': 'Kursi',
      'kode_barang': '2',
      'photo': 'assets/images/logos/inventara.png',
      'kondisi': 'Bagus',
      'status': 'Digunakan',
    },
    {
      'name': 'Meja',
      'kode_barang': '3',
      'photo': 'assets/images/logos/inventara.png',
      'kondisi': 'Kurang Baik',
      'status': 'Digunakan',
    },
    {
      'name': 'Meja',
      'kode_barang': '4',
      'photo': 'assets/images/logos/inventara.png',
      'kondisi': 'Bagus',
      'status': 'Tidak Digunakan',
    },
    {
      'name': 'Kursi',
      'kode_barang': '1',
      'photo': 'assets/images/logos/inventara.png',
      'kondisi': 'Bagus',
      'status': 'Tidak Digunakan',
    },
    {
      'name': 'Kursi',
      'kode_barang': '2',
      'photo': 'assets/images/logos/inventara.png',
      'kondisi': 'Bagus',
      'status': 'Digunakan',
    },
    {
      'name': 'Meja',
      'kode_barang': '3',
      'photo': 'assets/images/logos/inventara.png',
      'kondisi': 'Kurang Baik',
      'status': 'Digunakan',
    },
    {
      'name': 'Meja',
      'kode_barang': '4',
      'photo': 'assets/images/logos/inventara.png',
      'kondisi': 'Bagus',
      'status': 'Tidak Digunakan',
    },
    {
      'name': 'Meja',
      'kode_barang': '3',
      'photo': 'assets/images/logos/inventara.png',
      'kondisi': 'Kurang Baik',
      'status': 'Digunakan',
    },
    {
      'name': 'Meja',
      'kode_barang': '4',
      'photo': 'assets/images/logos/inventara.png',
      'kondisi': 'Bagus',
      'status': 'Tidak Digunakan',
    },
  ];

  List<Map<String, String>> Gedung_1 = [
    {
      'name': 'Kelas 1',
      'kategori': 'Kelas',
      'photo': 'assets/images/logos/inventara.png',
      'status': 'Tidak Digunakan',
      'kapasitas': '20',
    },
    {
      'name': 'Gudang 1',
      'kategori': 'Gudang',
      'photo': 'assets/images/logos/inventara.png',
      'status': '',
      'kapasitas': '',
    },
  ];
}
