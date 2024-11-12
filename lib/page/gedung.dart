import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:inventara/page/beranda.dart';

class Gedung extends StatefulWidget {
  final String? id;
  const Gedung({required this.id, super.key});

  @override
  State<Gedung> createState() => GedungState();
}

class GedungState extends State<Gedung> {
  bool isKelasActive = false;
  bool isGudangActive = false;
  bool isLabActive = false;
  TextEditingController searchController = TextEditingController();
  List<Map<String, String>> filteredGedung = [];

  List<Map<String, String>> originalGedung_1 = [];

  @override
  void initState() {
    super.initState();
    originalGedung_1 = List.from(Gedung_1);
    filteredGedung = List.from(Gedung_1);
    searchController.addListener(_filterGedungList);
  }

  void updateGedungList() {
    if (!isKelasActive && !isLabActive && !isGudangActive) {
      filteredGedung = List.from(originalGedung_1);
    } else {
      filteredGedung = [];
      if (isKelasActive) {
        filteredGedung.addAll(
            originalGedung_1.where((item) => item['kategori'] == 'Kelas'));
      }
      if (isLabActive) {
        filteredGedung.addAll(
            originalGedung_1.where((item) => item['kategori'] == 'Lab'));
      }
      if (isGudangActive) {
        filteredGedung.addAll(
            originalGedung_1.where((item) => item['kategori'] == 'Gudang'));
      }
    }
    _filterGedungList();
  }

  void _filterGedungList() {
    String query = searchController.text.toLowerCase();

    setState(() {
      if (query.isEmpty) {
        filteredGedung = List.from(originalGedung_1);
        if (isKelasActive || isLabActive || isGudangActive) {
          filteredGedung = [];
          if (isKelasActive) {
            filteredGedung.addAll(
                originalGedung_1.where((item) => item['kategori'] == 'Kelas'));
          }
          if (isLabActive) {
            filteredGedung.addAll(
                originalGedung_1.where((item) => item['kategori'] == 'Lab'));
          }
          if (isGudangActive) {
            filteredGedung.addAll(
                originalGedung_1.where((item) => item['kategori'] == 'Gudang'));
          }
        }
      } else {
        filteredGedung = filteredGedung
            .where((item) => item['name']!.toLowerCase().contains(query))
            .toList();
      }
    });
  }

  @override
  void dispose() {
    searchController.removeListener(_filterGedungList);
    super.dispose();
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Beranda()),
                  );
                },
                icon: const Icon(Icons.navigate_before),
              ),
            ),
            Text(
              Tempat[0]['name'] ?? 'Gedung',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
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
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
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
                      updateGedungList();
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
                      updateGedungList();
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
                      updateGedungList();
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
            child: ListView.builder(
              itemCount: filteredGedung.length,
              itemBuilder: (context, index) {
                filteredGedung.sort((a, b) {
                  if (a['status'] == 'Digunakan' &&
                      b['status'] != 'Digunakan') {
                    return 1;
                  } else if (a['status'] != 'Digunakan' &&
                      b['status'] == 'Digunakan') {
                    return -1;
                  } else {
                    return (a['name'] ?? '').compareTo(b['name'] ?? '');
                  }
                });
                var gudang = filteredGedung[index];
                return Container(
                  height: 61,
                  margin: const EdgeInsets.only(left: 24, right: 24, bottom: 8),
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
                      backgroundColor: gudang['status'] == 'Digunakan'
                          ? Colors.grey
                          : Colors.white,
                    ),
                    onPressed: () {
                      if (gudang['status'] == 'Digunakan') {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Ruangan Sedang Digunakan'),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: Peminjaman.map((peminjaman) {
                                  return ListTile(
                                    title: Text(peminjaman['name']!),
                                    subtitle: Text(
                                        'Divisi: ${peminjaman['Divisi']!}\nEstimasi Peminjaman: ${peminjaman['estimasi peminjaman']!}'),
                                  );
                                }).toList(),
                              ),
                              actions: [
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                      backgroundColor: const Color(0xFFFCA311),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
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
                                    color: Colors.black),
                                child: Image.asset(gudang['photo'] ?? '',
                                    height: 50, width: 50),
                              ),
                              const Gap(16),
                              Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      gudang['name'] ?? '',
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black),
                                    ),
                                  ])
                            ],
                          ),
                        ),
                        gudang['kapasitas'] != null &&
                                gudang['kapasitas']!.isNotEmpty
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
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.person,
                                      color: Color(0xFFFCA311),
                                      size: 16,
                                    ),
                                    Text(
                                      gudang['kapasitas'] ?? '',
                                      style: const TextStyle(
                                          fontSize: 12,
                                          color: Color(0xFFFCA311)),
                                    ),
                                  ],
                                ),
                              )
                            : const SizedBox.shrink(),
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
  }

  List<Map<String, String>> Tempat = [
    {
      'name': 'Gedung 1',
      'kategori': 'Gedung',
      'photo': 'assets/images/logos/inventara.png',
    },
  ];

  List<Map<String, String>> Peminjaman = [
    {
      'name': 'User 1',
      'Divisi': 'HC3000',
      'estimasi peminjaman': '31-11-2024',
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
      'name': 'Kelas 2',
      'kategori': 'Kelas',
      'photo': 'assets/images/logos/inventara.png',
      'status': 'Tidak Digunakan',
      'kapasitas': '20',
    },
    {
      'name': 'Kelas 3',
      'kategori': 'Kelas',
      'photo': 'assets/images/logos/inventara.png',
      'status': 'Digunakan',
      'kapasitas': '20',
    },
    {
      'name': 'Gudang 1',
      'kategori': 'Gudang',
      'photo': 'assets/images/logos/inventara.png',
      'status': '',
      'kapasitas': '',
    },
    {
      'name': 'Gudang 2',
      'kategori': 'Gudang',
      'photo': 'assets/images/logos/inventara.png',
      'status': '',
      'kapasitas': '',
    },
    {
      'name': 'Gudang 3',
      'kategori': 'Gudang',
      'photo': 'assets/images/logos/inventara.png',
      'status': '',
      'kapasitas': '',
    },
    {
      'name': 'Lab 1',
      'kategori': 'Lab',
      'photo': 'assets/images/logos/inventara.png',
      'status': 'a',
      'kapasitas': '11',
    },
    {
      'name': 'Lab 2',
      'kategori': 'Lab',
      'photo': 'assets/images/logos/inventara.png',
      'status': 'b',
      'kapasitas': '12',
    },
    {
      'name': 'Lab 3',
      'kategori': 'Lab',
      'photo': 'assets/images/logos/inventara.png',
      'status': 'c',
      'kapasitas': '10',
    },
  ];
}
