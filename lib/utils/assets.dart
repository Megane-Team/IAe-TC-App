import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:inventara/constants/variables.dart';


class Assets {
  static const path = 'assets/images';

  static String logos(String name) {
    return '$path/logos/$name.png';
  }

  static String icons(String name) {
    return '$path/icons/$name.png';
  }

  Future<Widget> tempat(String name) async {
    const secureStorage = FlutterSecureStorage();
    var token = await secureStorage.read(key: 'token');

    return Image.network(
      apiBaseURl.resolve('/photoFiles/tempat/$name').toString(),
      headers: {'authorization': 'Bearer $token'},
      fit: BoxFit.fill,
    );
  }
}