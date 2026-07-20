import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  SupabaseClient get client => Supabase.instance.client;
  GoTrueClient get auth => Supabase.instance.client.auth;

  Future<void> init({required String url, String? publishableKey}) async {
    await Supabase.initialize(url: url, publishableKey: publishableKey);
  }

  Future<bool> isLoggedOut() async {
    return auth.currentUser == null;
  }

  Future<bool> isLoggedIn() async {
    return auth.currentUser != null;
  }

  Future<User?> getLoggedInUser() async {
    return auth.currentUser;
  }

  Future<AuthResponse> verfiyOtpCode({
    required String email,
    required String code,
  }) async {
    return await auth.verifyOTP(
      email: email,
      token: code,
      type: OtpType.recovery,
    );
  }

  Future<UserResponse> updateUserInfo({
    String? email,
    String? phone,
    String? password,
  }) async {
    final user = await auth.updateUser(
      UserAttributes(email: email, phone: phone, password: password),
    );
    await auth.signOut();
    return user;
  }

  Future<void> signOut() async {
    await auth.signOut();
  }
}
