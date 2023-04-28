class Cadastro {
  String nome;
  final String codigoMatricula;
  String email;
  String senha;
  final bool tipo; // 0-> Aluno  |  1-> Professor

  get getNome => nome;

  set setNome(final nome) => this.nome = nome;

  get getCodigo => codigoMatricula;

  get getEmail => email;

  set setEmail( email) => this.email = email;

  get getSenha => senha;

  set setSenha( senha) => this.senha = senha;

  get getTipo => tipo;

  Cadastro(this.nome, this.codigoMatricula, this.tipo, this.email, this.senha);
}