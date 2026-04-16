//pagina com todas apis do app


class ApiService {
  // Simulação de login
  Future<bool> login(String email, String senha,) async {
    await Future.delayed(const Duration(seconds: 1));
    return true; // Retorna sucesso para simulação
  }



  // Outras APIs podem ser adicionadas aqui (ex: cadastro, recuperação de senha, etc.)
} 