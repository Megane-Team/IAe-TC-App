import 'dart:convert';

import 'package:http/http.dart';
import 'package:inventara/constants/variables.dart';
import 'package:inventara/main.dart';
import 'package:inventara/structures/detail_peminjaman.dart';
import 'package:inventara/utils/sessions.dart';

Future<DetailPeminjamans> createDetailPeminjaman(
    {DateTime? borrowedDate,
    DateTime? estimatedTime,
    String? objective,
    required String status,
    String? destination,
    int? passenger}) async {
  var token = await Session.getToken();
  late Response response;

  if (status == 'pending') {
    response =
        await App.api.post(apiBaseURl.resolve('/detailPeminjaman/$status'),
            headers: {'authorization': 'Bearer $token'},
            body: jsonEncode({
              'borrowedDate': borrowedDate?.toIso8601String(),
              'estimatedTime': estimatedTime?.toIso8601String(),
              'objective': objective,
              'status': status,
              'destination': destination,
              'passenger': passenger
            }));
  } else if (status == 'draft') {
    response =
        await App.api.post(apiBaseURl.resolve('/detailPeminjaman/$status'),
            headers: {'authorization': 'Bearer $token'},
            body: jsonEncode({
              'borrowedDate': borrowedDate?.toIso8601String(),
              'estimatedTime': estimatedTime?.toIso8601String(),
              'objective': objective,
              'status': status,
              'destination': destination,
              'passenger': passenger
            }));
  }

  if (response.statusCode == 200) {
    final Map<String, dynamic> responseData = jsonDecode(response.body);
    final Map<String, dynamic> data = responseData['data'];
    return DetailPeminjamans.fromJson(data);
  } else {
    throw Exception(
        'Failed to create detailPeminjaman. Is internet connection available?');
  }
}
