import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class Cari extends StatefulWidget {
  const Cari({super.key});

  @override
  State<Cari> createState() => CariState();
}

class CariState extends State<Cari> {
  List<Map<String, String>> filteredList = List.from(Kelas_1);

  void _filterAndUpdateList(String value) {
    setState(() {
      if (value.isEmpty) {
        filteredList = List.from(Kelas_1);
      } else {
        filteredList = Kelas_1.where((item) =>
            item['name']!.toLowerCase().contains(value.toLowerCase()) ||
            item['kode_barang']!
                .toLowerCase()
                .contains(value.toLowerCase())).toList();
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
                    hintText: 'Cari barang...',
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
        child: ListView.builder(
          itemCount: filteredList.length,
          itemBuilder: (context, index) {
            final item = filteredList[index];
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
                  backgroundColor: item['status'] == 'Digunakan'
                      ? Colors.black12
                      : Colors.white,
                  shadowColor: Colors.black.withOpacity(0.1),
                ),
                onPressed: () {
                  if (item['status'] == 'Digunakan') {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(
                            'Asset sedang Digunakan',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: Peminjaman.map((item) => Text(
                                  'Name: ${item['name']}\nDivisi: ${item['Divisi']}\nEstimasi Peminjaman: ${item['estimasi peminjaman']}',
                                  style: TextStyle(height: 2),
                                )).toList(),
                          ),
                          actions: [
                            SizedBox(
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
                  } else {
                    showModalBottomSheet(
                      showDragHandle: true,
                      context: context,
                      builder: (BuildContext context) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              left: 24, right: 24, bottom: 32),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height / 2.6,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 218,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Image.asset(
                                    item['photo']!,
                                    width: 50,
                                    height: 50,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      item['name']!,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      ' ${item['kode_barang']!}',
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                                Text('Kondisi ${item['kondisi']!}'),
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2.3,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                      'Barang Disimpan di Keranjang'),
                                                ),
                                              );
                                            },
                                            style: ElevatedButton.styleFrom(
                                              padding: EdgeInsets.zero,
                                              side: const BorderSide(
                                                  color: Color(0xFFFCA311)),
                                            ),
                                            child: const Text(
                                              'Masukan Keranjang',
                                              style: TextStyle(
                                                  color: Color(0xFFFCA311),
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2.3,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            style: ElevatedButton.styleFrom(
                                              padding: EdgeInsets.zero,
                                              backgroundColor:
                                                  const Color(0xFFFCA311),
                                            ),
                                            child: const Text(
                                              'Pinjam Barang',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600),
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
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Image.asset(
                        item['photo']!,
                        width: 50,
                        height: 50,
                      ),
                    ),
                    const Gap(4),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${item['name']} ${item['kode_barang']}',
                          style: const TextStyle(color: Colors.black),
                        ),
                        Text(
                          item['kondisi']!,
                          style: const TextStyle(color: Colors.black),
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
    );
  }
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
    'name': 'Meja',
    'kode_barang': '3',
    'photo': 'assets/images/logos/inventara.png',
    'kondisi': 'Kurang Baik',
    'status': 'Digunakan',
  },
];
