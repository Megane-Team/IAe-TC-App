import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class Beranda extends StatefulWidget {
  const Beranda({Key? key}) : super(key: key);

  @override
  State<Beranda> createState() => BerandaState();
}

class BerandaState extends State<Beranda> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.menu, size: 32, color: Colors.black54,),
                    onPressed: () {},
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Halo', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400)),
                      const Text('Maulana Yusuf', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              child: IconButton(
                icon: const Icon(Icons.notifications_outlined, size: 32,),
                onPressed: () {},
              ),
            )
          ],
        )
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 28),
                width: MediaQuery.of(context).size.width-48,
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
                    hintStyle: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400),
                    hintText: 'Cari barang...',
                    prefixIcon: const Icon(Icons.search),
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
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
              Gap(40),
              Container(
                width: MediaQuery.of(context).size.width-48,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("kategori", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                    Gap(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IntrinsicWidth(
                          child: Container(
                            child: ElevatedButton(
                              onPressed: () {},
                              child: const Text('Gedung', style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500)),
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                shadowColor: Colors.black,
                                elevation: 2
                              ),
                            ),
                          ),
                        ),
                        Gap(18),
                        IntrinsicWidth(
                          child: Container(
                            child: ElevatedButton(
                              onPressed: () {},
                              child: const Text('Parkiran', style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500)),
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                  shadowColor: Colors.black,
                                  elevation: 2
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Gap(40),
              Container(
                width: MediaQuery.of(context).size.width-48,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Asset", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                    Gap(20),
                    Container(
                      width: MediaQuery.of(context).size.width-48,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GridView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio: 3 / 2,
                            ),
                            itemCount: places.length,
                            itemBuilder: (context, index) {
                              return Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  image: DecorationImage(
                                    image: NetworkImage(places[index]['photo']!),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    color: Colors.black54,
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      places[index]['name']!,
                                      style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
                                    ),
                                  ),
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
      )
    );
  }
  List<Map<String, String>> places = [
    {
      'name': 'Central Park',
      'photo': 'image.png',
    },
    {
      'name': 'Eiffel Tower',
      'photo': 'image.png',
    },
    {
      'name': 'Great Wall of China',
      'photo': 'image.png',
    },
    {
      'name': 'Sydney Opera House',
      'photo': 'image.png',
    },
    {
      'name': 'Statue of Liberty',
      'photo': 'image.png',
    },
  ];
}