unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.Menus, uDTMConexao, Enter, uFRMAtualizaDB, FireDAC.Stan.Param,
  cUsuarioLogado, Vcl.ComCtrls, FireDAC.Stan.Option, System.UITypes,
  Vcl.ExtCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, VclTee.TeeGDIPlus,
  VclTee.TeEngine, VclTee.Series, VclTee.TeeProcs, VclTee.Chart, VclTee.DBChart;

type
  TfrmPrincipal = class(TForm)
    mainPrincipal: TMainMenu;
    Cadastro1: TMenuItem;
    Movimentao1: TMenuItem;
    Relatrios1: TMenuItem;
    Cliente1: TMenuItem;
    N1: TMenuItem;
    Categoria1: TMenuItem;
    Produto1: TMenuItem;
    N2: TMenuItem;
    mnuFechar: TMenuItem;
    Vendas1: TMenuItem;
    Cliente2: TMenuItem;
    Cliente3: TMenuItem;
    Produto2: TMenuItem;
    Produto3: TMenuItem;
    Vendapordata1: TMenuItem;
    Categoria2: TMenuItem;
    Fichadecliente1: TMenuItem;
    Produtosporcategoria1: TMenuItem;
    Usuario1: TMenuItem;
    N3: TMenuItem;
    Alterarsenha1: TMenuItem;
    stbPrincipal: TStatusBar;
    AcaoAcesso1: TMenuItem;
    N4: TMenuItem;
    Aesporusurio1: TMenuItem;
    N5: TMenuItem;
    Panel1: TPanel;
    GridPanel1: TGridPanel;
    DBChart1: TDBChart;
    Series1: TBarSeries;
    DBChart2: TDBChart;
    Series2: TPieSeries;
    DBChart3: TDBChart;
    Series3: TPieSeries;
    DBChart4: TDBChart;
    Series4: TFastLineSeries;
    tmrAtualizacaoDashboard: TTimer;
    procedure mnuFecharClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Categoria1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Cliente1Click(Sender: TObject);
    procedure Produto1Click(Sender: TObject);
    procedure Vendas1Click(Sender: TObject);
    procedure CategoriaRel1Click(Sender: TObject);
    procedure ClienteRel1Click(Sender: TObject);
    procedure Fichadecliente1Click(Sender: TObject);
    procedure ProdutoRel1Click(Sender: TObject);
    procedure Produtosporcategoria1Click(Sender: TObject);
    procedure Vendapordata1Click(Sender: TObject);
    procedure Usuario1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Alterarsenha1Click(Sender: TObject);
    procedure AcaoAcesso1Click(Sender: TObject);
    procedure Aesporusurio1Click(Sender: TObject);
    procedure AtualizaDashboard;
    procedure Panel1Click(Sender: TObject);
    procedure tmrAtualizacaoDashboardTimer(Sender: TObject);
  private
    { Private declarations }
    TeclaEnter: TMREnter;
    procedure AtualizaBancoDeDados(Form: TfrmAtualizaDB);
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;
  oUsuarioLogado: TUsuarioLogado;

implementation

{$R *.dfm}

uses uCadCategorias, uCadClientes, uCadProdutos, uProVendas, uRelCategorias,
  uRelClientes, uRelClientesFicha, uSelecionarData,
  uRelProdutos, uRelProdutosComGrupoCategoria, uRelVendasPorData,
  uCadUsuarios, uLogin, uAlterarSenha, cAtualizacaoDB, cAtualizacaoTabelasMySQL,
  cArquivoIni, uCadAcaoAcesso, cAcaoAcesso, RLReport, uAcoesPorUsuario,
  uTelaHeranca, uDTMGraficos, cFuncao;

{$REGION 'Form events'}

