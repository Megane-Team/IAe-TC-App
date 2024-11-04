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
                      itemCount: Kelas_1.map((item) => item['name']).toSet().length,
                      itemBuilder: (context, index) {
                        final uniqueNames = Kelas_1.map((item) => item['name']).toSet().toList();
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
                                    final items = Kelas_1.where((item) => item['name'] == uniqueNames[index]).toList();
                                    return Container(
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
                                      child: Row(
                                        children: [
                                          Image.asset(items[index2]['photo']!, width: 50, height: 50,),
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(items[index2]['name']!),
                                                  Text(items[index2]['kode_barang']!),
                                                ],
                                              ),
                                              Text(items[index2]['kondisi']!),
                                            ],
                                          )
                                        ],
                                      )
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