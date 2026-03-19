import 'package:flutter/material.dart';

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

  void logout() {
    _email = null;
    _tipoUsuario = null;
    _isLoggedIn = false;
    notifyListeners();
  }
}
