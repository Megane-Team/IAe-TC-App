import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class Gedung extends StatefulWidget {
  const Gedung({Key? key}) : super(key: key);

  @override
  State<Gedung> createState() => GedungState();
}

class GedungState extends State<Gedung> {
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
                shape: BoxShape.circle
              ),
              child: IconButton(
                onPressed: null,
                icon: Icon(Icons.navigate_before),
              ),
            ),
            Text(Tempat[0]['name'] ?? 'Gedung', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
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
                  shape: BoxShape.circle
              ),
              child: IconButton(
                onPressed: null,
                icon: Icon(Icons.search),
              ),
            ),
          ],
        )
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width/2,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.black, width: 2.0),
                  ),
                ),
                child: ElevatedButton(
                  onPressed: (){},
                  child: Text("Kelas", style: TextStyle(color: Colors.black),),
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
                width: MediaQuery.of(context).size.width/2,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.black, width: 2.0),
                  ),
                ),
                child: ElevatedButton(
                  onPressed: (){},
                  child: Text("Gudang", style: TextStyle(color: Colors.black)),
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
              itemCount: Gedung_1.length,
              itemBuilder: (context, index) {
                var gudang = Gedung_1[index];
                return Container(
                  margin: EdgeInsets.only(left: 24, right: 24, bottom: 8),
                  padding: EdgeInsets.all(8.0),
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
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.black
                        ),
                        child: Image.asset(gudang['photo'] ?? '', height: 50, width: 50),
                      ),
                      Gap(16),
                      Text(gudang['name'] ?? ''),
                    ],
                  ),
                );
              },
            ),
          )
        ],
      )
    );
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