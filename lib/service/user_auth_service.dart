import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:user_auth/models/alert_model.dart';

class UserAuthService {
  final FirebaseAuth _authGoogle = FirebaseAuth.instance;
  final FirebaseAuth _authFacebook = FirebaseAuth.instance;
  final authFacebook = FacebookAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final Dio _api = Dio();
  Future loginFacebook() async {
    try {
      final LoginResult response = await authFacebook.login();
      if (response.accessToken != null) {
        log(response.status.toString());
        final OAuthCredential oAuthCredential =
            FacebookAuthProvider.credential(response.accessToken!.token);
        return _authFacebook.signInWithCredential(oAuthCredential);
      }
    } on FirebaseAuthException catch (e) {
      log("Error login con facebook");
      log("$e");
    }
  }

  Future loginGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      final GoogleSignInAuthentication? googleSignInAuthentication =
          await googleSignInAccount?.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication?.accessToken,
        idToken: googleSignInAuthentication?.idToken,
      );
      final UserCredential authResult =
          await _authGoogle.signInWithCredential(credential);
      final User? user = authResult.user;
      log("User: ${user?.displayName}");
      return authResult;
    } on FirebaseAuthException catch (e) {
      log("Error login con google");
      log("$e");
    }
  }

  Future logoutAll() async {
    await _authFacebook.signOut();
    await _authGoogle.signOut();
    await authFacebook.logOut();
    await _googleSignIn.signOut();
  }

  Future<List<Alerta>> getAlgo() async {
    log("message");
    const url =
        "https://5adc-186-43-198-135.ngrok.io/Proyecto_Practico_Final/srv/astronet/listAler";
    try {
      final response = await _api.get(url);
      final List data = response.data;
      final List<Alerta> alertas = [];
      data.map((e) {
        alertas.add(Alerta.fromMap(e));
      }).toList();
      return alertas;
    } on DioError catch (e) {
      log("Error");
      log("$e");
    }
    return [];
  }
}
