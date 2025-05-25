import 'package:first_project/features/login/model/login_response_mode.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalDatabase {
  static LocalDatabase? _instance;
  static FlutterSecureStorage? _storage;

  static LocalDatabase? get instance {
    if (_instance == null) {
      LocalDatabase._init();
    }
    return _instance!;
  }

  LocalDatabase._init() {
    _instance = this;
    _storage = const FlutterSecureStorage();
  }
  static dispose() {
    _instance == null;
  }

  Future<String?> getEmail() async {
    return _storage?.read(key: 'email');
  }

  Future<void> setEmail(String email) async {
    await _storage?.write(key: 'email', value: email);
  }

  Future<String?> getUserName() async {
    return _storage?.read(key: 'username');
  }

  Future<void> setUserName(String username) async {
    await _storage?.write(key: 'username', value: username);
  }

  Future<String?> getUid() async {
    return _storage?.read(key: 'uid');
  }

  Future<void> setUid(String uid) async {
    await _storage?.write(key: 'uid', value: uid);
  }

  Future<String?> getPhon() async {
    return _storage?.read(key: 'phone');
  }

  Future<void> setPhone(String phone) async {
    await _storage?.write(key: 'phone', value: phone);
  }

  Future<void> removAll() async {
    await _storage?.deleteAll();
  }

  Future<void> setUserData(LoginResponseMode loginResponseMode) async {
    await setEmail(loginResponseMode.email ?? '');
    await setPhone(loginResponseMode.phone ?? '');
    await setUid(loginResponseMode.uid ?? '');
    await setUserName(loginResponseMode.username ?? '');
  }

  Future<LoginResponseMode> getUserData() async {
    final email = await getEmail();
    final phone = await getPhon();
    final uid = await getUid();
    final username = await getUserName();
    return LoginResponseMode(
      email: email ?? '',
      username: username ?? '',
      phone: phone ?? '',
      uid: uid ?? '',
    );
  }
}
