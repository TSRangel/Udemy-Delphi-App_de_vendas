unit uCadProdutos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uTelaHeranca, Data.DB,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.Buttons, Vcl.DBCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Mask,
  Vcl.ExtCtrls, Vcl.ComCtrls, RxToolEdit, RxCurrEdit, cCadProduto, uEnum,
  uDtmConexao;

type
  TfrmCadProdutos = class(TfrmTelaHeranca)
    qryListagemprodutoId: TFDAutoIncField;
    qryListagemnome: TStringField;
    qryListagemdescricao: TStringField;
    qryListagemvalor: TFMTBCDField;
    qryListagemquantidade: TFMTBCDField;
    qryListagemcategoriaId: TIntegerField;
    qryListagemDescricaoCategoria: TStringField;
    edtProdutoId: TLabeledEdit;
    edtNome: TLabeledEdit;
    edtDescricao: TMemo;
    lblDescricao: TLabel;
    edtValor: TCurrencyEdit;
    edtQuantidade: TCurrencyEdit;
    lblValor: TLabel;
    lblQuantidade: TLabel;
    dtsCategoria: TDataSource;
    qryCategoria: TFDQuery;
    qryCategoriacategoriaId: TFDAutoIncField;
    qryCategoriadescricao: TStringField;
    lkpCategoria: TDBLookupComboBox;
    lblCategoria: TLabel;
    spdbtnIncluir: TSpeedButton;
    spdbtnPesquisar: TSpeedButton;
    procedure btnAlterarClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure spdbtnIncluirClick(Sender: TObject);
    procedure spdbtnPesquisarClick(Sender: TObject);
  private
    { Private declarations }
    oProduto: TProduto;
    function Apagar: Boolean; override;
    function Gravar(EstadoDoCadastro: TEstadoDoCadastro): Boolean; override;
  public
    { Public declarations }
  end;

var
  frmCadProdutos : TfrmCadProdutos;

implementation

uses uPrincipal, cFuncao, uCadCategorias, uConCategoria;

{$R *.dfm}
{$REGION 'Ovedrride'}

function TfrmCadProdutos.Apagar: Boolean;
begin
  if oProduto.Selecionar(qryListagem.FieldByName('produtoId').AsInteger) then
    Result := oProduto.Apagar;
end;

function TfrmCadProdutos.Gravar(EstadoDoCadastro: TEstadoDoCadastro): Boolean;
begin
  if (EstadoDoCadastro = ecInserir) then
    Result := oProduto.Inserir
  else if (EstadoDoCadastro = ecAlterar) then
    Result := oProduto.Atualizar;
end;

{$ENDREGION}
{$REGION 'Buttons events'}

procedure TfrmCadProdutos.btnAlterarClick(Sender: TObject);
begin
  if oProduto.Selecionar(qryListagem.FieldByName('produtoId').AsInteger) then
  begin
    edtProdutoId.Text := IntToStr(oProduto.codigo);
    edtNome.Text := oProduto.nome;
    edtDescricao.Text := oProduto.descricao;
    lkpCategoria.KeyValue := oProduto.categoriaId;
    edtValor.Value := oProduto.valor;
    edtQuantidade.Value := oProduto.quantidade;
  end
  else
  begin
    btnCancelar.Click;
    Abort;
  end;

  inherited;

end;

procedure TfrmCadProdutos.btnGravarClick(Sender: TObject);
begin
  if edtProdutoId.Text <> EmptyStr then
    oProduto.codigo := StrToInt(edtProdutoId.Text)
  else
    oProduto.codigo := 0;

  oProduto.nome := edtNome.Text;
  oProduto.descricao := edtDescricao.Text;
  oProduto.valor := edtValor.Value;
  oProduto.quantidade := edtQuantidade.Value;
  oProduto.categoriaId := lkpCategoria.KeyValue;

  inherited;
end;

procedure TfrmCadProdutos.btnNovoClick(Sender: TObject);
begin
  inherited;
  edtNome.SetFocus;
end;

procedure TfrmCadProdutos.spdbtnIncluirClick(Sender: TObject);
begin
  inherited;
  TFuncao.CriarForm(TfrmCadCategorias, oUsuarioLogado, dtmPrincipal.ConexaoDB);
  qryCategoria.Refresh;
end;

procedure TfrmCadProdutos.spdbtnPesquisarClick(Sender: TObject);
begin
  inherited;
  try
    frmConCategoria := TfrmConCategoria.Create(Self);

    if lkpCategoria.KeyValue <> Null then
      frmConCategoria.aIniciarPesquisaId := lkpCategoria.KeyValue;

    frmConCategoria.ShowModal;

    if frmConCategoria.aRetornarIdSelecionado <> Unassigned then
      lkpCategoria.KeyValue := frmConCategoria.aRetornarIdSelecionado;
  finally
    frmConCategoria.Release;
  end;
end;

{$ENDREGION}
{$REGION 'Form events'}

procedure TfrmCadProdutos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  qryCategoria.Close;
  if Assigned(oProduto) then
    FreeAndNil(oProduto);
end;

procedure TfrmCadProdutos.FormCreate(Sender: TObject);
begin
  inherited;
  oProduto := TProduto.Create(dtmPrincipal.ConexaoDB);
  IndiceAtual := 'nome';
end;

procedure TfrmCadProdutos.FormShow(Sender: TObject);
begin
  inherited;
  if qryCategoria.SQL.Text <> EmptyStr then
    qryCategoria.Open;
end;

{$ENDREGION}

end.
