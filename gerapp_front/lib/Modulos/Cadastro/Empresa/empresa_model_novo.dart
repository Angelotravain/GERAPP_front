class EmpresaModelNovo {
  int id;
  String? nome;
  String? cnpj;
  int estadoId;
  String? telefone;
  String? email;
  String? website;
  DateTime? dataFundacao;
  String? ramoAtuacao;
  int? numeroFuncionarios;
  String? proprietario;
  DateTime? dataCadastro;
  String logoEmpresa;
  bool ehFilial;
  Endereco enderecoEmpresa;

  EmpresaModelNovo({
    required this.id,
    required this.nome,
    required this.cnpj,
    required this.estadoId,
    required this.telefone,
    required this.email,
    required this.website,
    required this.dataFundacao,
    required this.ramoAtuacao,
    required this.numeroFuncionarios,
    required this.proprietario,
    required this.dataCadastro,
    required this.logoEmpresa,
    required this.ehFilial,
    required this.enderecoEmpresa,
  });

  factory EmpresaModelNovo.fromJson(Map<String, dynamic> json) {
    if (json == null)
      return EmpresaModelNovo(
        id: 0,
        nome: null,
        cnpj: null,
        estadoId: 0,
        telefone: null,
        email: null,
        website: null,
        dataFundacao: null,
        ramoAtuacao: null,
        numeroFuncionarios: null,
        proprietario: null,
        dataCadastro: null,
        logoEmpresa: '',
        ehFilial: false,
        enderecoEmpresa: Endereco.fromJson({}),
      );

    return EmpresaModelNovo(
      id: json['id'] as int,
      nome: json['nome'] as String?,
      cnpj: json['cnpj'] as String?,
      estadoId: json['estadoId'] as int,
      telefone: json['telefone'] as String?,
      email: json['email'] as String?,
      website: json['website'] as String?,
      dataFundacao: json['dataFundacao'] != null
          ? DateTime.parse(json['dataFundacao'].toString())
          : null,
      ramoAtuacao: json['ramoAtuacao'] as String?,
      numeroFuncionarios: json['numeroFuncionarios'] as int?,
      proprietario: json['proprietario'] as String?,
      dataCadastro: json['dataCadastro'] != null
          ? DateTime.parse(json['dataCadastro'].toString())
          : null,
      logoEmpresa: json['logoEmpresa'] as String,
      ehFilial: json['ehFilial'] as bool,
      enderecoEmpresa: Endereco.fromJson(json['enderecoEmpresa']),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'nome': nome,
        'cnpj': cnpj,
        'estadoId': estadoId,
        'telefone': telefone,
        'email': email,
        'website': website,
        'dataFundacao': dataFundacao?.toIso8601String(),
        'ramoAtuacao': ramoAtuacao,
        'numeroFuncionarios': numeroFuncionarios,
        'proprietario': proprietario,
        'dataCadastro': dataCadastro?.toIso8601String(),
        'logoEmpresa': logoEmpresa,
        'ehFilial': ehFilial,
        'enderecoEmpresa': enderecoEmpresa.toJson(),
      };
}

class Endereco {
  int id;
  String logradouro;
  String numero;
  String complemento;
  String cep;
  int bairroId;
  int clienteId;
  int funcionarioId;
  int empresaId;

  Endereco({
    required this.id,
    required this.logradouro,
    required this.numero,
    required this.complemento,
    required this.cep,
    required this.bairroId,
    required this.clienteId,
    required this.funcionarioId,
    required this.empresaId,
  });

  factory Endereco.fromJson(Map<String, dynamic> json) {
    if (json == null)
      return Endereco(
        id: 0,
        logradouro: '',
        numero: '',
        complemento: '',
        cep: '',
        bairroId: 0,
        clienteId: 0,
        funcionarioId: 0,
        empresaId: 0,
      );

    return Endereco(
      id: json['id'] as int,
      logradouro: json['logradouro'] as String,
      numero: json['numero'] as String,
      complemento: json['complemento'] as String,
      cep: json['cep'] as String,
      bairroId: json['bairroId'] as int,
      clienteId: json['clienteId'] as int,
      funcionarioId: json['funcionarioId'] as int,
      empresaId: json['empresaId'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'logradouro': logradouro,
        'numero': numero,
        'complemento': complemento,
        'cep': cep,
        'bairroId': bairroId,
        'clienteId': clienteId,
        'funcionarioId': funcionarioId,
        'empresaId': empresaId,
      };
}
