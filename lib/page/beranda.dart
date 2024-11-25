import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:inventara/actions/notifikasi/read_notifikasi_action.dart';
import 'package:inventara/actions/tempat/read_tempat_action.dart';
import 'package:inventara/structures/notifikasi.dart';
import 'package:inventara/structures/tempat.dart';
import 'package:inventara/structures/tempat_category.dart';
import 'package:inventara/utils/actionwidget.dart';
import 'package:inventara/utils/assets.dart';
import 'package:inventara/utils/sessions.dart';
import 'package:inventara/page/notifikasi.dart';

class Beranda extends StatefulWidget {
  const Beranda({super.key});

  @override
  State<Beranda> createState() => BerandaState();
}

var user = Session.get();

String getTime() {
  var timeNow = DateTime.now().hour;
  if (timeNow < 12) {
    return 'pagi';
  }
  if (timeNow < 17) {
    return 'siang';
  }
  return 'malam';
}

class BerandaState extends State<Beranda> {
  bool isGedungActive = false;
  bool isParkiranActive = false;
  late List<Tempat> filteredTempat;
  late List<Tempat> originalTempatList;
  late List<Notifikasis> notif;
  TextEditingController searchController = TextEditingController();

  void fetchData() async {
    var tempat = await readTempat('', context);
    notif = await readNotifikasi();
    setState(() {
      originalTempatList = tempat;
      filteredTempat = List.from(originalTempatList);
      _filterAndUpdateTempatList(searchController.text);
    });
  }

