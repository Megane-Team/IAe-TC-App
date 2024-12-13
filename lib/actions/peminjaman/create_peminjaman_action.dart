import 'dart:convert';

import 'package:inventara/constants/variables.dart';
import 'package:inventara/main.dart';
import 'package:inventara/utils/sessions.dart';

Future<int> createPeminjaman(
    int dpId, int? bId, int? rId, int? kId, String category) async {
  var token = await Session.getToken();

  var response = await App.api.post(apiBaseURl.resolve('/peminjaman'),
      headers: {'authorization': 'Bearer $token'},
      body: jsonEncode({
        'category': category,
        'ruanganId': rId,
        'barangId': bId,
        'kendaraanId': kId,
        'detailPeminjamanId': dpId,
      }));

  if (response.statusCode == 200) {
    return 200;
  } else if (response.statusCode == 429) {
    return 429;
  } else if (response.statusCode == 400) {
    return 400;
  } else {
    throw Exception(
        'Failed to create peminjaman. Is internet connection available?');
  }
}
