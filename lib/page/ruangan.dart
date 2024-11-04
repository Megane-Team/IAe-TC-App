import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class Ruangan extends StatefulWidget {
  const Ruangan({Key? key}) : super(key: key);

  @override
  State<Ruangan> createState() => RuanganState();
}

class RuanganState extends State<Ruangan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 247,
              decoration: const BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50)
                )
              ),
              child: Image.asset('assets/images/logos/inventara.png'),
            ),
            SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 24, right: 24, top: 8),
                    child: Column(
                      children: [
                        Row(
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
                                onPressed: () {},
                                icon: Icon(Icons.navigate_before),
                              ),
                            ),
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
                                onPressed: () {},
                                icon: Icon(Icons.search),
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
                              )
                            ]
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12, right: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(Gedung_1[0]['name']!, style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600
                                    ),),
                                    Text(Gedung_1[0]['status']!, style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400
                                    ),),
                                  ],
                                ),
                                Container(
                                  width: 46,
                                  height: 22,
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color(0xFFFCA311).withOpacity(1),
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
                                      Icon(
                                        Icons.person,
                                        color: Color(0xFFFCA311),
                                        size: 16,
                                      ),
                                      Text(
                                        Gedung_1[0]['kapasitas'] ?? '',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Color(0xFFFCA311)),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                        ),
                        const Gap(22),
                      ],
                    ),
                  ),
                  Gap(12),
                  SizedBox(
                    height: MediaQuery.of(context).size.height - 400,
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: Kelas_1.map((item) => item['name']).toSet().length,
                      itemBuilder: (context, index) {
                        final uniqueNames = Kelas_1.map((item) => item['name']).toSet().toList()..sort();
                        return Container(
                          margin: EdgeInsets.only(bottom: 24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 24, right: 24),
                                child: Text(uniqueNames[index]!, style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500
                                ),),
                              ),
                              Divider(
                                color: Colors.black,
                                thickness: 1,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 24, right: 24),
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: Kelas_1.where((item) => item['name'] == uniqueNames[index]).length,
                                  itemBuilder: (context, index2) {
                                    final items = Kelas_1.where((item) => item['name'] == uniqueNames[index]).toList()
                                      ..sort((a, b) {
                                        if (a['status'] == 'Digunakan' && b['status'] != 'Digunakan') return 1;
                                        if (a['status'] != 'Digunakan' && b['status'] == 'Digunakan') return -1;
                                        return int.parse(a['kode_barang']!).compareTo(int.parse(b['kode_barang']!));
                                      });
                                    return Container(
                                      margin: EdgeInsets.only(top: 10),
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
                                            )
                                          ]
                                      ),
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          padding: EdgeInsets.only(left: 10, right: 10),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(16),
                                          ),
                                          elevation: 4,
                                          shadowColor: Colors.black.withOpacity(0.1),
                                        ),
                                        onPressed: items[index2]['status'] == 'Digunakan' ? null : () {
                                          showModalBottomSheet(
                                            showDragHandle: true,
                                            context: context,
                                            builder: (BuildContext context) {
                                              return Padding(
                                                padding: EdgeInsets.only(left: 24, right: 24, bottom: 32),
                                                child: Container(
                                                  width: MediaQuery.of(context).size.width,
                                                  height: MediaQuery.of(context).size.height/2.6,
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
                                                        child: Image.asset(items[index2]['photo']!, width: 50, height: 50,),
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text(items[index2]['name']!, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                                                          Text(' ${items[index2]['kode_barang']!}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                                                        ],
                                                      ),
                                                      Text('Kondisi ${items[index2]['kondisi']!}'),
                                                      Expanded(
                                                        child: Align(
                                                          alignment: Alignment.bottomCenter,
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              Container(
                                                                width: MediaQuery.of(context).size.width / 2.3,
                                                                child: ElevatedButton(
                                                                  onPressed: () {
                                                                    Navigator.pop(context);
                                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                                      const SnackBar(
                                                                        content: Text('Barang Disimpan di Keranjang'),
                                                                      ),
                                                                    );
                                                                  },
                                                                  style: ElevatedButton.styleFrom(
                                                                    padding: EdgeInsets.zero,
                                                                    side: BorderSide(color: Color(0xFFFCA311)),
                                                                  ),
                                                                  child: Text(
                                                                    'Masukan Keranjang',
                                                                    style: TextStyle(color: Color(0xFFFCA311), fontWeight: FontWeight.w600),
                                                                  ),
                                                                ),
                                                              ),
                                                              Container(
                                                                width: MediaQuery.of(context).size.width / 2.3,
                                                                child: ElevatedButton(
                                                                  onPressed: () {
                                                                    Navigator.pop(context);
                                                                  },
                                                                  style: ElevatedButton.styleFrom(
                                                                    padding: EdgeInsets.zero,
                                                                    backgroundColor: Color(0xFFFCA311),
                                                                  ),
                                                                  child: Text(
                                                                    'Pinjam Barang',
                                                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          );
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
                                              child: Image.asset(items[index2]['photo']!, width: 50, height: 50,),
                                            ),
                                            Gap(4),
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(items[index2]['name']!,style: TextStyle(color: Colors.black),),
                                                    Text(' ${items[index2]['kode_barang']!}',style: TextStyle(color: Colors.black),),
                                                  ],
                                                ),
                                                Text(items[index2]['kondisi']!, style: TextStyle(color: Colors.black),),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  )
                ],
              )
            )
          ],
        ),
      )
    );
  }

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
  ];
}