procedure TfrmPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(TeclaEnter);
  FreeAndNil(dtmPrincipal);
  FreeAndNil(dtmGrafico);

  if Assigned(oUsuarioLogado) then
    FreeAndNil(oUsuarioLogado);
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  if not FileExists(TArquivoIni.ArquivoIni) then
  begin
    TArquivoIni.AtualizarIni('SERVER', 'DriverID', 'MySQL');
    TArquivoIni.AtualizarIni('SERVER', 'Server', 'localhost');
    TArquivoIni.AtualizarIni('SERVER', 'Port', '3306');
    TArquivoIni.AtualizarIni('SERVER', 'User_Name', 'root');
    TArquivoIni.AtualizarIni('SERVER', 'Password', '!@#1q2w3e4r');
    TArquivoIni.AtualizarIni('SERVER', 'Database', 'delphi');

    MessageDlg('Arquivo ' + TArquivoIni.ArquivoIni + 'criado.' + #13 +
      'Configure o arquivo antes de iniciar a aplicação', mtInformation,
      [mbOk], 0);

    Application.Terminate
  end
  else
  begin
    frmAtualizaDB := TfrmAtualizaDB.Create(Self);
    frmAtualizaDB.Show;
    frmAtualizaDB.Refresh;

    dtmPrincipal := TdtmPrincipal.Create(Self);

    with dtmPrincipal.ConexaoDB.Params do
    begin
      Values['Database'] := TArquivoIni.LerIni('SERVER', 'Database');
      Values['DriverID'] := TArquivoIni.LerIni('SERVER', 'DriverID');
      Values['Password'] := TArquivoIni.LerIni('SERVER', 'Password');
      Values['Port'] := TArquivoIni.LerIni('SERVER', 'Port');
      Values['Server'] := TArquivoIni.LerIni('SERVER', 'Server');
      Values['User_Name'] := TArquivoIni.LerIni('SERVER', 'User_Name');
    end;
    with dtmPrincipal.ConexaoDB.TxOptions do
    begin
      AutoCommit := True;
      Isolation := xiReadCommitted;
    end;

    dtmPrincipal.ConexaoDB.ResourceOptions.SilentMode := False;
    dtmPrincipal.ConexaoDB.Connected := True;

    AtualizaBancoDeDados(frmAtualizaDB);

    TAcaoAcesso.CriarAcoes(TfrmCadCategorias, dtmPrincipal.ConexaoDB);
    TAcaoAcesso.CriarAcoes(TfrmCadClientes, dtmPrincipal.ConexaoDB);
    TAcaoAcesso.CriarAcoes(TfrmCadProdutos, dtmPrincipal.ConexaoDB);
    TAcaoAcesso.CriarAcoes(TfrmCadUsuarios, dtmPrincipal.ConexaoDB);
    TAcaoAcesso.CriarAcoes(TfrmCadAcaoAcesso, dtmPrincipal.ConexaoDB);
    TAcaoAcesso.CriarAcoes(TfrmAcoesPorUsuario, dtmPrincipal.ConexaoDB);
    TAcaoAcesso.CriarAcoes(TfrmAlterarSenha, dtmPrincipal.ConexaoDB);
    TAcaoAcesso.CriarAcoes(TfrmProVenda, dtmPrincipal.ConexaoDB);
    TAcaoAcesso.CriarAcoes(TfrmRelVendaPorData, dtmPrincipal.ConexaoDB);
    TAcaoAcesso.CriarAcoes(TfrmRelClientesFicha, dtmPrincipal.ConexaoDB);
    TAcaoAcesso.CriarAcoes(TfrmRelClientes, dtmPrincipal.ConexaoDB);
    TAcaoAcesso.CriarAcoes(TfrmRelProdutosComGrupoCategoria,
      dtmPrincipal.ConexaoDB);
    TAcaoAcesso.CriarAcoes(TfrmRelProdutos, dtmPrincipal.ConexaoDB);
    TAcaoAcesso.CriarAcoes(TfrmRelCategorias, dtmPrincipal.ConexaoDB);

    TAcaoAcesso.PreencherUsuariosAcoes(dtmPrincipal.ConexaoDB);

    dtmGrafico := TdtmGrafico.Create(Self);
    AtualizaDashboard;
    frmAtualizaDB.Free;

    TeclaEnter := TMREnter.Create(Self);
    TeclaEnter.FocusEnabled := True;
    TeclaEnter.FocusColor := clInfoBk;
  end;
