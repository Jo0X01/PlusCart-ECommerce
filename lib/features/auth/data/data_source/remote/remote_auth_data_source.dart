import 'package:supabase_flutter/supabase_flutter.dart';

abstract class RemoteAuthDataSource {
  Future<bool> isAlreadyAuth();
  Future<User?> getCurrentUser();

  Future<User?> login({required String email, required String password});
  Future<User?> loginWithGoogle();

  Future<User?> register({
    required String email,
    required String fullName,
    required String password,
  });
  Future<User?> registerWithGoogle();
  Future<void> sendForgetPasswordToken({required String email});
}
