class BairroModel {
  int id;
  String nome;
  double valorFrete;
  bool isentarFrete;

  BairroModel(
      {required int this.id,
      required String this.nome,
      required double this.valorFrete,
      required bool this.isentarFrete});

  factory BairroModel.fromJson(Map<String, dynamic> json) {
    return BairroModel(
        id: json['id'],
        nome: json['nome'],
        isentarFrete: json['isentarFrete'],
        valorFrete: json['valorFrete']);
  }
}
