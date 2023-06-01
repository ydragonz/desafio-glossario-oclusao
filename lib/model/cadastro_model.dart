class Cadastro {
  String nome;
  final String codigoMatricula;
  String email;
  String senha;

  get getNome => nome;

  set setNome(final nome) => this.nome = nome;

  get getCodigo => codigoMatricula;

  get getEmail => email;

  set setEmail( email) => this.email = email;

  get getSenha => senha;

  set setSenha( senha) => this.senha = senha;

  Cadastro(this.nome, this.codigoMatricula, this.email, this.senha);

  /*Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'uid': uid,
      'titulo': titulo,
      'descricao': descricao
    };
  }

  factory Tarefa.fromJson(Map<String, dynamic> json) {
    return Tarefa(
      json['uid'],
      json['titulo'],
      json['descricao'],
    );
  }*/
}