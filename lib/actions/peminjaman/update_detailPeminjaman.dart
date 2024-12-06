import 'dart:convert';

import 'package:inventara/constants/variables.dart';
import 'package:inventara/main.dart';
import 'package:inventara/structures/detailPeminjaman.dart';
import 'package:inventara/utils/sessions.dart';

Future<bool> updateDetailPeminjaman(
    int id,
    DateTime? borrowedDate,
    DateTime? estimatedTime,
    String? objective,
    String? status,
    String? destination,
    int? passenger) async {
  var token = await Session.getToken();

  var response =
      await App.api.patch(apiBaseURl.resolve('/detailPeminjaman/$id'),
          headers: {'authorization': 'Bearer $token'},
          body: jsonEncode({
            'borrowedDate': borrowedDate?.toIso8601String(),
            'estimatedTime': estimatedTime?.toIso8601String(),
            'objective': objective,
            'status': status,
            'destination': destination,
            'passenger': passenger
          }));

  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}
