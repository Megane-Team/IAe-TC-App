// make a code that return the Image.network widget
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:inventara/constants/variables.dart';

Future<Widget> tempatPhoto(String name) async {
  const secureStorage = FlutterSecureStorage();
  var token = await secureStorage.read(key: 'token');

  return Image.network(
    apiBaseURl.resolve('/photoFiles/tempat/$name').toString(),
    headers: {'authorization': 'Bearer $token'},
    fit: BoxFit.fill,
  );
}