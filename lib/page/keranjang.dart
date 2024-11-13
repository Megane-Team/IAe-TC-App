import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class Keranjang extends StatefulWidget {
  const Keranjang({super.key});

  @override
  State<Keranjang> createState() => KeranjangState();
}

class KeranjangState extends State<Keranjang> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
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
                  onPressed: () {},
                  icon: const Icon(Icons.navigate_before),
                ),
              ),
              const Text(
                'Keranjang Peminjaman',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              const Gap(40)
            ],
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top: 24, left: 24, right: 24),
                  child: Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: Peminjaman.map((item) => item['tempat'])
                            .toSet()
                            .length,
                        itemBuilder: (context, index) {
                          final uniqueAsal =
                              Peminjaman.map((item) => item['tempat'])
                                  .toSet()
                                  .toList()
                                ..sort((a, b) => a!.compareTo(b!));
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  spreadRadius: 1,
                                  blurRadius: 4,
                                  offset: const Offset(0, 0),
                                )
                              ],
                            ),
                            padding: const EdgeInsets.only(
                                left: 8, right: 8, top: 8, bottom: 24),
                            margin: const EdgeInsets.only(bottom: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  uniqueAsal[index]!,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(left: 4),
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: Peminjaman.where((item) =>
                                          item['tempat'] ==
                                          uniqueAsal[index]).length,
                                      itemBuilder: (context, subIndex) {
                                        final itemsInTempat = Peminjaman.where(
                                            (item) =>
                                                item['tempat'] ==
                                                uniqueAsal[index]).toList();
                                        itemsInTempat.sort((a, b) =>
                                            a['ruangan']!
                                                .compareTo(b['ruangan']!));
                                        final item = itemsInTempat[subIndex];
                                        return Container(
                                          margin: const EdgeInsets.only(top: 4),
                                          padding:
                                              const EdgeInsets.only(left: 12),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 60,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.1),
                                                  spreadRadius: 1,
                                                  blurRadius: 4,
                                                  offset: const Offset(0, 0),
                                                )
                                              ],
                                              border: const Border(
                                                left: BorderSide(
                                                  color: Color(0xFFFCA311),
                                                  width: 3,
                                                ),
                                              )),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    width: 60,
                                                    decoration: BoxDecoration(
                                                      color: Colors.black,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    child: Image.asset(
                                                      item['photo']!,
                                                      width: 50,
                                                      height: 50,
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
                                                      Text(
                                                        '${item['name']!} ${item['kode_barang']}',
                                                        style: const TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                      Text(
                                                        item['ruangan']!,
                                                        style: const TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.black54,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              IconButton(
                                                onPressed: () {},
                                                icon: const Icon(
                                                  Icons.delete,
                                                  color: Colors.red,
                                                ),
                                              )
                                            ],
                                          ),
                                        );
                                      },
                                    ))
                              ],
                            ),
                          );
                        },
                      ),
                    ],
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

  List<Map<String, String>> Peminjaman = [
    {
      'name': 'Kursi',
      'kode_barang': '1',
      'photo': 'assets/images/logos/inventara.png',
      'tempat': 'Gedung A',
      'ruangan': 'Kelas 1'
    },
    {
      'name': 'Kursi',
      'kode_barang': '2',
      'photo': 'assets/images/logos/inventara.png',
      'tempat': 'Gedung B',
      'ruangan': 'Gudang 2'
    },
    {
      'name': 'Meja',
      'kode_barang': '3',
      'photo': 'assets/images/logos/inventara.png',
      'tempat': 'Gedung C',
      'ruangan': 'Gudang 1'
    },
    {
      'name': 'Kursi',
      'kode_barang': '2',
      'photo': 'assets/images/logos/inventara.png',
      'tempat': 'Gedung B',
      'ruangan': 'Gudang 2'
    },
    {
      'name': 'Kursi',
      'kode_barang': '2',
      'photo': 'assets/images/logos/inventara.png',
      'tempat': 'Gedung B',
      'ruangan': 'Gudang 2'
    },
    {
      'name': 'Meja',
      'kode_barang': '4',
      'photo': 'assets/images/logos/inventara.png',
      'tempat': 'Gedung B',
      'ruangan': 'Gudang 1'
    },
  ];
}
