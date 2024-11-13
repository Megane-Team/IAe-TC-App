import 'package:flutter/material.dart';
import 'package:inventara/constants/variables.dart';
import 'package:inventara/main.dart';
import 'package:inventara/utils/sessions.dart';

class Assets {
  static const path = 'assets/images';

  static String logos(String name) {
    return '$path/logos/$name.png';
  }

  static String icons(String name) {
    return '$path/icons/$name.png';
  }

  static Future<Widget> tempat(String name) async {
    final token = await Session.getToken();

    try {
      final response = await App.api.get(
        apiBaseURl.resolve('photoFiles/tempat/$name'),
        headers: {'authorization': 'Bearer $token'},
      );

      if (response.statusCode == 404) {
        return Image.asset(Assets.icons('no_image'));
      }

      return Image.network(
        apiBaseURl.resolve('photoFiles/tempat/$name').toString(),
        headers: {'authorization': 'Bearer $token'},
        fit: BoxFit.fill,
      );
    } catch (e) {
      return Image.asset(Assets.icons('no_image'));
    }
  }

  static Future<Widget> ruangan(String name) async {
    final token = await Session.getToken();

    try {
      final response = await App.api.get(
        apiBaseURl.resolve('photoFiles/ruangan/$name'),
        headers: {'authorization': 'Bearer $token'},
      );

      if (response.statusCode == 404) {
        return Image.asset(Assets.icons('no_image'));
      }

      return Image.network(
        apiBaseURl.resolve('photoFiles/ruangan/$name').toString(),
        headers: {'authorization': 'Bearer $token'},
        fit: BoxFit.fill,
      );
    } catch (e) {
      return Image.asset(Assets.icons('no_image'));
    }
  }
}
