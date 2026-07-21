import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvService {
  static Future<EnvService> init() async {
    await dotenv.load();
    return EnvService();
  }

  String? get(String key) => dotenv.env[key];
}
