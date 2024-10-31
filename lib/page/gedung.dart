import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:inventara/page/beranda.dart';

class Gedung extends StatefulWidget {
  const Gedung({Key? key}) : super(key: key);

  @override
  State<Gedung> createState() => GedungState();
}

class GedungState extends State<Gedung> {
  bool isKelasActive = true;
  bool isGudangActive = false;
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
                icon: Icon(Icons.navigate_before),
              ),
            ),
            Text(
              Tempat[0]['name'] ?? 'Gedung',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
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
        )),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 2,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                          color: isKelasActive
                              ? Color(0xFFFCA311)
                              : Colors.transparent,
                          width: 2.0),
                    ),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isKelasActive = true;
                        isGudangActive = false;
                      });
                    },
                    child: Text(
                      "Kelas",
                      style: TextStyle(color: Colors.black),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                      elevation: 0,
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 2,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                          color: isGudangActive
                              ? Color(0xFFFCA311)
                              : Colors.transparent,
                          width: 2.0),
                    ),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isGudangActive = true;
                        isKelasActive = false;
                      });
                    },
                    child:
                        Text("Gudang", style: TextStyle(color: Colors.black)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                      elevation: 0,
                    ),
                  ),
                )
              ],
            ),
            Gap(20),
            Expanded(
              child: ListView.builder(
                itemCount: isKelasActive
                    ? Gedung_1.where((item) => item['kategori'] == 'Kelas')
                        .length
                    : Gedung_1.where((item) => item['kategori'] == 'Gudang')
                        .length,
                itemBuilder: (context, index) {
                  var filteredList = isKelasActive
                      ? Gedung_1.where((item) => item['kategori'] == 'Kelas')
                          .toList()
                      : Gedung_1.where((item) => item['kategori'] == 'Gudang')
                          .toList();
                  var gudang = filteredList[index];
                  return Container(
                    height: 61,
                    margin: EdgeInsets.only(left: 24, right: 24, bottom: 8),
                    padding: EdgeInsets.only(left: 8, right: 16),
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
                      borderRadius: BorderRadius.circular(16),
                    ),
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
                              Gap(16),
                              Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      gudang['name'] ?? '',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    gudang['status'] != null &&
                                            gudang['status']!.isNotEmpty
                                        ? Text(
                                            gudang['status'] ?? '',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.black54),
                                          )
                                        : SizedBox.shrink()
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
                                      gudang['kapasitas'] ?? '',
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Color(0xFFFCA311)),
                                    ),
                                  ],
                                ),
                              )
                            : SizedBox.shrink(),
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ));
  }

  List<Map<String, String>> Tempat = [
    {
      'name': 'Gedung 1',
      'kategori': 'Gedung',
      'photo': 'assets/images/logos/inventara.png',
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
  ];
}
// Widget Gudang() {
//   List<Map<String, String>> Gedung_1 = [
//     {
//       'name': 'Kelas 1',
//       'kategori': 'Kelas',
//       'photo': 'assets/images/logos/inventara.png',
//       'status': 'Tidak Digunakan',
//       'kapasitas': '20',
//     },
//     {
//       'name': 'Kelas 2',
//       'kategori': 'Kelas',
//       'photo': 'assets/images/logos/inventara.png',
//       'status': 'Tidak Digunakan',
//       'kapasitas': '20',
//     },
//     {
//       'name': 'Kelas 3',
//       'kategori': 'Kelas',
//       'photo': 'assets/images/logos/inventara.png',
//       'status': 'Digunakan',
//       'kapasitas': '20',
//     },
//     {
//       'name': 'Gudang 1',
//       'kategori': 'Gudang',
//       'photo': 'assets/images/logos/inventara.png',
//       'status': '',
//       'kapasitas': '',
//     },
//     {
//       'name': 'Gudang 2',
//       'kategori': 'Gudang',
//       'photo': 'assets/images/logos/inventara.png',
//       'status': '',
//       'kapasitas': '',
//     },
//     {
//       'name': 'Gudang 3',
//       'kategori': 'Gudang',
//       'photo': 'assets/images/logos/inventara.png',
//       'status': '',
//       'kapasitas': '',
//     },
//   ];
//   List<Map<String, String>> kelasList = Gedung_1.where((item) => item['kategori'] == 'Gudang').toList();
//
//   return GridView.builder(
//     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//       crossAxisCount: 2,
//       crossAxisSpacing: 10,
//       mainAxisSpacing: 10,
//     ),
//     itemCount: kelasList.length,
//     itemBuilder: (context, index) {
//       return Card(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Image.asset(kelasList[index]['photo'] ?? '', height: 50, width: 50),
//             Text(kelasList[index]['name'] ?? ''),
//             Text(kelasList[index]['status'] ?? ''),
//             Text('Kapasitas: ${kelasList[index]['kapasitas'] ?? ''}'),
//           ],
//         ),
//       );
//     },
//   );
// }
// Widget Kelas() {
//   List<Map<String, String>> Gedung_1 = [
//     {
//       'name': 'Kelas 1',
//       'kategori': 'Kelas',
//       'photo': 'assets/images/logos/inventara.png',
//       'status': 'Tidak Digunakan',
//       'kapasitas': '20',
//     },
//     {
//       'name': 'Kelas 2',
//       'kategori': 'Kelas',
//       'photo': 'assets/images/logos/inventara.png',
//       'status': 'Tidak Digunakan',
//       'kapasitas': '20',
//     },
//     {
//       'name': 'Kelas 3',
//       'kategori': 'Kelas',
//       'photo': 'assets/images/logos/inventara.png',
//       'status': 'Digunakan',
//       'kapasitas': '20',
//     },
//     {
//       'name': 'Gudang 1',
//       'kategori': 'Gudang',
//       'photo': 'assets/images/logos/inventara.png',
//       'status': '',
//       'kapasitas': '',
//     },
//     {
//       'name': 'Gudang 2',
//       'kategori': 'Gudang',
//       'photo': 'assets/images/logos/inventara.png',
//       'status': '',
//       'kapasitas': '',
//     },
//     {
//       'name': 'Gudang 3',
//       'kategori': 'Gudang',
//       'photo': 'assets/images/logos/inventara.png',
//       'status': '',
//       'kapasitas': '',
//     },
//   ];
//   List<Map<String, String>> kelasList = Gedung_1.where((item) => item['kategori'] == 'Kelas').toList();
//
//   return GridView.builder(
//     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//       crossAxisCount: 2,
//       crossAxisSpacing: 10,
//       mainAxisSpacing: 10,
//     ),
//     itemCount: kelasList.length,
//     itemBuilder: (context, index) {
//       return Card(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Image.asset(kelasList[index]['photo'] ?? '', height: 50, width: 50),
//             Text(kelasList[index]['name'] ?? ''),
//             Text(kelasList[index]['status'] ?? ''),
//             Text('Kapasitas: ${kelasList[index]['kapasitas'] ?? ''}'),
//           ],
//         ),
//       );
//     },
//   );
// }
