import 'dart:convert';

import 'package:inventara/constants/variables.dart';
import 'package:inventara/main.dart';
import 'package:inventara/structures/detailPeminjaman.dart';
import 'package:inventara/utils/sessions.dart';

Future<List<DetailPeminjamans>> readDetailPeminjaman() async {
  var token = await Session.getToken();

  var response = await App.api.get(apiBaseURl.resolve('/detailPeminjaman'),
      headers: {'Authorization': 'Bearer $token'});

  if (response.statusCode == 200) {
    final Map<String, dynamic> responseData = jsonDecode(response.body);
    final List<dynamic> data = responseData['data'];
    final List<DetailPeminjamans> detailPeminjaman =
        data.map((item) => DetailPeminjamans.fromJson(item)).toList();

    return detailPeminjaman;
  } else if (response.statusCode == 404) {
    return [];
  } else {
    throw Exception(
        'Failed to get detail peminjaman. Is internet connection available?');
  }
}

Future<DetailPeminjamans?> readDetailPeminjamanbyId(int id) async {
  var token = await Session.getToken();

  var response = await App.api.get(apiBaseURl.resolve('/detailPeminjaman/$id'),
      headers: {'Authorization': 'Bearer $token'});

  if (response.statusCode == 200) {
    final Map<String, dynamic> responseData = jsonDecode(response.body);
    final Map<String, dynamic> data = responseData['data'];
    return DetailPeminjamans.fromJson(data);
  } else if (response.statusCode == 404) {
    return null;
  } else {
    throw Exception(
        'Failed to get detail peminjaman. Is internet connection available?');
  }
}
