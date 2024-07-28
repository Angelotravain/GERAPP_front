class Local {
  static String localName = 'https://localhost:4441/api/v1/gerapp/';

  static String URL_BAIRRO = '${localName}Bairro';

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
  static String BUSCA_CEP = '${localName}api/v1/BuscarCep/BuscarCep/';
  static String SALVAR_TIPO_EQUIPAMENTO =
      '${localName}api/Gerapp/Locacao/TipoEquipamento/Salvar';
  static String EDITAR_TIPO_EQUIPAMENTO =
      '${localName}api/Gerapp/Locacao/TipoEquipamento/Atualizar';
  static String EXCLUIR_TIPO_EQUIPAMENTO =
      '${localName}api/Gerapp/Locacao/TipoEquipamento/Excluir';
  static String URL_BUSCAR_CARGO =
      '${localName}/api/Gerapp/Cadastro/ListarCargos';
  static String URL_DELETE_EQUIPAMENTO =
      '${localName}api/Gerapp/Locacao/Equipamento/Excluir';
  static String URL_LISTAR_EQUIPAMENTO =
      '${localName}api/Gerapp/Locacao/Equipamento/ListarTodos';
  static String URL_SALVAR_EQUIPAMENTO =
      '${localName}api/Gerapp/Locacao/Equipamento/Salvar';
  static String URL_EDITAR_EQUIPAMENTO =
      '${localName}api/Gerapp/Locacao/Equipamento/Atualizar';
  static String URL_FORMA_PAGAMENTO_LISTA =
      '${localName}api/Gerapp/Financeiro/FormaPagamento/ListarTodos';
  static String URL_FORMA_PAGAMENTO_SALVAR =
      '${localName}api/Gerapp/Financeiro/FormaPagamento/Salvar';
  static String URL_FORMA_PAGAMENTO_EDITAR =
      '${localName}api/Gerapp/Financeiro/FormaPagamento/Atualizar';
  static String URL_FORMA_PAGAMENTO_EXCLUIR =
      '${localName}api/Gerapp/Financeiro/FormaPagamento/Excluir';
  static String URL_LOGIN_FUNCIONARIO =
      '${localName}api/Cadastro/Usuario/LoginFuncionario';
  static String URL_DELETE_EMPRESA =
      '${localName}api/Gerapp/Cadastro/ExcluirEmpresas';
  static String URL_CIDADE_LISTA =
      '${localName}/api/Gerapp/Cadastro/ListarCidades';
  static String URL_EDITAR_EMPRESA =
      '${localName}/api/Gerapp/Cadastro/AtualizarEmpresas';
  static String URL_SALVAR_EMPRESA =
      '${localName}/api/Gerapp/Cadastro/SalvarEmpresas';
}
