import 'package:supabase_flutter/supabase_flutter.dart';

abstract class RemoteAppStartupDataSource {
  Future<bool> isLoggedIn();
  Future<bool> isLoggedOut();
  Future<User?> getCurrentUser();
}
