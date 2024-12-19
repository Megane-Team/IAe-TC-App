import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';
import 'package:inventara/actions/users/read_user_action.dart';
import 'package:inventara/structures/user.dart';

class Session {
  static final store = Hive.box('session');
  static const secureStore = FlutterSecureStorage();

  static Future<User> set(String token) async {
    final user = await readUser(token);

    if (user == null) {
      throw Exception('Invalid token');
    }

    final timestamp = DateTime.now().millisecondsSinceEpoch;

    await secureStore.write(key: 'token', value: token);
    await store.put('user', user);
    await store.put('timestamp', timestamp);

    return user;
  }

  static Future<void> unset() async {
    await secureStore.delete(key: 'token');
    await store.delete('user');
    await store.delete('timestamp');
  }

  static User? get() {
    final timestamp = store.get('timestamp');
    if (timestamp == null ||
        DateTime.now().millisecondsSinceEpoch - timestamp > 86400000) {
      unset();
      return null;
    }
    return store.get('user');
  }

  static Future<User?> refresh() async {
    final token = await secureStore.read(key: 'token');

    if (token == null) return null;

    final user = await readUser(token);

    if (user == null) {
      return null;
    }

    var timestamp = store.get('timestamp');

    if (timestamp == null ||
        DateTime.now().millisecondsSinceEpoch - timestamp > 43200000) {
      unset();
      return null;
    }

    timestamp = DateTime.now().millisecondsSinceEpoch;
    await store.put('user', user);
    await store.put('timestamp', timestamp);

    return user;
  }

  static Future<String?> getToken() async {
    final timestamp = store.get('timestamp');
    if (timestamp == null ||
        DateTime.now().millisecondsSinceEpoch - timestamp > 86400000) {
      unset();
      return null;
    }
    return await secureStore.read(key: 'token');
  }
}
