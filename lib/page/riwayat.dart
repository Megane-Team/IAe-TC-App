// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:intl/intl.dart';
// import 'package:gap/gap.dart';
// import 'package:inventara/actions/peminjaman/read_peminjaman_action.dart';
// import 'package:inventara/structures/peminjaman_status.dart';
//
// import 'package:inventara/utils/actionwidget.dart';
//
// class Riwayat extends StatefulWidget {
//   const Riwayat({super.key});
//
//   @override
//   State<Riwayat> createState() => RiwayatState();
// }
//
// class RiwayatState extends State<Riwayat> {
//   bool isBerlangsungActive = true;
//   bool isSelesaiActive = false;
//
//   String peminjamanStatusToString(PeminjamanStatus ps) {
//     switch (ps) {
//       case PeminjamanStatus.pending:
//         return 'Menunggu Konfirmasi';
//       case PeminjamanStatus.approved:
//         return 'Disetujui';
//       case PeminjamanStatus.rejected:
//         return 'Ditolak';
//       case PeminjamanStatus.canceled:
//         return 'Dibatalkan';
//       case PeminjamanStatus.returned:
//         return 'Selesai';
//       default:
//         return 'Unknown';
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//             automaticallyImplyLeading: false,
//             title: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Container(
//               width: 40,
//               decoration: BoxDecoration(boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.1),
//                   spreadRadius: 1,
//                   blurRadius: 4,
//                   offset: const Offset(0, 0),
//                 )
//               ], color: Colors.white, shape: BoxShape.circle),
//               child: IconButton(
//                 onPressed: () {
//                   context.pop();
//                 },
//                 icon: const Icon(Icons.navigate_before),
//               ),
//             ),
//             const Text(
//               'Riwayat',
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
//             ),
//             const Gap(40),
//           ],
//         )),
//         body: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Row(
//               children: [
//                 Container(
//                   width: MediaQuery.of(context).size.width / 2,
//                   decoration: BoxDecoration(
//                     border: Border(
//                       bottom: BorderSide(
//                         color: isBerlangsungActive
//                             ? const Color(0xFFFCA311)
//                             : Colors.transparent,
//                         width: 2.0,
//                       ),
//                     ),
//                   ),
//                   child: ElevatedButton(
//                     onPressed: () {
//                       setState(() {
//                         isBerlangsungActive = true;
//                         isSelesaiActive = false;
//                       });
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.white,
//                       shape: const RoundedRectangleBorder(
//                         borderRadius: BorderRadius.zero,
//                       ),
//                       elevation: 0,
//                       padding: EdgeInsets.zero,
//                       minimumSize: const Size(double.infinity, 48),
//                     ),
//                     child: const Text(
//                       "Berlangsung",
//                       style: TextStyle(color: Colors.black),
//                     ),
//                   ),
//                 ),
//                 Container(
//                   width: MediaQuery.of(context).size.width / 2,
//                   decoration: BoxDecoration(
//                     border: Border(
//                       bottom: BorderSide(
//                           color: isSelesaiActive
//                               ? const Color(0xFFFCA311)
//                               : Colors.transparent,
//                           width: 2.0),
//                     ),
//                   ),
//                   child: ElevatedButton(
//                     onPressed: () {
//                       setState(() {
//                         isSelesaiActive = true;
//                         isBerlangsungActive = false;
//                       });
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.white,
//                       shape: const RoundedRectangleBorder(
//                         borderRadius: BorderRadius.zero,
//                       ),
//                       elevation: 0,
//                       padding: EdgeInsets.zero,
//                       minimumSize: const Size(double.infinity, 48),
//                     ),
//                     child: const Text("Selesai",
//                         style: TextStyle(color: Colors.black)),
//                   ),
//                 )
//               ],
//             ),
//             const Gap(20),
//             Expanded(
//               child: FutureBuilder(
//                 future: readPeminjaman(),
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return const Center(
//                       child: CircularProgressIndicator(),
//                     );
//                   }
//                   if (snapshot.hasError) {
//                     return Center(
//                       child: noData()
//                     );
//                   }
//                   if (snapshot.hasData){
//                     var peminjaman = snapshot.data!;
//                     if (peminjaman.isEmpty) {
//                       return Center(
//                         child: SizedBox()
//                       );
//                     }
//                     return ListView.builder(
//                       shrinkWrap: true,
//                       itemCount: isBerlangsungActive
//                         ? peminjaman.where((item) =>
//                             item.status == PeminjamanStatus.approved ||
//                             item.status == PeminjamanStatus.pending).length
//                         : peminjaman.where((item) =>
//                             item.status == PeminjamanStatus.canceled ||
//                             item.status == PeminjamanStatus.returned ||
//                             item.status == PeminjamanStatus.rejected).length,
//                       itemBuilder: (context, index) {
//                         var filteredList = isBerlangsungActive
//                             ? peminjaman
//                             .where((item) =>
//                                 item.status == PeminjamanStatus.approved ||
//                                 item.status == PeminjamanStatus.pending)
//                             .toList()
//                             : peminjaman
//                             .where((item) =>
//                                 item.status == PeminjamanStatus.canceled ||
//                                 item.status == PeminjamanStatus.returned ||
//                                 item.status == PeminjamanStatus.rejected).toList();
//                         filteredList
//                             .sort((a, b) => b.createdAt.compareTo(a.createdAt));
//                         var p = filteredList[index];
//                         return Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 24),
//                           child: SingleChildScrollView(
//                             child: Container(
//                               margin: const EdgeInsets.only(bottom: 8),
//                               decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: Colors.black.withOpacity(0.1),
//                                     spreadRadius: 1,
//                                     blurRadius: 4,
//                                     offset: const Offset(0, 0),
//                                   ),
//                                 ],
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   // Header
//                                   Container(
//                                     decoration: const BoxDecoration(
//                                       border: Border(
//                                           bottom: BorderSide(
//                                               color: Colors.black12, width: 1)),
//                                     ),
//                                     child: Padding(
//                                       padding: const EdgeInsets.symmetric(
//                                           horizontal: 8, vertical: 8),
//                                       child: Row(
//                                         mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           Text(
//                                             DateFormat('dd MMM yyyy')
//                                                 .format(p.createdAt),
//                                             style: const TextStyle(
//                                                 fontSize: 14,
//                                                 fontWeight: FontWeight.w500),
//                                           ),
//                                           Text(
//                                             peminjamanStatusToString(p.status),
//                                             style: const TextStyle(
//                                                 fontSize: 14, color: Colors.black),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                   // Content
//                                   Row(
//                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                     crossAxisAlignment: CrossAxisAlignment.end,
//                                     children: [
//                                       Expanded(
//                                         child: Padding(
//                                           padding: const EdgeInsets.only(
//                                               bottom: 8, left: 8, top: 8),
//                                           child: Column(
//                                             crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                             children: [
//                                               Row(
//                                                 children: [
//                                                   Container(
//                                                     width: 60,
//                                                     height: 50,
//                                                     decoration: BoxDecoration(
//                                                       color: Colors.grey[200],
//                                                       borderRadius:
//                                                       BorderRadius.circular(8),
//                                                     ),
//                                                     child: Image.asset(
//                                                       p['barang'][0]['img'],
//                                                       fit: BoxFit.cover,
//                                                     ),
//                                                   ),
//                                                   const SizedBox(width: 8),
//                                                   Expanded(
//                                                     child: Column(
//                                                       crossAxisAlignment:
//                                                       CrossAxisAlignment.start,
//                                                       children: [
//                                                         Text(
//                                                           p['barang'][0]['nama'],
//                                                           style: const TextStyle(
//                                                             fontSize: 16,
//                                                             fontWeight:
//                                                             FontWeight.w600,
//                                                           ),
//                                                         ),
//                                                         Text(
//                                                           'Di ${p['barang'][0]['asal']}',
//                                                           style: const TextStyle(
//                                                             fontSize: 14,
//                                                             color: Colors.grey,
//                                                           ),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                               const SizedBox(height: 8),
//                                               if (p['barang'].length > 1)
//                                                 Text(
//                                                   '+${p['barang'].length - 1} Barang lainnya',
//                                                   style: const TextStyle(
//                                                       fontSize: 14,
//                                                       color: Colors.grey),
//                                                 ),
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                       Padding(
//                                         padding: const EdgeInsets.only(
//                                             bottom: 8, right: 8),
//                                         child: Container(
//                                           width: 100,
//                                           height: 30,
//                                           decoration: BoxDecoration(
//                                             borderRadius: BorderRadius.circular(8),
//                                           ),
//                                           child: ElevatedButton(
//                                             onPressed: () {},
//                                             style: ElevatedButton.styleFrom(
//                                               padding: EdgeInsets.zero,
//                                               maximumSize: const Size(100, 40),
//                                               backgroundColor: Colors.orange,
//                                               shape: RoundedRectangleBorder(
//                                                 borderRadius:
//                                                 BorderRadius.circular(8),
//                                               ),
//                                             ),
//                                             child: const Text(
//                                               'Detail',
//                                               style: TextStyle(
//                                                   fontSize: 12,
//                                                   fontWeight: FontWeight.w600),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         );
//                       },
//                     );
//                   } else {
//                     return Center(
//                       child: SizedBox()
//                     );
//                   }
//                 }
//               ),
//             ),
//           ],
//         ));
//   }
//   //
//   // List<Map<String, dynamic>> peminjaman = <Map<String, dynamic>>[
//   //   {
//   //     'tanggal': DateTime.parse('2024-11-03'),
//   //     'kategori': 'Selesai',
//   //     'status': 'Selesai',
//   //     'barang': [
//   //       {
//   //         'nama': 'A 1',
//   //         'asal': 'Gedung 1',
//   //         'img': 'assets/images/logos/inventara.png'
//   //       },
//   //       {
//   //         'nama': 'C 2',
//   //         'asal': 'Gedung 2',
//   //         'img': 'assets/images/logos/inventara.png'
//   //       },
//   //       {
//   //         'nama': 'B 3',
//   //         'asal': 'Gedung 1',
//   //         'img': 'assets/images/logos/inventara.png'
//   //       },
//   //     ],
//   //   },
//   //   {
//   //     'tanggal': DateTime.parse('2024-01-03'),
//   //     'kategori': 'Berlangsung',
//   //     'status': 'Berlangsung',
//   //     'barang': [
//   //       {
//   //         'nama': 'B 1',
//   //         'asal': 'Gedung 3',
//   //         'img': 'assets/images/logos/inventara.png'
//   //       },
//   //       {
//   //         'nama': 'A 2',
//   //         'asal': 'Gedung 2',
//   //         'img': 'assets/images/logos/inventara.png'
//   //       },
//   //       {
//   //         'nama': 'C 3',
//   //         'asal': 'Gedung 4',
//   //         'img': 'assets/images/logos/inventara.png'
//   //       },
//   //     ],
//   //   },
//   //   {
//   //     'tanggal': DateTime.parse('2024-01-31'),
//   //     'kategori': 'Berlangsung',
//   //     'status': 'Menunggu Konfirmasi',
//   //     'barang': [
//   //       {
//   //         'nama': 'B 1',
//   //         'asal': 'Gedung 3',
//   //         'img': 'assets/images/logos/inventara.png'
//   //       },
//   //     ],
//   //   },
//   //   {
//   //     'tanggal': DateTime.parse('2024-01-31'),
//   //     'kategori': 'Selesai',
//   //     'status': 'Selesai',
//   //     'barang': [
//   //       {
//   //         'nama': 'B 1',
//   //         'asal': 'Gedung 3',
//   //         'img': 'assets/images/logos/inventara.png'
//   //       },
//   //     ],
//   //   },
//   //   {
//   //     'tanggal': DateTime.parse('2024-11-01'),
//   //     'kategori': 'Selesai',
//   //     'status': 'Selesai',
//   //     'barang': [
//   //       {
//   //         'nama': 'A 1',
//   //         'asal': 'Gedung 1',
//   //         'img': 'assets/images/logos/inventara.png'
//   //       },
//   //       {
//   //         'nama': 'C 2',
//   //         'asal': 'Gedung 2',
//   //         'img': 'assets/images/logos/inventara.png'
//   //       },
//   //       {
//   //         'nama': 'B 3',
//   //         'asal': 'Gedung 1',
//   //         'img': 'assets/images/logos/inventara.png'
//   //       },
//   //     ],
//   //   },
//   //   {
//   //     'tanggal': DateTime.parse('2024-01-01'),
//   //     'kategori': 'Berlangsung',
//   //     'status': 'Menunggu Konfirmasi',
//   //     'barang': [
//   //       {
//   //         'nama': 'B 1',
//   //         'asal': 'Gedung 3',
//   //         'img': 'assets/images/logos/inventara.png'
//   //       },
//   //       {
//   //         'nama': 'A 2',
//   //         'asal': 'Gedung 2',
//   //         'img': 'assets/images/logos/inventara.png'
//   //       },
//   //       {
//   //         'nama': 'C 3',
//   //         'asal': 'Gedung 4',
//   //         'img': 'assets/images/logos/inventara.png'
//   //       },
//   //     ],
//   //   },
//   // ];
// }
