import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:gap/gap.dart';
import 'package:inventara/actions/notifikasi/read_notifikasi_action.dart';
import 'package:inventara/actions/notifikasi/update_notifikasi_action.dart';
import 'package:inventara/structures/notifikasi.dart';
import 'package:inventara/structures/notifikasi_category.dart';
import 'package:inventara/utils/actionwidget.dart';

class Notifikasi extends StatefulWidget {
  final VoidCallback onRefresh;

  const Notifikasi({super.key, required this.onRefresh});

  @override
  State<Notifikasi> createState() => _NotifikasiState();
}

class _NotifikasiState extends State<Notifikasi> {
  late List<Notifikasis> listNotif = [];

  String getNotificationMessage(NotifikasiCategory kategori) {
    switch (kategori) {
      case NotifikasiCategory.PB:
        return 'Kamu berhasil mengajukan peminjaman!';
      case NotifikasiCategory.PD:
        return 'Peminjaman mu telah di konfirmasi!';
      case NotifikasiCategory.PG:
        return 'Pengajuan peminjaman mu gagal coba lagi nanti!';
      case NotifikasiCategory.PDB:
        return 'Kamu berhasil membatalkan pengajuan peminjamanmu!';
      case NotifikasiCategory.PDT:
        return 'Pengajuan peminjaman mu ditolak!';
      case NotifikasiCategory.JT:
        return 'Peminjaman mu sebentar lagi berakhir jangan lupa untuk mengembalikanya!';
      case NotifikasiCategory.DO:
        return 'Pengajuan peminjaman telah dibatalkan secara otomatis!';
      default:
        return 'Notifikasi tidak dikenal';
    }
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
                    setState(() {
                      widget.onRefresh();
                      context.pop();
                    });
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
            child: FutureBuilder(
              future: readNotifikasi(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator(); // Show a loading indicator while waiting
                } else if (snapshot.hasError) {
                  return noData();
                } else if (snapshot.hasData) {
                  if (snapshot.data!.isEmpty) {
                    return SizedBox();
                  }
                  listNotif = snapshot.data!;

                  listNotif.sort((a, b) {
                    if (a.isRead == b.isRead) {
                      return b.createdAt.compareTo(a.createdAt);
                    } else if (!a.isRead && b.isRead) {
                      return -1;
                    } else {
                      return 1;
                    }
                  });
                  return ListView.builder(
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
                            if (notif.isRead == false) {
                              updateNotifikasi(notif.id);
                              setState(() {
                                readNotifikasi().then((newList) {
                                  setState(() {
                                    listNotif = newList;
                                  });
                                });
                              });
                            }
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
                            padding: const EdgeInsets.only(
                                right: 24, top: 20, bottom: 20),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                              DateFormat('dd MMM yyyy')
                                                  .format(notif.createdAt),
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black)),
                                          Text(
                                              DateFormat('HH:mm')
                                                  .format(notif.createdAt),
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black)),
                                        ],
                                      ),
                                      const Gap(12),
                                      Text(
                                          getNotificationMessage(
                                              notif.category),
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black)),
                                      const Gap(16),
                                      TextButton(
                                        onPressed: () {
                                          context.push(
                                              '/DetailP?id=${notif.detailPeminjamanId}');
                                        },
                                        style: TextButton.styleFrom(
                                          padding: EdgeInsets.zero,
                                        ),
                                        child: const Text(
                                          'Klik disini untuk melihat detail',
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
                return const SizedBox();
              },
            )));
  }
}
