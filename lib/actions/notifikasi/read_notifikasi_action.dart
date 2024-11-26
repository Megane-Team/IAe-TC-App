import 'dart:convert';

import 'package:inventara/constants/variables.dart';
import 'package:inventara/main.dart';
import 'package:inventara/structures/notifikasi.dart';
import 'package:inventara/utils/sessions.dart';

Future<List<Notifikasis>> readNotifikasi() async {
  print('readNotifikasi triggered');
  final token = await Session.getToken();

  final response = await App.api.get(apiBaseURl.resolve('/notifikasi'),
      headers: {'authorization': 'Bearer $token'});

  if (response.statusCode == 200) {
    final Map<String, dynamic> responseData = jsonDecode(response.body);
    final List<dynamic> data = responseData['data'];
    final List<Notifikasis> notifikasis =
        data.map((item) => Notifikasis.fromJson(item)).toList();

    return notifikasis;
  } else {
    throw Exception(
        'Failed to get notifikasi. Is internet connection available?');
  }
}
