import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as dtp;
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:inventara/actions/kendaraan/read_kendaraan_action.dart';
import 'package:inventara/actions/peminjaman/create_detail_peminjaman_action.dart';
import 'package:inventara/actions/peminjaman/create_peminjaman_action.dart';
import 'package:inventara/actions/peminjaman/read_detail_peminjaman_action.dart';
import 'package:inventara/actions/peminjaman/update_detail_peminjaman.dart';
import 'package:inventara/structures/barang.dart';
import 'package:inventara/structures/detailPeminjaman.dart';
import 'package:inventara/structures/kendaraan.dart';

class Konfirmasikendaraan extends StatefulWidget {
  final String id;
  final String category;
  const Konfirmasikendaraan(
      {required this.id, super.key, required this.category});

  @override
  State<Konfirmasikendaraan> createState() => KonfimasikendaraanState();
}

class KonfimasikendaraanState extends State<Konfirmasikendaraan> {
  late Barang barangs;
  late Kendaraan kendaraans;
  late DetailPeminjamans detailPeminjaman;
  late Future<void> fetchDataFuture;
  DateTime peminjamanDateTime = DateTime.now();
  DateTime pengembalianDateTime = DateTime.now();
  final TextEditingController _peminjamanController = TextEditingController();
  final TextEditingController _pengembalianController = TextEditingController();
  final TextEditingController _tujuanController = TextEditingController();
  final TextEditingController _tempatTujuanController = TextEditingController();
  final TextEditingController _jumlahPenumpangController =
      TextEditingController();

  @override
  void dispose() {
    _peminjamanController.dispose();
    _pengembalianController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    fetchDataFuture = fetchData();
    super.initState();
  }

