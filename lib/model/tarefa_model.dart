class Tarefa {
  final String uid;
  final String titulo;
  final String descricao;

  Tarefa(this.uid, this.titulo, this.descricao);

  Map<String, dynamic> toJson() {
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
  }
}
