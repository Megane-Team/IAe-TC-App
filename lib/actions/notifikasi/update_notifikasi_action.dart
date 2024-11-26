import 'package:inventara/constants/variables.dart';
import 'package:inventara/main.dart';
import 'package:inventara/utils/sessions.dart';

void updateNotifikasi(int id) async {
  var token = await Session.getToken();
  await App.api.get(
      apiBaseURl.resolve('notifikasi/updateRead/$id'),
      headers: {'authorization': 'Bearer $token'});
}
