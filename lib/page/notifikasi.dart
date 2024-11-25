import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:gap/gap.dart';
import 'package:inventara/actions/notifikasi/read_notifikasi_action.dart';
import 'package:inventara/structures/notifikasi.dart';

class Notifikasi extends StatefulWidget {
  const Notifikasi({super.key});

  @override
  State<Notifikasi> createState() => _NotifikasiState();

  static bool hasUnreadNotifications(List<Notifikasis> notifications) {
    return notifications.any((notif) => notif.isRead == false);
  }
}

class _NotifikasiState extends State<Notifikasi> {
  late List<Notifikasis> listNotif;

  String getNotificationMessage(String kategori) {
    switch (kategori) {
      case 'PB':
        return 'Kamu berhasil mengajukan peminjaman!';
      case 'DK':
        return 'Peminjaman mu telah di konfirmasi!';
      case 'PG':
        return 'Pengajuan peminjaman mu gagal coba lagi nanti!';
      case 'PDB':
        return 'Kamu berhasil membatalkan pengajuan peminjamanmu!';
      case 'PDT':
        return 'Pengajuan peminjaman mu ditolak!';
      case 'JT':
        return 'Peminjaman mu sebentar lagi berakhir jangan lupa untuk mengembalikanya!';
      case 'DO':
        return 'Pengajuan peminjaman telah dibatalkan secara otomatis!';
      default:
        return 'Notifikasi tidak dikenal';
    }
  }

  void fetchData() async {
    final notifikasis = await readNotifikasi();
    setState(() {
      listNotif = notifikasis;
    });

  }

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
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.navigate_before, color: Colors.black),
                ),
              ),
              const Text(
                'Notifikasi',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              const Gap(40),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 16),
          child: ListView.builder(
            itemCount: listNotif.length,
            itemBuilder: (context, index) {
              var notif = listNotif[index];
              return Container(
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Colors.black38,
                    ),
                  ),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      notif.isRead = true;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    elevation: 0,
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(right: 24, top: 20, bottom: 30),
                    child: Row(
                      children: [
                        const Gap(6),
                        if (!notif.isRead)
                          Container(
                            width: 10,
                            height: 10,
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                          )
                        else
                          const Gap(10),
                        const Gap(6),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      DateFormat('dd MMM yyyy')
                                          .format(notif.createdAt),
                                      style: const TextStyle(
                                          fontSize: 12, color: Colors.black)),
                                  Text(
                                      DateFormat('HH:mm')
                                          .format(notif.createdAt),
                                      style: const TextStyle(
                                          fontSize: 12, color: Colors.black)),
                                ],
                              ),
                              const Gap(12),
                              Text(getNotificationMessage(notif.category.toString()),
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black)),
                              const Gap(16),
                              const Text('Klik untuk detail peminjaman',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ));
  }
}
