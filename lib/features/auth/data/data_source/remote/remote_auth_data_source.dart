import 'package:plus_cart/features/auth/data/models/user_model.dart';

abstract class RemoteAuthDataSource {
  Future<bool> isAlreadyAuth();
  Future<UserModel> getCurrentUser();

  Future<UserModel> login({required String email, required String password});
  Future<UserModel> loginWithGoogle();

  Future<UserModel> register({
    required String email,
    required String fullName,
    required String password,
  });
  Future<UserModel> registerWithGoogle();
}
