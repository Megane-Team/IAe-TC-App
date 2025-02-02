import 'dart:convert';

import 'package:inventara/constants/variables.dart';
import 'package:inventara/main.dart';
import 'package:inventara/structures/detail_peminjaman.dart';
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

Future<bool> checkDetailPeminjamanItemsStatus() async {
  var token = await Session.getToken();

  var response = await App.api.get(
      apiBaseURl.resolve('/detailPeminjaman/checkItemsStatus'),
      headers: {'Authorization': 'Bearer $token'});

  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}

Future<List<DetailPeminjamans>> readAllDetailPeminjamansbyBarangId(
    int id) async {
  var token = await Session.getToken();

  var response = await App.api.get(
      apiBaseURl.resolve('/detailPeminjaman/all/barang/$id'),
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

Future<List<DetailPeminjamans>> readAllDetailPeminjamansbyRuanganId(
    int id) async {
  var token = await Session.getToken();

  var response = await App.api.get(
      apiBaseURl.resolve('/detailPeminjaman/all/ruangan/$id'),
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

Future<List<DetailPeminjamans>> readAllDetailPeminjamansbyKendaraanId(
    int id) async {
  var token = await Session.getToken();

  var response = await App.api.get(
      apiBaseURl.resolve('/detailPeminjaman/all/kendaraan/$id'),
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

Future<List<DetailPeminjamans>> readAllDetailPeminjamansbyDraftId(
    int id) async {
  var token = await Session.getToken();

  var response = await App.api.get(
      apiBaseURl.resolve('/detailPeminjaman/all/draft/$id'),
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
