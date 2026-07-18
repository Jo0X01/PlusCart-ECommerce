import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  SupabaseClient get client => Supabase.instance.client;
  GoTrueClient get auth => Supabase.instance.client.auth;

  Future<void> init({required String url, String? publishableKey}) async {
    await Supabase.initialize(url: url, publishableKey: publishableKey);
  }
}
