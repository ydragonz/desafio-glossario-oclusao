import 'package:flutter_test/flutter_test.dart';
import 'package:glossario_oclusao/controller/login_controller.dart';

void main() {
  group('LoginController', () {
    late LoginController controller;

    setUp(() {
      controller = LoginController();
    });

    test('tentativa de login com credenciais validas define "logado" como true', () async {
      await controller.login('teste@sou.unaerp.edu.br', 'senha123');

      expect(controller.logado, isTrue);
    });

    test('tentativa de login com credenciais inválidas gerará uma exception', () {
      expect(() => controller.login('invalid', 'credentials'),
          throwsA(isInstanceOf<Exception>()));
    });

    test('logout should set logado to false', () async {
      await controller.login('teste@sou.unaerp.edu.br', 'senha123');

      expect(controller.logado, isTrue);

      await controller.logout();

      expect(controller.logado, isFalse);
    });
  });
}
