program Vendas;

uses
  Vcl.Forms,
  uPrincipal in 'uPrincipal.pas' {frmPrincipal},
  uDTMConexao in 'data_module\uDTMConexao.pas' {dtmPrincipal: TDataModule},
  uTelaHeranca in 'heranca\uTelaHeranca.pas' {frmTelaHeranca},
  uCadCategorias in 'cadastro\uCadCategorias.pas' {frmCadCategorias},
  Enter in 'terceiros\Enter.pas',
  uEnum in 'heranca\uEnum.pas',
  cCadCategoria in 'Classes\cCadCategoria.pas',
  uCadClientes in 'cadastro\uCadClientes.pas' {frmCadClientes},
  cCadCliente in 'Classes\cCadCliente.pas',
  cCadProduto in 'Classes\cCadProduto.pas',
  uFRMAtualizaDB in 'data_module\uFRMAtualizaDB.pas' {frmAtualizaDB},
  uDTMVenda in 'data_module\uDTMVenda.pas' {dtmVendas: TDataModule},
  uProVendas in 'processo\uProVendas.pas' {frmProVenda},
  cProVenda in 'Classes\cProVenda.pas',
  cControleEstoque in 'Classes\cControleEstoque.pas',
  uRelClientesFicha in 'relatorios\uRelClientesFicha.pas' {frmRelClientesFicha},
  uRelClientes in 'relatorios\uRelClientes.pas' {frmRelClientes},
  uRelCategorias in 'relatorios\uRelCategorias.pas' {frmRelCategorias},
  uRelProdutos in 'relatorios\uRelProdutos.pas' {frmRelProdutos},
  uSelecionarData in 'relatorios\uSelecionarData.pas' {frmSelecionarData},
  uRelProdutosComGrupoCategoria in 'relatorios\uRelProdutosComGrupoCategoria.pas' {frmRelProdutosComGrupoCategoria},
  uRelProcessoDeVenda in 'relatorios\uRelProcessoDeVenda.pas' {frmRelProcessoDeVenda},
  uRelVendasPorData in 'relatorios\uRelVendasPorData.pas' {frmRelVendaPorData},
  uFuncaoCriptografia in 'heranca\uFuncaoCriptografia.pas',
  uCadUsuarios in 'cadastro\uCadUsuarios.pas' {frmCadUsuarios},
  cCadUsuario in 'Classes\cCadUsuario.pas',
  uLogin in 'login\uLogin.pas' {frmLogin},
  uAlterarSenha in 'login\uAlterarSenha.pas' {frmAlterarSenha},
  cUsuarioLogado in 'login\cUsuarioLogado.pas',
  cAtualizacaoDB in 'Classes\cAtualizacaoDB.pas',
  cAtualizacaoTabelasMySQL in 'Classes\cAtualizacaoTabelasMySQL.pas',
  cAtualizacaoCamposMySQL in 'Classes\cAtualizacaoCamposMySQL.pas',
  cArquivoIni in 'Classes\cArquivoIni.pas',
  cAcaoAcesso in 'Classes\cAcaoAcesso.pas',
  uCadAcaoAcesso in 'cadastro\uCadAcaoAcesso.pas' {frmCadAcaoAcesso},
  uCadProdutos in 'cadastro\uCadProdutos.pas' {frmCadProdutos},
  uAcoesPorUsuario in 'login\uAcoesPorUsuario.pas' {frmAcoesPorUsuario},
  uDTMGraficos in 'data_module\uDTMGraficos.pas' {dtmGrafico: TDataModule},
  cFuncao in 'Classes\cFuncao.pas',
  uTelaHerancaConsulta in 'heranca\uTelaHerancaConsulta.pas' {frmTelaHerancaConsulta},
  uConCategoria in 'Consulta\uConCategoria.pas' {frmConCategoria};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
