import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';

class ApiClient extends http.BaseClient {
  final http.Client _inner;

  ApiClient(this._inner);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    final packageInfo = await PackageInfo.fromPlatform();
    request.headers['user-agent'] =
        '${packageInfo.appName}/${packageInfo.version} (${Platform.operatingSystem}/${Platform.operatingSystemVersion})';
    request.headers['accept'] = 'application/json';
    request.headers['content-type'] = 'application/json';
    return _inner.send(request);
  }
}
