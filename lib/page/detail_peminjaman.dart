import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class DetailPeminjaman extends StatefulWidget {
  const DetailPeminjaman({super.key});

  @override
  State<DetailPeminjaman> createState() => _DetailPeminjamanState();
}

class _DetailPeminjamanState extends State<DetailPeminjaman> {
  final TextEditingController _alasanController = TextEditingController();
  final item = data[0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
                  ),
                ],
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                onPressed: () {
                  setState(() {
                    context.pop();
                  });
                },
                icon: const Icon(Icons.navigate_before, color: Colors.black),
              ),
            ),
            const Text(
              'Detail Peminjaman',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            const Gap(40),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(right: 24, left: 24, top: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Status Peminjaman',
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                                fontWeight: FontWeight.w600)),
                        if (item['status'] == 'pending') ...[
                          Text('Menunggu Persetujuan',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12)),
                        ] else if (item['status'] == 'approved') ...[
                          Text('Berlangsung',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12)),
                        ] else if (item['status'] == 'rejected') ...[
                          Text('Ditolak',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12)),
                        ] else if (item['status'] == 'returned') ...[
                          Text('Selesai',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12)),
                        ] else if (item['status'] == 'canceled') ...[
                          Text('Dibatalkan User',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12)),
                        ],
                      ],
                    ),
                    Gap(8),
                    Divider(height: 1, thickness: 1, color: Colors.black),
                    Gap(8),
                    Text('Informasi Pengajuan',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 12)),
                    if (item['createdAt'] != null) ...[
                      Gap(4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Tanggal Pengajuan',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w600)),
                          Text(
                              DateFormat('dd MMM yyyy')
                                  .format(item['createdAt']),
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 12)),
                        ],
                      ),
                    ],
                    if (item['borrowedDate'] != null) ...[
                      Gap(4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Tanggal Peminjaman',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w600)),
                          Text(
                              DateFormat('dd MMM yyyy')
                                  .format(item['borrowedDate']),
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 12)),
                        ],
                      ),
                    ],
                    if (item['estimatedTime'] != null) ...[
                      Gap(4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Estimasi Pengembalian',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w600)),
                          Text(
                              DateFormat('dd MMM yyyy')
                                  .format(item['estimatedTime']),
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 12)),
                        ],
                      ),
                    ],
                    if (item['returnDate'] != null) ...[
                      Gap(4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Tanggal Pengembalian',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w600)),
                          Text(
                              DateFormat('dd MMM yyyy')
                                  .format(item['returnDate']),
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 12)),
                        ],
                      ),
                    ],
                    if (item['status'] == 'pending') ...[
                      Gap(4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Batal Otomatis',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w600)),
                          Text(
                              DateFormat('dd MMM yyyy').format(
                                  item['createdAt'].add(Duration(days: 2))),
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 12)),
                        ],
                      ),
                    ],
                    Gap(8),
                    Divider(height: 1, thickness: 1, color: Colors.black),
                    Gap(8),
                    Text('Detail Asset',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 12)),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: item['asset'].length,
                      itemBuilder: (context, index) {
                        var asset = item['asset'][index];
                        return Container(
                          margin: const EdgeInsets.only(top: 8),
                          decoration: BoxDecoration(),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: 60,
                                height: 46,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.white,
                                  image: DecorationImage(
                                    image: AssetImage(asset['photo']),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Gap(4),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (asset['kategori'] == 'kendaraan') ...[
                                    Text(asset['name'],
                                        style: TextStyle(
                                            fontSize: 8,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.grey)),
                                    Text(asset['plat'],
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12)),
                                    Text(asset['asal'],
                                        style: TextStyle(
                                            fontSize: 8,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.grey)),
                                  ] else if (asset['kategori'] ==
                                      'ruangan') ...[
                                    Text(asset['kode'],
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12)),
                                    Text(asset['asal'],
                                        style: TextStyle(
                                            fontSize: 8,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.grey)),
                                  ] else ...[
                                    Text(asset['name'],
                                        style: TextStyle(
                                            fontSize: 8,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.grey)),
                                    Text(asset['kode'],
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12)),
                                    Text(asset['asal'],
                                        style: TextStyle(
                                            fontSize: 8,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.grey)),
                                  ]
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    Gap(12),
                    Divider(height: 1, thickness: 1, color: Colors.black),
                    Gap(8),
                    Text('Keterangan',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 12)),
                    if (item['destination'] != null) ...[
                      Gap(8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Tempat Tujuan',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w600)),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Text(
                              item['destination'],
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 12),
                              textAlign: TextAlign.right,
                              overflow: TextOverflow.visible,
                            ),
                          ),
                        ],
                      ),
                    ],
                    if (item['penumpang'] != null) ...[
                      Gap(8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Penumpang',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w600)),
                          Text('${item['penumpang']} Orang'.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 12)),
                        ],
                      ),
                    ],
                    if (item['objective'] != null) ...[
                      Gap(8),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Tujuan',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w600)),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: Text(
                                  item['objective'],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12),
                                  textAlign: TextAlign.right,
                                  overflow: TextOverflow.visible,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                    if (item['canceledReason'] != null) ...[
                      Gap(8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Alasan Ditolak',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w600)),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Text(
                              item['canceledReason'],
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 12),
                              textAlign: TextAlign.right,
                              overflow: TextOverflow.visible,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ),
            if (item['status'] == 'pending')
              SizedBox(
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
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      8), // Adjust the radius as needed
                                ),
                                title: Text(
                                  'Alasan Pembatalan',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20),
                                ),
                                content: Container(
                                  margin: const EdgeInsets.only(top: 28),
                                  width: MediaQuery.of(context).size.width - 48,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                    color: Colors.black.withOpacity(0.5),
                                  ))),
                                  child: TextField(
                                    controller: _alasanController,
                                    cursorColor: Colors.black,
                                    decoration: InputDecoration(
                                      hintStyle: const TextStyle(
                                          color: Colors.black54, fontSize: 16),
                                      hintText: 'ketik alasan dibatalkan...',
                                      border: InputBorder.none,
                                      filled: true,
                                      fillColor: Colors.white,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 0, horizontal: 0),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    child: Text(
                                      'Batal',
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    onPressed: () {
                                      context.pop();
                                    },
                                  ),
                                  TextButton(
                                    child: Text(
                                      'OK',
                                      style: TextStyle(
                                          color: const Color(0xFFFCA311),
                                          fontWeight: FontWeight.w600),
                                    ),
                                    onPressed: () {
                                      context.pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Text(
                          'Batalkan Pengajuan',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            if (item['status'] == 'approved')
              SizedBox(
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
                        child: Text(
                          'Selesaikan Peminjaman',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }
}

List<Map<String, dynamic>> data = [
  {
    'status': 'canceled',
    'createdAt': DateTime.parse('2024-01-03T19:00:00'),
    'borrowedDate': DateTime.parse('2024-01-03T19:00:00'),
    'estimatedTime': DateTime.parse('2024-01-03T19:00:00'),
    'returnDate': null,
    'destination': null,
    'canceledReason': 'Salah Pilih Barang',
    'objective': null,
    'penumpang': null,
    'asset': [
      {
        'name': 'Pensil',
        'kode': '123',
        'photo': 'assets/images/icons/no_image.png',
        'asal': 'Gedung 1',
        'kategori': 'asset'
      },
      {
        'name': 'Innova',
        'photo': 'assets/images/icons/no_image.png',
        'asal': 'Parkiran 1',
        'kategori': 'kendaraan',
        'plat': 'Z 10 AD'
      },
      {
        'kode': 'R205',
        'photo': 'assets/images/icons/no_image.png',
        'asal': 'Gedung 1',
        'kategori': 'ruangan'
      },
    ]
  },
];
