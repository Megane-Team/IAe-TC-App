import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:inventara/constants/themes.dart';
import 'package:inventara/router.dart';
import 'package:inventara/structures/role.dart';
import 'package:inventara/structures/tempat.dart';
import 'package:inventara/structures/tempat_category.dart';
import 'package:inventara/structures/user.dart';
import 'package:inventara/utils/http.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) return;
  var appDir = await getApplicationSupportDirectory();
  Hive.init(appDir.path);

  Hive.registerAdapter(RoleAdapter());
  Hive.registerAdapter(TempatAdapter());
  Hive.registerAdapter(TempatCategoryAdapter());
  Hive.registerAdapter(UserAdapter());

  await Hive.openBox('session', compactionStrategy: (int total, int deleted) {
    return deleted > 10;
  });

  runApp(const App());
}

class App extends StatelessWidget {
  static final api = ApiClient(http.Client());

  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Inventara',
      routerConfig: appRouter,
      theme: mainTheme,
    );
  }
}
