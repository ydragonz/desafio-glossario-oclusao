class Termo {

  final double codigo;
  String termo;
  String descricao;

  double get getCodigo => codigo;

  get getTermo => termo;

  set setTermo( termo) => this.termo = termo;

  get getDescricao => descricao;

  set setDescricao( descricao) => this.descricao = descricao;

  Termo(this.codigo, this.termo, this.descricao);
}