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

          ],
        ),
      )
    );
  }

}