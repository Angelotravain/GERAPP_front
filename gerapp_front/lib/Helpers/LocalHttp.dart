class Local {
  static String localName = 'https://localhost:7009';
  static String URL_BAIRRO = '${localName}/api/Gerapp/Cadastro/ListarBairros';
  static String URL_FUNCIONARIO =
      '${localName}/api/Gerapp/Cadastro/ListarFuncionarios';
  static String URL_VEICULO =
      '${localName}/api/Gerapp/Locacao/Veiculo/ListarTodos';
  static String URL_SALVAR_VEICULO =
      '${localName}/api/Gerapp/Locacao/Veiculo/Salvar';
  static String URL_EDITAR_VEICULO =
      '${localName}/api/Gerapp/Locacao/Veiculo/Atualizar';
  static String URL_TIPO_EQUIPAMENTO_LISTA =
      '${localName}/api/Gerapp/Locacao/TipoEquipamento/ListarTodos';
  static String BUSCA_CEP =
      'https://localhost:7009/api/v1/BuscarCep/BuscarCep/';
  static String SALVAR_TIPO_EQUIPAMENTO =
      'https://localhost:7009/api/Gerapp/Locacao/TipoEquipamento/Salvar';
  static String EDITAR_TIPO_EQUIPAMENTO =
      'https://localhost:7009/api/Gerapp/Locacao/TipoEquipamento/Atualizar';
  static String EXCLUIR_TIPO_EQUIPAMENTO =
      'https://localhost:7009/api/Gerapp/Locacao/TipoEquipamento/Excluir';
  static String URL_BUSCAR_CARGO =
      '${localName}/api/Gerapp/Cadastro/ListarCargos';
  static String URL_DELETE_EQUIPAMENTO =
      'https://localhost:7009/api/Gerapp/Locacao/Equipamento/Excluir';
  static String URL_LISTAR_EQUIPAMENTO =
      'https://localhost:7009/api/Gerapp/Locacao/Equipamento/ListarTodos';
  static String URL_SALVAR_EQUIPAMENTO =
      'https://localhost:7009/api/Gerapp/Locacao/Equipamento/Salvar';
  static String URL_EDITAR_EQUIPAMENTO =
      'https://localhost:7009/api/Gerapp/Locacao/Equipamento/Atualizar';
  static String URL_FORMA_PAGAMENTO_LISTA =
      'https://localhost:7009/api/Gerapp/Financeiro/FormaPagamento/ListarTodos';
  static String URL_FORMA_PAGAMENTO_SALVAR =
      'https://localhost:7009/api/Gerapp/Financeiro/FormaPagamento/Salvar';
  static String URL_FORMA_PAGAMENTO_EDITAR =
      'https://localhost:7009/api/Gerapp/Financeiro/FormaPagamento/Atualizar';
  static String URL_FORMA_PAGAMENTO_EXCLUIR =
      'https://localhost:7009/api/Gerapp/Financeiro/FormaPagamento/Excluir';
  static String URL_LOGIN_FUNCIONARIO =
      'https://localhost:7009/api/Cadastro/Usuario/LoginFuncionario';
  static String URL_DELETE_EMPRESA =
      'https://localhost:7009/api/Gerapp/Cadastro/ExcluirEmpresas';
  static String URL_EDITAR_BAIRRO =
      'https://localhost:7009/api/Gerapp/Cadastro/AtualizarBairro';
  static String URL_SALVAR_BAIRRO =
      'https://localhost:7009/api/Gerapp/Cadastro/SalvarBairro';
  static String URL_CIDADE_LISTA =
      '${localName}/api/Gerapp/Cadastro/ListarCidades';
}
