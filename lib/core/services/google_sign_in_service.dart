import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInService {
  Future<void> init({required String clientId}) async {
    await GoogleSignIn.instance.initialize(serverClientId: clientId);
  }

  Future<GoogleSignInAccount> auth() async => await GoogleSignIn.instance.authenticate();
  
}