end;

procedure TfrmPrincipal.FormShow(Sender: TObject);
begin
  try
    oUsuarioLogado := TUsuarioLogado.Create;
    frmLogin := TfrmLogin.Create(Self);
    frmLogin.ShowModal;
  finally
    frmLogin.Release;
    stbPrincipal.Panels[0].Text := 'Usuário: ' + oUsuarioLogado.nome;
  end;
end;

{$ENDREGION}
{$REGION 'Buttons events'}

procedure TfrmPrincipal.Categoria1Click(Sender: TObject);
begin
  TFuncao.CriarForm(TfrmCadCategorias, oUsuarioLogado, dtmPrincipal.ConexaoDB);
end;

procedure TfrmPrincipal.CategoriaRel1Click(Sender: TObject);
begin
  TFuncao.CriarRelatorio(TfrmRelCategorias, oUsuarioLogado, dtmPrincipal.ConexaoDB);
end;

procedure TfrmPrincipal.Cliente1Click(Sender: TObject);
begin
  TFuncao.CriarForm(TfrmCadClientes, oUsuarioLogado, dtmPrincipal.ConexaoDB);
end;

procedure TfrmPrincipal.ClienteRel1Click(Sender: TObject);
begin
  TFuncao.CriarRelatorio(TfrmRelClientes, oUsuarioLogado, dtmPrincipal.ConexaoDB);
end;

procedure TfrmPrincipal.Fichadecliente1Click(Sender: TObject);
begin
  TFuncao.CriarRelatorio(TfrmRelClientesFicha, oUsuarioLogado, dtmPrincipal.ConexaoDB);
end;

procedure TfrmPrincipal.mnuFecharClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfrmPrincipal.Panel1Click(Sender: TObject);
begin
  AtualizaDashboard;
end;

procedure TfrmPrincipal.Produto1Click(Sender: TObject);
begin
  TFuncao.CriarForm(TfrmCadProdutos, oUsuarioLogado, dtmPrincipal.ConexaoDB);
end;

procedure TfrmPrincipal.ProdutoRel1Click(Sender: TObject);
begin
  TFuncao.CriarRelatorio(TfrmRelProdutos, oUsuarioLogado, dtmPrincipal.ConexaoDB);
end;

procedure TfrmPrincipal.Produtosporcategoria1Click(Sender: TObject);
begin
  TFuncao.CriarRelatorio(TfrmRelProdutosComGrupoCategoria, oUsuarioLogado, dtmPrincipal.ConexaoDB);
end;

procedure TfrmPrincipal.tmrAtualizacaoDashboardTimer(Sender: TObject);
begin
  AtualizaDashboard;
end;

procedure TfrmPrincipal.Usuario1Click(Sender: TObject);
begin
  TFuncao.CriarForm(TfrmCadUsuarios, oUsuarioLogado, dtmPrincipal.ConexaoDB);
end;

procedure TfrmPrincipal.Vendapordata1Click(Sender: TObject);
begin
  try
    frmSelecionarData := TfrmSelecionarData.Create(Self);
    if TUsuarioLogado.TenhoAcesso(oUsuarioLogado.codigo,
      frmSelecionarData.Name, dtmPrincipal.ConexaoDB) then
    begin
      frmSelecionarData.ShowModal;

      frmRelVendaPorData := TfrmRelVendaPorData.Create(Self);
      frmRelVendaPorData.qryVendas.Close;
      frmRelVendaPorData.qryVendas.ParamByName('dataInicio').AsDate :=
        frmSelecionarData.edtDataInicial.Date;
      frmRelVendaPorData.qryVendas.ParamByName('dataFinal').AsDate :=
        frmSelecionarData.edtDataFinal.Date;
      frmRelVendaPorData.qryVendas.Open;
      frmRelVendaPorData.relatorio.PreviewModal;
    end
    else
    begin
      MessageDlg('Usuário: ' + oUsuarioLogado.nome +
        ' não tem permissão de acesso', mtWarning, [mbOk], 0);
    end;
  finally
    if Assigned(frmSelecionarData) then
      frmSelecionarData.Release;
    if Assigned(frmRelVendaPorData) then
      frmRelVendaPorData.Release;
  end;
