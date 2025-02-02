import 'dart:convert';

import 'package:inventara/constants/variables.dart';
import 'package:inventara/main.dart';
import 'package:inventara/structures/peminjaman.dart';
import 'package:inventara/utils/sessions.dart';

Future<List<Peminjaman>> readPeminjaman(String? id) async {
  var token = await Session.getToken();
  var response = await App.api.get(apiBaseURl.resolve('/peminjaman/$id'),
      headers: {'Authorization': 'Bearer $token'});

  if (response.statusCode == 200) {
    final Map<String, dynamic> responseData = jsonDecode(response.body);
    final List<dynamic> data = responseData['data'];
    final List<Peminjaman> peminjaman =
        data.map((item) => Peminjaman.fromJson(item)).toList();

    return peminjaman;
  } else if (response.statusCode == 404) {
    return [];
  } else {
    throw Exception(
        'Failed to get peminjaman. Is internet connection available?');
  }
}

Future<List<Peminjaman>> readDraftPeminjaman() async {
  var token = await Session.getToken();

  var response = await App.api.get(apiBaseURl.resolve('/peminjaman/draft'),
      headers: {'Authorization': 'Bearer $token'});

  if (response.statusCode == 200) {
    final Map<String, dynamic> responseData = jsonDecode(response.body);
    final List<dynamic> data = responseData['data'];
    final List<Peminjaman> peminjaman =
        data.map((item) => Peminjaman.fromJson(item)).toList();

    return peminjaman;
  } else if (response.statusCode == 404) {
    return [];
  } else {
    throw Exception(
        'Failed to get draft peminjaman. Is internet connection available?');
  }
}

Future<List<Peminjaman>> readPeminjamanbyDetailId(int id) async {
  var token = await Session.getToken();

  var response = await App.api.get(
      apiBaseURl.resolve('/detailPeminjaman/$id/peminjaman'),
      headers: {'Authorization': 'Bearer $token'});

  if (response.statusCode == 200) {
    final Map<String, dynamic> responseData = jsonDecode(response.body);
    final List<dynamic> data = responseData['data'];
    final List<Peminjaman> peminjaman =
        data.map((item) => Peminjaman.fromJson(item)).toList();

    return peminjaman;
  } else if (response.statusCode == 404) {
    return [];
  } else {
    throw Exception(
        'Failed to get peminjaman. Is internet connection available?');
  }
}

Future<Peminjaman?> readPeminjamanbyRuanganId(int id) async {
  var token = await Session.getToken();

  var response = await App.api.get(
      apiBaseURl.resolve('/peminjaman/ruangan/$id'),
      headers: {'Authorization': 'Bearer $token'});

  if (response.statusCode == 200) {
    final Map<String, dynamic> responseData = jsonDecode(response.body);
    final Map<String, dynamic> data = responseData['data'];
    return Peminjaman.fromJson(data);
  } else if (response.statusCode == 404) {
    return null;
  } else {
    throw Exception(
        'Failed to get draft peminjaman. Is internet connection available?');
  }
}

Future<Peminjaman?> readPeminjamanbyBarangId(int id) async {
  var token = await Session.getToken();

  var response = await App.api.get(apiBaseURl.resolve('/peminjaman/barang/$id'),
      headers: {'Authorization': 'Bearer $token'});

  if (response.statusCode == 200) {
    final Map<String, dynamic> responseData = jsonDecode(response.body);
    final Map<String, dynamic> data = responseData['data'];
    return Peminjaman.fromJson(data);
  } else if (response.statusCode == 404) {
    return null;
  } else {
    throw Exception(
        'Failed to get draft peminjaman. Is internet connection available?');
  }
}

Future<Peminjaman?> readPeminjamanbyKendaraanId(int id) async {
  var token = await Session.getToken();

  var response = await App.api.get(
      apiBaseURl.resolve('/peminjaman/kendaraan/$id'),
      headers: {'Authorization': 'Bearer $token'});

  if (response.statusCode == 200) {
    final Map<String, dynamic> responseData = jsonDecode(response.body);
    final Map<String, dynamic> data = responseData['data'];
    return Peminjaman.fromJson(data);
  } else if (response.statusCode == 404) {
    return null;
  } else {
    throw Exception(
        'Failed to get draft peminjaman. Is internet connection available?');
  }
}
