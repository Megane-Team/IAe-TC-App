import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:inventara/actions/tempat/read_tempat_action.dart';
import 'package:inventara/structures/tempat.dart';
import 'package:inventara/utils/assets.dart';
import 'package:inventara/utils/sessions.dart';

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

  late List<Tempat> tempatList;

  void fetchData() async {
    List<Tempat> allTempat = await readTempat();
    setState(() {
      tempatList = allTempat;
      listSort(tempatList);
    });
  }

  void listSort(List<Tempat> list) async {
    if (isParkiranActive == true) {
      tempatList.sort(
          (a, b) => b.category.toString().compareTo(a.category.toString()));
    } else if (isGedungActive == true) {
      tempatList.sort(
          (a, b) => a.category.toString().compareTo(b.category.toString()));
    } else {
      tempatList = list;
    }
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
              icon: const Icon(
                Icons.notifications_outlined,
                size: 32,
              ),
              onPressed: () async {},
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
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        hintStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                        hintText: 'Cari barang...',
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
                                    if (isParkiranActive = true) {
                                      isParkiranActive = false;
                                    }
                                    listSort(tempatList);
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
                                  if (isGedungActive = true) {
                                    isGedungActive = false;
                                  }
                                  listSort(tempatList);
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(100, 50),
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
                                future:
                                    readTempat(), // Your future function to fetch data
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const CircularProgressIndicator(); // Show a loading indicator while waiting
                                  } else if (snapshot.hasError) {
                                    print(snapshot.error);
                                    return const Center(
                                      child: Text(
                                          'Error: No data available, is internet connection available?'),
                                    );
                                  } else if (snapshot.hasData) {
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
                                      itemCount: tempatList.length,
                                      itemBuilder: (context, index) {
                                        return ElevatedButton(
                                          onPressed: () {
                                            setState(() {
                                              var param1 = tempatList[index].id;
                                              var param2 = tempatList[index].name;
                                              context.go("/gedung?id=$param1&name=$param2");
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
                                              Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: 106,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  color: Colors.black,
                                                ),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  child: FutureBuilder<Widget>(
                                                    future: Assets().tempat(
                                                        tempatList[index].name),
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
                                                        return const Text(
                                                            'Error: Error while getting the data'); // Show error message if any
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
                                                tempatList[index].name,
                                                style: const TextStyle(
                                                    color: Colors.black),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  } else {
                                    return const Text(
                                        'No data available');
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
