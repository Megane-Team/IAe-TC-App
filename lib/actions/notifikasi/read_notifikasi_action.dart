import 'dart:convert';

import 'package:inventara/constants/variables.dart';
import 'package:inventara/main.dart';
import 'package:inventara/structures/notifikasi.dart';

Future<Notifikasi> readNotifikasi() async {
  final response = await App.api.get(apiBaseURl.resolve('/notifikasi'));

  if (response.statusCode == 200) {
    final Map<String, dynamic> responseData = jsonDecode(response.body);
    final Map<String, dynamic> data = responseData['data'];
    final Notifikasi notifikasi = Notifikasi.fromJson(data);

    return notifikasi;
  } else {
    throw Exception('Failed to get notifikasi. Is internet connection available?');
  }
}