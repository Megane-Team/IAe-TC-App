import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:inventara/constants/themes.dart';
import 'package:inventara/router.dart';
import 'package:inventara/structures/barang.dart';
import 'package:inventara/structures/kendaraan.dart';
import 'package:inventara/structures/kendaraan_category.dart';
import 'package:inventara/structures/notifikasi_category.dart';
import 'package:inventara/structures/notifikasi.dart';
import 'package:inventara/structures/peminjaman.dart';
import 'package:inventara/structures/peminjaman_category.dart';
import 'package:inventara/structures/peminjaman_status.dart';
import 'package:inventara/structures/role.dart';
import 'package:inventara/structures/ruangan.dart';
import 'package:inventara/structures/ruangan_category.dart';
import 'package:inventara/structures/tempat.dart';
import 'package:inventara/structures/tempat_category.dart';
import 'package:inventara/structures/user.dart';
import 'package:inventara/utils/http.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) return;
  var appDir = await getApplicationSupportDirectory();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  Hive.init(appDir.path);

  Hive.registerAdapter(RoleAdapter());
  Hive.registerAdapter(TempatAdapter());
  Hive.registerAdapter(TempatCategoryAdapter());
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(RuangansAdapter());
  Hive.registerAdapter(RuanganCategoryAdapter());
  Hive.registerAdapter(BarangAdapter());
  Hive.registerAdapter(PeminjamanAdapter());
  Hive.registerAdapter(PeminjamanStatusAdapter());
  Hive.registerAdapter(PeminjamanCategoryAdapter());
  Hive.registerAdapter(KendaraanAdapter());
  Hive.registerAdapter(KendaraanCategoryAdapter());
  Hive.registerAdapter(NotifikasisAdapter());
  Hive.registerAdapter(NotifikasiCategoryAdapter());

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
