import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class Ruangan extends StatefulWidget {
  const Ruangan({Key? key}) : super(key: key);

  @override
  State<Ruangan> createState() => RuanganState();
}

class RuanganState extends State<Ruangan>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 247,
              decoration: const BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50)
                )
              ),
              child: Image.asset('assets/images/logos/inventara.png'),
            ),
            SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24, top: 8),
                  child: Column(
                    children: [
                      Row(
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
                              onPressed: () {},
                              icon: Icon(Icons.navigate_before),
                            ),
                          ),
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
                              onPressed: () {},
                              icon: Icon(Icons.search),
                            ),
                          ),
                        ],
                      ),
                      const Gap(110),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 4,
                              offset: const Offset(0, 0),
                            )
                          ]
                        ),
                      )
                    ],
                  ),
                ),
              )
            )
          ],
        ),
      )
    );
  }

}