import 'package:supabase_flutter/supabase_flutter.dart';

abstract class RemoteAuthDataSource {
  Future<User?> login({required String email, required String password});
  Future<User?> loginWithGoogle();

  Future<User?> register({
    required String email,
    required String fullName,
    required String password,
  });
  Future<User?> registerWithGoogle();
  Future<void> sendForgetPasswordOtpToken({required String email});
  Future<void> verfiyOtpToken({required String email,required String code});
  Future<void> updatePassword({required String password});
}
