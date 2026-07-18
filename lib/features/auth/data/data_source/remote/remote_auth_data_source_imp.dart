import 'package:plus_cart/core/services/google_sign_in_service.dart';
import 'package:plus_cart/core/services/supabase_service.dart';
import 'package:plus_cart/features/auth/data/data_source/remote/remote_auth_data_source.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RemoteAuthDataSourceImp implements RemoteAuthDataSource {
  final SupabaseService supabaseService;
  final GoogleSignInService googleSignInService;

  RemoteAuthDataSourceImp({
    required this.supabaseService,
    required this.googleSignInService,
  });

  @override
  Future<User?> login({required String email, required String password}) async {
    final result = await supabaseService.auth.signInWithPassword(
      email: email,
      password: password,
    );
    return result.user;
  }

  @override
  Future<bool> isAlreadyAuth() async {
    return supabaseService.auth.currentUser != null;
  }

  @override
  Future<User?> getCurrentUser() async {
    return supabaseService.auth.currentUser;
  }

  @override
  Future<User?> loginWithGoogle() async {
    final googleUser = await googleSignInService.auth();
    final idToken = googleUser.authentication.idToken;
    if (idToken == null) throw 'No ID token found.';
    await supabaseService.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
    );
    return supabaseService.auth.currentUser;
  }

  @override
  Future<User?> registerWithGoogle() async {
    final googleUser = await googleSignInService.auth();
    final idToken = googleUser.authentication.idToken;
    if (idToken == null) throw 'No ID token found.';
    await supabaseService.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
    );
    return supabaseService.auth.currentUser;
  }

  @override
  Future<User?> register({
    required String email,
    required String fullName,
    required String password,
  }) async {
    final result = await supabaseService.auth.signUp(
      email: email,
      data: {"fullName": fullName, "avatar": null},
      password: password,
    );
    return result.user;
  }
}
