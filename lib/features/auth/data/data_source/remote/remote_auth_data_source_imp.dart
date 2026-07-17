import 'dart:developer';

import 'package:google_sign_in/google_sign_in.dart';
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
    final googleUser = await GoogleSignIn.instance.authenticate();
    final idToken = googleUser.authentication.idToken;
    if (idToken == null) throw 'No ID token found.';
    await Supabase.instance.client.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
    );
    return UserModel.fromSupabase(Supabase.instance.client.auth.currentUser);
  }

  @override
  Future<UserModel> registerWithGoogle() async {
    final googleUser = await GoogleSignIn.instance.authenticate();
    final idToken = googleUser.authentication.idToken;
    if (idToken == null) throw 'No ID token found.';
    await Supabase.instance.client.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
    );
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
    log(result.toString());
    return UserModel.fromSupabase(result.user);
  }
}
