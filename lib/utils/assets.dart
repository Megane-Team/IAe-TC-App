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

  static String noImage() {
    return '$path/icons/no_image.png';
  }

  static String noData() {
    return '$path/icons/no_data.png';
  }

  static Future<Widget> tempat(String name) async {
    if (name == '') {
      return Image.asset(Assets.noImage());
    }

    final token = await Session.getToken();

    try {
      final response = await App.api.get(
        apiBaseURl.resolve('photoFiles/tempat/$name'),
        headers: {'authorization': 'Bearer $token'},
      );

      if (response.statusCode == 404) {
        return Image.asset(Assets.noImage());
      }

      return Image.network(
        apiBaseURl.resolve('photoFiles/tempat/$name').toString(),
        headers: {'authorization': 'Bearer $token'},
        fit: BoxFit.fill,
      );
    } catch (e) {
      return Image.asset(Assets.noImage());
    }
  }

  static Future<Widget> ruangan(String name) async {
    if (name == '') {
      return Image.asset(Assets.noImage());
    }

    final token = await Session.getToken();

    try {
      final response = await App.api.get(
        apiBaseURl.resolve('photoFiles/ruangan/$name'),
        headers: {'authorization': 'Bearer $token'},
      );

      if (response.statusCode == 404) {
        return Image.asset(Assets.noImage());
      }

      return Image.network(
        apiBaseURl.resolve('photoFiles/ruangan/$name').toString(),
        headers: {'authorization': 'Bearer $token'},
        fit: BoxFit.fill,
      );
    } catch (e) {
      return Image.asset(Assets.noImage());
    }
  }

  static Future<Widget> barang(String name) async {
    if (name == '') {
      return Image.asset(Assets.noImage());
    }

    final token = await Session.getToken();

    try {
      final response = await App.api.get(
        apiBaseURl.resolve('photoFiles/barang/$name'),
        headers: {'authorization': 'Bearer $token'},
      );

      if (response.statusCode == 404) {
        return Image.asset(Assets.noImage());
      }

      return Image.network(
        apiBaseURl.resolve('photoFiles/barang/$name').toString(),
        headers: {'authorization': 'Bearer $token'},
        fit: BoxFit.fill,
      );
    } catch (e) {
      return Image.asset(Assets.noImage());
    }
  }

  static Future<Widget> kendaraan(String name) async {
    if (name == '') {
      return Image.asset(Assets.noImage());
    }

    final token = await Session.getToken();

    try {
      final response = await App.api.get(
        apiBaseURl.resolve('photoFiles/kendaraan/$name'),
        headers: {'authorization': 'Bearer $token'},
      );

      if (response.statusCode == 404) {
        return Image.asset(Assets.noImage());
      }

      return Image.network(
        apiBaseURl.resolve('photoFiles/kendaraan/$name').toString(),
        headers: {'authorization': 'Bearer $token'},
        fit: BoxFit.fill,
      );
    } catch (e) {
      return Image.asset(Assets.noImage());
    }
  }
}