  Future<void> fetchData() async {
    if (widget.category == 'kendaraan') {
      kendaraans = (await readKendaraanbyId(widget.id))!;
    } else {
      detailPeminjaman =
          (await readDetailPeminjamanbyId(int.parse(widget.id)))!;
    }
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      automaticallyImplyLeading: false,
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
                context.pop();
              },
              icon: const Icon(Icons.navigate_before),
            ),
          ),
          const Text(
            'Konfirmasi',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          const Gap(40),
        ],
      ),
    );

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: (MediaQuery.of(context).size.height / 1.05) -
              appBar.preferredSize.height,
          child: Padding(
            padding: EdgeInsets.only(top: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24),
                  child: Text(
                    'Tempat Tujuan',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ),
                Gap(4),
                Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: TextField(
                      controller: _tempatTujuanController,
                      cursorColor: Colors.black,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: InputDecoration(
                        hintStyle: const TextStyle(
                            color: Colors.black54,
                            fontSize: 12,
                            fontWeight: FontWeight.w100),
                        hintText: 'Masukan teks...',
                        border: InputBorder.none,
                        filled: false,
                        fillColor: Colors.white,
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
                ),
                Gap(16),
                Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24),
                  child: Text(
                    'Tanggal dan Waktu Mulai Peminjaman',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ),
                const Gap(4),
                Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _peminjamanController,
                            readOnly: true,
                            cursorColor: Colors.black,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                            decoration: InputDecoration(
                              hintStyle: const TextStyle(
                                  color: Colors.black54,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w100),
                              hintText: 'Pilih tanggal mulai...',
                              border: InputBorder.none,
                              filled: false,
                              fillColor: Colors.white,
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
                        IconButton(
                          icon: const Icon(Icons.calendar_month),
                          onPressed: () {
                            DatePicker.showDateTimePicker(context,
                                showTitleActions: true,
                                minTime: DateTime(2024, 1, 1),
                                maxTime: DateTime(2050, 12, 31),
                                currentTime: peminjamanDateTime,
                                locale: LocaleType.id,
                                theme: dtp.DatePickerTheme(
                                  doneStyle: const TextStyle(
                                    color: Color(0xFFFCA311),
                                  ),
                                ),
                                onChanged: (date) {}, onConfirm: (date) {
                              DateTime tomorrow =
                                  DateTime.now().add(Duration(days: 3));
                              DateTime startOfTomorrow = DateTime(
                                  tomorrow.year, tomorrow.month, tomorrow.day);
                              if (date.isBefore(startOfTomorrow)) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        'Tanggal peminjaman harus 3 hari setelah pengajuan.'),
                                  ),
                                );
                              } else if (_pengembalianController
                                      .text.isNotEmpty &&
                                  date.isAfter(pengembalianDateTime)) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        'Tanggal peminjaman tidak boleh sesudah tanggal akhir peminjaman.'),
                                  ),
                                );
                              } else {
                                setState(() {
                                  peminjamanDateTime = date;
                                  _peminjamanController.text =
                                      DateFormat('yyyy-MM-dd HH:mm')
                                          .format(date);
                                });
                              }
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const Gap(16),
                Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24),
                  child: Text(
                    'Tanggal dan Waktu Akhir Peminjaman',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ),
                const Gap(4),
                Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _pengembalianController,
                            readOnly: true,
                            cursorColor: Colors.black,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                            decoration: InputDecoration(
                              hintStyle: const TextStyle(
                                  color: Colors.black54,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w100),
                              hintText: 'Pilih tanggal akhir...',
                              border: InputBorder.none,
                              filled: false,
                              fillColor: Colors.white,
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
                        IconButton(
                          icon: const Icon(Icons.calendar_month),
                          onPressed: () {
                            DatePicker.showDateTimePicker(
                              context,
                              showTitleActions: true,
                              minTime: DateTime(2024, 1, 1),
                              maxTime: DateTime(2050, 12, 31),
                              currentTime: pengembalianDateTime,
                              locale: LocaleType.id,
                              theme: dtp.DatePickerTheme(
                                doneStyle: const TextStyle(
                                  color: Color(0xFFFCA311),
                                ),
                              ),
                              onChanged: (date) {},
                              onConfirm: (date) {
                                if (_peminjamanController.text.isNotEmpty &&
                                    date.isBefore(peminjamanDateTime)) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          'Tanggal akhir tidak boleh sebelum tanggal mulai.'),
                                    ),
                                  );
                                } else {
                                  setState(() {
                                    pengembalianDateTime = date;
                                    _pengembalianController.text =
                                        DateFormat('yyyy-MM-dd HH:mm')
                                            .format(date);
                                  });
                                }
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const Gap(16),
                Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24),
                  child: Text(
                    'Jumlah Penumpang',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ),
                Gap(4),
                Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: TextField(
                      controller: _jumlahPenumpangController,
                      cursorColor: Colors.black,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: InputDecoration(
                        hintStyle: const TextStyle(
                            color: Colors.black54,
                            fontSize: 12,
                            fontWeight: FontWeight.w100),
                        hintText: 'Masukan angka...',
                        border: InputBorder.none,
                        filled: false,
                        fillColor: Colors.white,
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
                ),
                Gap(16),
                Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24),
                  child: Text(
                    'Tujuan Peminjaman',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ),
                const Gap(4),
                Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: TextField(
                      controller: _tujuanController,
                      maxLines: 5,
                      cursorColor: Colors.black,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: InputDecoration(
                        hintStyle: const TextStyle(
                            color: Colors.black54,
                            fontSize: 12,
                            fontWeight: FontWeight.w100),
                        hintText: 'Masukan teks...',
                        border: InputBorder.none,
                        filled: false,
                        fillColor: Colors.white,
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
                ),
                Expanded(
                  child: Container(),
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
                    padding: const EdgeInsets.only(
                        left: 24, right: 24, bottom: 12, top: 12),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: FloatingActionButton(
                        backgroundColor: const Color(0xFFFCA311),
                        onPressed: () async {
                          if (_peminjamanController.text.isEmpty ||
                              _pengembalianController.text.isEmpty ||
                              _tujuanController.text.isEmpty ||
                              _jumlahPenumpangController.text.isEmpty ||
                              _tempatTujuanController.text.isEmpty) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Error'),
                                  content: Text('Harap isi semua kolom.'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text(
                                        'OK',
                                        style: TextStyle(
                                            color: Color(0xFFFCA311),
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          } else {
                            if (widget.category == 'kendaraan') {
                              DetailPeminjamans detailPeminjaman =
                                  await createDetailPeminjaman(
                                borrowedDate: peminjamanDateTime,
                                estimatedTime: pengembalianDateTime,
                                objective: _tujuanController.text,
                                destination: _tempatTujuanController.text,
                                passenger:
                                    int.parse(_jumlahPenumpangController.text),
                                status: 'pending',
                              );

                              var res = await createPeminjaman(
                                  detailPeminjaman.id,
                                  null,
                                  null,
                                  kendaraans.id,
                                  'kendaraan');

                              if (res == 200) {
                                WidgetsBinding.instance
                                    .addPostFrameCallback((_) {
                                  if (context.mounted) {
                                    context.pop();
                                  }
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content:
                                        Text('Peminjaman berhasil diajukan!'),
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        'Peminjaman gagal! coba lagi nanti'),
                                  ),
                                );
                              }
                            } else if (widget.category == 'draft') {
                              var res = await updateDetailPeminjaman(
                                int.parse(widget.id),
                                peminjamanDateTime,
                                pengembalianDateTime,
                                _tujuanController.text,
                                'pending',
                                _tempatTujuanController.text,
                                int.parse(_jumlahPenumpangController.text),
                              );

                              if (res) {
                                WidgetsBinding.instance
                                    .addPostFrameCallback((_) {
                                  if (context.mounted) {
                                    context.go('/beranda');
                                  }
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Peminjaman berhasil!'),
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        'Peminjaman gagal! coba lagi nanti'),
                                  ),
                                );
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Aset tidak valid!'),
                                ),
                              );
                            }
                          }
                        },
                        child: const Text(
                          'Ajukan Sekarang',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
