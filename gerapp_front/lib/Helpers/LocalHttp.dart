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
}
