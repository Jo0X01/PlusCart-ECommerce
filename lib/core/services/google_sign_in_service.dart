import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInService {
  static Future<GoogleSignInService> init({required String clientId}) async {
    await GoogleSignIn.instance.initialize(serverClientId: clientId);
    return GoogleSignInService();
  }

  Future<GoogleSignInAccount> auth() async =>
      await GoogleSignIn.instance.authenticate();
  Future<String?>? authAndGetIdToken() async {
    final googleUser = await GoogleSignIn.instance.authenticate();
    final idToken = googleUser.authentication.idToken;
    return idToken;
  }
}