  void _filterAndUpdateTempatList(String value) {
    setState(() {
      if (isParkiranActive || isGedungActive) {
        filteredTempat = [];
        if (isGedungActive) {
          filteredTempat.addAll(originalTempatList
              .where((i) => i.category == TempatCategory.gedung)
              .where(
                  (e) => e.name.toLowerCase().contains(value.toLowerCase())));
        }
        if (isParkiranActive) {
          filteredTempat.addAll(originalTempatList
              .where((i) => i.category == TempatCategory.parkiran)
              .where(
                  (e) => e.name.toLowerCase().contains(value.toLowerCase())));
        }
      } else {
        filteredTempat = originalTempatList
            .where((element) =>
                element.name.toLowerCase().contains(value.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Selamat ${getTime()},',
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.w400)),
                Text(user!.name,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w500)),
              ],
            ),
            IconButton(
              icon: Stack(
                children: [
                  const Icon(
                    Icons.notifications_outlined,
                    size: 32,
                  ),
                  FutureBuilder(
                      future: readNotifikasi(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return const Text('Error');
                        } else if (snapshot.hasData) {
                          var notif = snapshot.data as List<Notifikasis>;
                          if (notif.isEmpty) {
                            return const SizedBox();
                          }
                          return Positioned(
                            right: 0,
                            top: 0,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                notif.length.toString(),
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                            ),
                          );
                        } else {
                          return const Text('No data');
                        }
                      }),
                ],
              ),
              onPressed: () async {
                context.push('/notifikasi');
              },
            )
          ],
        )),
        drawer: Drawer(
          child: ListView(
            padding: const EdgeInsets.only(top: 28),
            children: <Widget>[
              ListTile(
                onTap: () {
                  Navigator.pop(context);
                },
                leading: const Icon(
                  Icons.close,
                ),
                title: const Text('Menu',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.normal)),
              ),
              const Gap(20),
              const ListTile(
                leading: Icon(
                  Icons.shopping_cart_outlined,
                ),
                title: Text('Keranjang Peminjaman'),
              ),
              const ListTile(
                leading: Icon(
                  Icons.history,
                ),
                title: Text('Riwayat Peminjaman'),
              ),
              const Padding(
                  padding: EdgeInsets.only(left: 16, right: 16),
                  child: Divider(color: Colors.grey, thickness: 1)),
              ListTile(
                onTap: () {
                  Session.unset();
                  context.go('/login');
                },
                leading: const Icon(
                  Icons.logout,
                ),
                title: const Text('Keluar'),
              ),
            ],
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            fetchData();
          },
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 28),
                    width: MediaQuery.of(context).size.width - 48,
                    height: 50,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 4,
                          offset: const Offset(0, 0),
                        )
                      ],
                    ),
                    child: TextField(
                      controller: searchController,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        hintStyle: const TextStyle(
                            color: Colors.black54,
                            fontSize: 16,
                            fontWeight: FontWeight.w100),
                        hintText: 'Cari tempat...',
                        prefixIcon: const Icon(Icons.search),
                        border: InputBorder.none,
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 10.0),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onChanged: (value) {
                        _filterAndUpdateTempatList(value);
                      },
                    ),
                  ),
                  const Gap(40),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 48,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text("kategori",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500)),
                        const Gap(20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    isGedungActive = !isGedungActive;
                                    _filterAndUpdateTempatList(
                                        searchController.text);
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: isGedungActive
                                      ? Colors.orange
                                      : Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  shadowColor: Colors.black,
                                  elevation: 2,
                                ),
                                child: Text(
                                  'Gedung',
                                  style: TextStyle(
                                    color: isGedungActive
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )),
                            const Gap(18),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  isParkiranActive = !isParkiranActive;
                                  _filterAndUpdateTempatList(
                                      searchController.text);
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: isParkiranActive
                                    ? Colors.orange
                                    : Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                shadowColor: Colors.black,
                                elevation: 2,
                              ),
                              child: Text(
                                'Parkiran',
                                style: TextStyle(
                                  color: isParkiranActive
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  const Gap(40),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 48,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text("Asset",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500)),
                        const Gap(20),
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 48,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              FutureBuilder<List<Tempat>>(
                                future: readTempat('',
                                    context), // Your future function to fetch data
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const CircularProgressIndicator(); // Show a loading indicator while waiting
                                  } else if (snapshot.hasError) {
                                    return noData();
                                  } else if (snapshot.hasData) {
                                    if (snapshot.data!.isEmpty) {
                                      return noData();
                                    }
                                    return GridView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 24,
                                        mainAxisSpacing: 32,
                                      ),
                                      itemCount: filteredTempat.length,
                                      itemBuilder: (context, index) {
                                        var tempat = filteredTempat[index];
                                        return ElevatedButton(
                                          onPressed: () {
                                            setState(() {
                                              var param1 = tempat.id;

                                              if (tempat.category ==
                                                  TempatCategory.parkiran) {
                                                context.push(
                                                    "/ruangan?id=$param1&category=parkiran");
                                              } else {
                                                context
                                                    .push("/gedung?id=$param1");
                                              }
                                            });
                                          },
                                          style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            shadowColor:
                                                Colors.black.withOpacity(1),
                                            elevation: 4,
                                            padding: EdgeInsets.zero,
                                          ),
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: 106,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  child: FutureBuilder<Widget>(
                                                    future: Assets.tempat(
                                                        tempat.name),
                                                    builder:
                                                        (context, snapshot) {
                                                      if (snapshot
                                                              .connectionState ==
                                                          ConnectionState
                                                              .waiting) {
                                                        return const CircularProgressIndicator(); // Show a loading indicator while waiting
                                                      } else if (snapshot
                                                          .hasError) {
                                                        log("Error: ${snapshot.error}");
                                                        return Image.asset(Assets
                                                            .noImage()); // Show error message if any
                                                      } else if (snapshot
                                                          .hasData) {
                                                        return snapshot
                                                            .data!; // Return the widget once the future completes
                                                      } else {
                                                        return const Text(
                                                            'No data available'); // Show message if no data
                                                      }
                                                    },
                                                  ),
                                                ),
                                              ),
                                              const Gap(14),
                                              Text(
                                                tempat.name,
                                                style: const TextStyle(
                                                    color: Colors.black),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  } else {
                                    return noData();
                                  }
                                },
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
