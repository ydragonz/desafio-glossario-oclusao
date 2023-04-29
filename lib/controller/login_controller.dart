/* Na primeira etapa a parte de validação de login não é necessária
   então não há como implementar o login_contoller no momento, será
   implementado para as avaliações finais e por enquanto utilizaremos
   variaveis predefinidas para simular credenciais autorizadas */


class LoginController {
  final String _emailValido = 'teste@sou.unaerp.edu.br';
  final String _senhaValida = 'senha123';

  bool _logado = false;

  bool get logado => _logado;

  Future<void> login(String username, String password) async {
    if (username == _emailValido && password == _senhaValida) {
      _logado = true;
    } else {
      _logado = false;
      throw Exception('Credenciais inválidas');
    }
  }

  Future<void> logout() async {
    _logado = false;
  }
}