end;

procedure TfrmPrincipal.Vendas1Click(Sender: TObject);
begin
  TFuncao.CriarForm(TfrmProVenda, oUsuarioLogado, dtmPrincipal.ConexaoDB);
end;

procedure TfrmPrincipal.Aesporusurio1Click(Sender: TObject);
begin
  TFuncao.CriarForm(TfrmAcoesPorUsuario, oUsuarioLogado, dtmPrincipal.ConexaoDB);
end;

procedure TfrmPrincipal.Alterarsenha1Click(Sender: TObject);
begin
  TFuncao.CriarForm(TfrmAlterarSenha, oUsuarioLogado, dtmPrincipal.ConexaoDB);
end;

procedure TfrmPrincipal.AcaoAcesso1Click(Sender: TObject);
begin
  TFuncao.CriarForm(TfrmCadAcaoAcesso, oUsuarioLogado, dtmPrincipal.ConexaoDB);
end;

{$ENDREGION}
{$REGION 'Functions and Procedures'}

procedure TfrmPrincipal.AtualizaBancoDeDados(Form: TfrmAtualizaDB);
var
  oAtualizacaoDB: TAtualizacaoDB;
  oTabela: TAtualizacaoTabelasMySQL;
begin
  Form.Refresh;

  try
    oAtualizacaoDB := TAtualizacaoDB.Create(dtmPrincipal.ConexaoDB);
    oTabela := TAtualizacaoTabelasMySQL.Create(dtmPrincipal.ConexaoDB);
  finally
    if Assigned(oAtualizacaoDB) then
      FreeAndNil(oAtualizacaoDB);

    if Assigned(oTabela) then
      FreeAndNil(oTabela);
  end;

  Form.chklConexao.Checked := True;
  Form.Refresh;
  Sleep(300);
  Form.chkCategoria.Checked := True;
  Form.Refresh;
  Sleep(300);
  Form.chkProduto.Checked := True;
  Form.Refresh;
  Sleep(300);
  Form.chkCliente.Checked := True;
  Form.Refresh;
  Sleep(300);
  Form.chkVenda.Checked := True;
  Form.Refresh;
  Sleep(300);
  Form.chkVendasItens.Checked := True;
  Form.Refresh;
  Sleep(300);
  Form.chkUsuarios.Checked := True;
  Form.Refresh;
  Sleep(300);
  Form.chkAcaoAcesso.Checked := True;
  Form.Refresh;
  Sleep(300);
end;

procedure TfrmPrincipal.AtualizaDashboard;
begin
  try
    Screen.Cursor := crSQLWait;
    if dtmGrafico.qryProdutoEstoque.Active then
      dtmGrafico.qryProdutoEstoque.Close;

    if dtmGrafico.qryVendaValorPorCliente.Active then
      dtmGrafico.qryVendaValorPorCliente.Close;

    if dtmGrafico.qry10ProdutosMaisVendidos.Active then
      dtmGrafico.qry10ProdutosMaisVendidos.Close;

    if dtmGrafico.qryVendasUltimaSemana.Active then
      dtmGrafico.qryVendasUltimaSemana.Close;

    dtmGrafico.qryProdutoEstoque.Open;
    dtmGrafico.qryVendaValorPorCliente.Open;
    dtmGrafico.qry10ProdutosMaisVendidos.Open;
    dtmGrafico.qryVendasUltimaSemana.Open;
  finally
    Screen.Cursor := crDefault;
  end;
end;

{$ENDREGION}

end.
