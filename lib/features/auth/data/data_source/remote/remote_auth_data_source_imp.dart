import 'package:plus_cart/features/auth/data/data_source/remote/remote_auth_data_source.dart';
import 'package:plus_cart/features/auth/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RemoteAuthDataSourceImp implements RemoteAuthDataSource {
  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    final result = await Supabase.instance.client.auth.signInWithPassword(
      email: email,
      password: password,
    );
    return UserModel.fromSupabase(result.user);
  }

  @override
  Future<bool> isAlreadyAuth() async {
    return Supabase.instance.client.auth.currentUser != null;
  }

  @override
  Future<UserModel> getCurrentUser() async {
    return UserModel.fromSupabase(Supabase.instance.client.auth.currentUser);
  }

  @override
  Future<UserModel> loginWithGoogle() async {
    await Supabase.instance.client.auth.signInWithOAuth(OAuthProvider.google);
    return UserModel.fromSupabase(Supabase.instance.client.auth.currentUser);
  }

  @override
  Future<UserModel> registerWithGoogle() async {
    await Supabase.instance.client.auth.signInWithOAuth(OAuthProvider.google);
    return UserModel.fromSupabase(Supabase.instance.client.auth.currentUser);
  }

  @override
  Future<UserModel> register({
    required String email,
    required String fullName,
    required String password,
  }) async {
    final result = await Supabase.instance.client.auth.signUp(
      email: email,
      data: {"fullName": fullName, "avatar": null},
      password: password,
    );
    return UserModel.fromSupabase(result.user);
  }
}
