import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:inventara/utils/assets.dart';

Column noData() {
  return Column(
    children: [
      const Gap(32),
      Center(
          child: Image.asset(
        Assets.noData(),
        width: 75,
      )),
      const Gap(12),
      const Center(
          child: Text(
        'Tidak ada data yang tersedia!\n'
        'Coba cek jaringanmu!',
        textAlign: TextAlign.center,
      ))
    ],
  );
}
