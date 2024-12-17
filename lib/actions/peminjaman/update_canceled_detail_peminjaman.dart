import 'dart:convert';

import 'package:inventara/constants/variables.dart';
import 'package:inventara/main.dart';
import 'package:inventara/utils/sessions.dart';

Future<bool> updateCanceledDetailPeminjaman(
    int id, String canceledReason) async {
  var token = await Session.getToken();

  var response = await App.api.patch(
      apiBaseURl.resolve('/detailPeminjaman/canceled'),
      body: jsonEncode({'id': id, 'canceledReason': canceledReason}),
      headers: {'authorization': 'Bearer $token'});

  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}
