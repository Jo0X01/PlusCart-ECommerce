

import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvService {
  Future<void> init() async {
    await dotenv.load();
  }

  String? get(String key) => dotenv.env[key];
  onGet(List<String> keys,afterGetCallback) async {
    
  }
}