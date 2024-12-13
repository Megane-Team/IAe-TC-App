import 'dart:convert';

import 'package:inventara/constants/variables.dart';
import 'package:inventara/main.dart';
import 'package:inventara/utils/sessions.dart';

Future<bool> updateReturnedDetailPeminjaman(int id) async {
  var token = await Session.getToken();

  var response = await App.api.patch(
      apiBaseURl.resolve('/detailPeminjaman/returned'),
      body: jsonEncode({'id': id}),
      headers: {'authorization': 'Bearer $token'});

  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}
