import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:inventara/actions/ruangan/read_ruangan_action.dart';
import 'package:inventara/structures/ruangan.dart';
import 'package:inventara/utils/assets.dart';

class Gedung extends StatefulWidget {
  final String id;
  final String name;
  const Gedung({required this.name, required this.id, super.key});

  @override
  State<Gedung> createState() => GedungState();
}

class GedungState extends State<Gedung> {
  bool isKelasActive = false;
  bool isGudangActive = false;
  bool isLabActive = false;
  late List<Ruangan> ruanganList = [];
  late List<Ruangan> originalRuanganList = [];

  void fetchData() async {
    var ruangan = await readRuangan(widget.id);
    setState(() {
      originalRuanganList = ruangan;
      ruanganList = List.from(originalRuanganList);
      listSort(ruanganList);
    });
  }

  void listSort(List<Ruangan> list) {
    if (isKelasActive) {
      ruanganList.sort(
          (a, b) => a.category.toString().compareTo(b.category.toString()));
    } else if (isLabActive) {
      ruanganList.sort(
          (a, b) => a.category.toString().compareTo(b.category.toString()));
    } else if (isGudangActive) {
      ruanganList.sort(
          (a, b) => a.category.toString().compareTo(b.category.toString()));
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
                onPressed: () {
                  context.go('/beranda');
                },
                icon: const Icon(Icons.navigate_before),
              ),
            ),
            Text(
              widget.name,
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
                setState(() {
                  if (value.isEmpty) {
                    ruanganList = List.from(originalRuanganList);
                  } else {
                    ruanganList = originalRuanganList
                        .where((element) => element.code
                            .toLowerCase()
                            .contains(value.toLowerCase()))
                        .toList();
                  }
                });
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
                      fetchData();
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
                      fetchData();
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
                      fetchData();
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
            child: FutureBuilder<List<Ruangan>>(
              future: readRuangan(widget.id),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  // send error message to terminal
                  return const Center(
                    child: Text(
                        'Error: No data available. Is internet connection available?'),
                  );
                } else if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: ruanganList.length,
                    itemBuilder: (context, index) {
                      var ruangan = ruanganList[index];
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
                            } else {}
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                child: Row(
                                  children: [
                                    Container(
                                      width: 60,
                                      height: 46,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: FutureBuilder<Widget>(
                                          future: Assets.ruangan(ruangan.photo),
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
                              Container(
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
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
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
