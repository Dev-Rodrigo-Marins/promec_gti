import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart'; // kIsWeb

enum TipoUsuario { cliente, oficina }

class AuthProvider extends ChangeNotifier {
  TipoUsuario? _tipoUsuario;
  String? _email;
  bool _isLoggedIn = false;

  TipoUsuario? get tipoUsuario => _tipoUsuario;
  String? get email => _email;
  bool get isLoggedIn => _isLoggedIn;

  Future<bool> login(String email, String senha, TipoUsuario tipo) async {
    // Simulação de login
    await Future.delayed(const Duration(seconds: 1));

    _email = email;
    _tipoUsuario = tipo;
    _isLoggedIn = true;
    notifyListeners();
    return true;
  }

Future<bool> loginComGoogle(TipoUsuario tipo) async {
  try {
    UserCredential userCredential;

    if (kIsWeb) {
      // 🌐 WEB
      GoogleAuthProvider googleProvider = GoogleAuthProvider();

      userCredential =
          await FirebaseAuth.instance.signInWithPopup(googleProvider);
    } else {
      // 📱 MOBILE
      final GoogleSignInAccount? googleUser =
          await GoogleSignIn().signIn();

      if (googleUser == null) return false;

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      userCredential = await FirebaseAuth.instance
          .signInWithCredential(credential);
    }

    final user = userCredential.user;

    _email = user?.email;
    _tipoUsuario = tipo;
    _isLoggedIn = true;

    notifyListeners();
    return true;
  } catch (e) {
    print('Erro login Google: $e');
    return false;
  }
}

  void logout() {
    _email = null;
    _tipoUsuario = null;
    _isLoggedIn = false;
    notifyListeners();
  }
}