import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:inventara/page/login.dart';

class Beranda extends StatefulWidget {
  const Beranda({super.key});

  @override
  State<Beranda> createState() => BerandaState();
}

class BerandaState extends State<Beranda> {
  bool isGedungActive = false;
  bool isParkiranActive = false;
  List<Map<String, String>> originalPlaces = [];

  @override
  void initState() {
    super.initState();
    originalPlaces = List.from(places);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Halo',
                    style:
                        TextStyle(fontSize: 12, fontWeight: FontWeight.w400)),
                Text('Maulana Yusuf',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
              ],
            ),
            IconButton(
              icon: const Icon(
                Icons.notifications_outlined,
                size: 32,
              ),
              onPressed: () {},
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Login()),
                  );
                },
                leading: const Icon(
                  Icons.logout,
                ),
                title: const Text('Keluar'),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
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
                                  if (isGedungActive) {
                                    places = List.from(originalPlaces);
                                  } else {
                                    places.sort((a, b) => a['kategori']!
                                        .compareTo(b['kategori']!));
                                  }
                                  isGedungActive = !isGedungActive;
                                  isParkiranActive = false;
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
                                if (isParkiranActive) {
                                  places = List.from(originalPlaces);
                                } else {
                                  places.sort((a, b) =>
                                      b['kategori']!.compareTo(a['kategori']!));
                                }
                                isParkiranActive = !isParkiranActive;
                                isGedungActive = false;
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
                            GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 40,
                                mainAxisSpacing: 32,
                              ),
                              itemCount: places.length,
                              itemBuilder: (context, index) {
                                return ElevatedButton(
                                  onPressed: () {
                                    // Add your onPressed functionality here
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    shadowColor: Colors.black.withOpacity(1),
                                    elevation: 4,
                                    padding: EdgeInsets.zero,
                                  ),
                                  child: Column(
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 106,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          color: Colors.black,
                                        ),
                                        child: Image.asset(
                                            places[index]['photo']!),
                                      ),
                                      const Gap(14),
                                      Text(
                                        places[index]['name']!,
                                        style: const TextStyle(
                                            color: Colors.black),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }

  List<Map<String, String>> places = [
    {
      'name': 'Gedung 1',
      'photo': 'assets/images/logos/inventara.png',
      'kategori': 'gedung'
    },
    {
      'name': 'Gedung 2',
      'photo': 'assets/images/logos/inventara.png',
      'kategori': 'gedung'
    },
    {
      'name': 'Gedung 3',
      'photo': 'assets/images/logos/inventara.png',
      'kategori': 'gedung'
    },
    {
      'name': 'Gedung 4',
      'photo': 'assets/images/logos/inventara.png',
      'kategori': 'gedung'
    },
    {
      'name': 'Gedung 5',
      'photo': 'assets/images/logos/inventara.png',
      'kategori': 'gedung'
    },
    {
      'name': 'Parkiran 3',
      'photo': 'assets/images/logos/inventara.png',
      'kategori': 'parkiran'
    },
    {
      'name': 'Parkiran 2',
      'photo': 'assets/images/logos/inventara.png',
      'kategori': 'parkiran'
    },
    {
      'name': 'Parkiran 1',
      'photo': 'assets/images/logos/inventara.png',
      'kategori': 'parkiran'
    },
  ];
}
