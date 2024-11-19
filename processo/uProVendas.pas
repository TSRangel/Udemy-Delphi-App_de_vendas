unit uProVendas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uTelaHeranca, Data.DB,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.Buttons, Vcl.DBCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Mask,
  Vcl.ExtCtrls, Vcl.ComCtrls, uDTMConexao, uDTMVenda, RxToolEdit, RxCurrEdit,
  cProVenda, uEnum, uRelProcessoDeVenda;

type
  TfrmProVenda = class(TfrmTelaHeranca)
    qryListagemvendaId: TFDAutoIncField;
    qryListagemclienteId: TIntegerField;
    qryListagemnome: TStringField;
    qryListagemdataVenda: TDateTimeField;
    qryListagemtotalVenda: TFMTBCDField;
    edtVendaId: TLabeledEdit;
    lkpCliente: TDBLookupComboBox;
    lblCliente: TLabel;
    ldlDataVenda: TLabel;
    edtDataVenda: TDateEdit;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    lblValorDaVenda: TLabel;
    edtValorTotal: TCurrencyEdit;
    dbgridItensVendas: TDBGrid;
    lkpProduto: TDBLookupComboBox;
    lblProduto: TLabel;
    edtValorUnitario: TCurrencyEdit;
    edtQuantidade: TCurrencyEdit;
    edtTotalProduto: TCurrencyEdit;
    btnAdicionarItem: TBitBtn;
    btnApagarItem: TBitBtn;
    lblValorUnitario: TLabel;
    lblQuantidade: TLabel;
    lblTotalDoProduto: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dbgridItensVendasKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnAdicionarItemClick(Sender: TObject);
    procedure lkpProdutoExit(Sender: TObject);
    procedure edtQuantidadeExit(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnApagarItemClick(Sender: TObject);
    procedure dbgridItensVendasDblClick(Sender: TObject);
  private
    { Private declarations }
    oVenda: TVenda;
    function Gravar(EstadoDoCadastro: TEstadoDoCadastro): Boolean; override;
    function Apagar: Boolean; override;
    function TotalizarProduto(valorUnitario, Quantidade: Double): Double;
    procedure LimparComponenteItem;
    procedure LimparCds;
    procedure CarregarRegistroSelecionado;
    function TotalizarVenda: Double;
  public
    { Public declarations }
  end;

var
  frmProVenda: TfrmProVenda;

implementation

{$R *.dfm}
{$REGION 'Form events'}

procedure TfrmProVenda.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  if Assigned(dtmVendas) then
    FreeAndNil(dtmVendas);
  if Assigned(oVenda) then
    FreeAndNil(oVenda);
end;

procedure TfrmProVenda.FormCreate(Sender: TObject);
begin
  inherited;
  dtmVendas := TdtmVendas.Create(Self);
  oVenda := TVenda.Create(dtmPrincipal.ConexaoDB);
  IndiceAtual := 'clienteId';
end;

procedure TfrmProVenda.dbgridItensVendasDblClick(Sender: TObject);
begin
  inherited;
  CarregarRegistroSelecionado;
end;

procedure TfrmProVenda.dbgridItensVendasKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  BloqueiaCTRL_DEL_DBGrid(Key, Shift);
end;

procedure TfrmProVenda.lkpProdutoExit(Sender: TObject);
begin
  inherited;
  if TDBLookupComboBox(Sender).KeyValue <> Null then
  begin
    edtValorUnitario.Value := dtmVendas.qryProdutos.FieldByName
      ('valor').AsFloat;
    edtQuantidade.Value := 1;
    edtValorTotal.Value := TotalizarProduto(edtValorUnitario.Value,
      edtQuantidade.Value);
  end;
end;

{$ENDREGION}
{$REGION 'Functions and procedures'}

function TfrmProVenda.TotalizarProduto(valorUnitario,
  Quantidade: Double): Double;
begin
  Result := valorUnitario * Quantidade;
end;

function TfrmProVenda.TotalizarVenda: Double;
begin
  Result := 0;
  dtmVendas.cdsItensVenda.First;
  while not dtmVendas.cdsItensVenda.Eof do
  begin
    Result := Result + dtmVendas.cdsItensVenda.FieldByName
      ('totalProduto').AsFloat;
    dtmVendas.cdsItensVenda.Next;
  end;
end;

procedure TfrmProVenda.LimparComponenteItem;
begin
  lkpProduto.KeyValue := Null;
  edtQuantidade.Value := 0;
  edtValorUnitario.Value := 0;
  edtTotalProduto.Value := 0;
end;

procedure TfrmProVenda.LimparCds;
begin
  dtmVendas.cdsItensVenda.First;
  while not dtmVendas.cdsItensVenda.Eof do
    dtmVendas.cdsItensVenda.Delete;
end;

procedure TfrmProVenda.CarregarRegistroSelecionado;
begin
  lkpProduto.KeyValue := dtmVendas.cdsItensVenda.FieldByName
    ('produtoId').AsString;
  edtQuantidade.Value := dtmVendas.cdsItensVenda.FieldByName
    ('quantidade').AsFloat;
  edtValorUnitario.Value := dtmVendas.cdsItensVenda.FieldByName
    ('valorUnitario').AsFloat;
  edtTotalProduto.Value := dtmVendas.cdsItensVenda.FieldByName
    ('totalProduto').AsFloat;
end;

{$ENDREGION}
{$REGION 'Override'}

function TfrmProVenda.Apagar: Boolean;
begin
  if oVenda.Selecionar(qryListagem.FieldByName('vendaId').AsInteger,
    dtmVendas.cdsItensVenda) then
    Result := oVenda.Apagar;
end;

function TfrmProVenda.Gravar(EstadoDoCadastro: TEstadoDoCadastro): Boolean;
begin
  if edtVendaId.Text <> EmptyStr then
    oVenda.vendaId := StrToInt(edtVendaId.Text)
  else
    oVenda.vendaId := 0;

  oVenda.clienteId := lkpCliente.KeyValue;
  oVenda.DataVenda := edtDataVenda.Date;
  oVenda.TotalVenda := edtValorTotal.Value;

  if (EstadoDoCadastro = ecInserir) then
    oVenda.vendaId := oVenda.Inserir(dtmVendas.cdsItensVenda)
  else if (EstadoDoCadastro = ecAlterar) then
    oVenda.Atualizar(dtmVendas.cdsItensVenda);

  frmRelProcessoDeVenda:= TfrmRelProcessoDeVenda.Create(Self);
  frmRelProcessoDeVenda.qryVenda.Close;
  frmRelProcessoDeVenda.qryVenda.ParamByName('vendaId').AsInteger:= oVenda.vendaId;
  frmRelProcessoDeVenda.qryVenda.Open;

  frmRelProcessoDeVenda.qryVendaItens.Close;
  frmRelProcessoDeVenda.qryVendaItens.ParamByName('vendaId').AsInteger:= oVenda.vendaId;
  frmRelProcessoDeVenda.qryVendaItens.Open;

  frmRelProcessoDeVenda.relatorio.PreviewModal;
  frmRelProcessoDeVenda.Release;

  Result:= True;
end;

{$ENDREGION}
{$REGION 'Button events'}

procedure TfrmProVenda.btnAlterarClick(Sender: TObject);
begin
  if oVenda.Selecionar(qryListagem.FieldByName('vendaId').AsInteger,
    dtmVendas.cdsItensVenda) then
  begin
    edtVendaId.Text := IntToStr(oVenda.vendaId);
    lkpCliente.KeyValue := oVenda.clienteId;
    edtDataVenda.Date := oVenda.DataVenda;
    edtValorTotal.Value := oVenda.TotalVenda;
  end
  else
  begin
    btnCancelar.Click;
    Abort;
  end;
  inherited;
end;

procedure TfrmProVenda.btnApagarItemClick(Sender: TObject);
begin
  inherited;
  if lkpProduto.KeyValue = Null then
  begin
    MessageDlg('Selecione o produto a ser excluido', mtInformation, [mbOk], 0);
    dbgridItensVendas.SetFocus;
    Abort;
  end;

  if dtmVendas.cdsItensVenda.Locate('produtoId', lkpProduto.KeyValue, []) then
  begin
    dtmVendas.cdsItensVenda.Delete;
    edtValorTotal.Value := TotalizarVenda;
    LimparComponenteItem;
  end;
end;

procedure TfrmProVenda.btnCancelarClick(Sender: TObject);
begin
  inherited;
  LimparCds;
end;

procedure TfrmProVenda.btnGravarClick(Sender: TObject);
begin
  inherited;
  LimparCds;
end;

procedure TfrmProVenda.btnNovoClick(Sender: TObject);
begin
  inherited;
  edtDataVenda.Date := Date;
  lkpCliente.SetFocus;
  LimparCds;
end;

procedure TfrmProVenda.edtQuantidadeExit(Sender: TObject);
begin
  inherited;
  edtTotalProduto.Value := TotalizarProduto(edtValorUnitario.Value,
    edtQuantidade.Value);
end;

procedure TfrmProVenda.btnAdicionarItemClick(Sender: TObject);
begin
  inherited;
  if lkpProduto.KeyValue = Null then
  begin
    MessageDlg('Produto é um campo obrigatório', mtInformation, [mbOk], 0);
    lkpProduto.SetFocus;
    Abort;
  end;
  if edtValorUnitario.Value <= 0 then
  begin
    MessageDlg('Valor unitário não pode ser zero', mtInformation, [mbOk], 0);
    Abort;
  end;
  if edtQuantidade.Value <= 0 then
  begin
    MessageDlg('Quantidade não pode ser zero', mtInformation, [mbOk], 0);
    Abort;
  end;

  if dtmVendas.cdsItensVenda.Locate('produtoId', lkpProduto.KeyValue, []) then
  begin
    MessageDlg('Este produto já foi selecionado', mtInformation, [mbOk], 0);
    lkpProduto.SetFocus;
    Abort;
  end;

  edtTotalProduto.Value := TotalizarProduto(edtValorUnitario.Value,
    edtQuantidade.Value);

  dtmVendas.cdsItensVenda.Append;
  dtmVendas.cdsItensVenda.FieldByName('produtoId').AsString :=
    lkpProduto.KeyValue;
  dtmVendas.cdsItensVenda.FieldByName('nomeProduto').AsString :=
    dtmVendas.qryProdutos.FieldByName('nome').AsString;
  dtmVendas.cdsItensVenda.FieldByName('quantidade').AsFloat :=
    edtQuantidade.Value;
  dtmVendas.cdsItensVenda.FieldByName('valorunitario').AsFloat :=
    edtValorUnitario.Value;
  dtmVendas.cdsItensVenda.FieldByName('totalProduto').AsFloat :=
    edtTotalProduto.Value;
  dtmVendas.cdsItensVenda.Post;
  edtValorTotal.Value := TotalizarVenda;
  LimparComponenteItem;
  lkpProduto.SetFocus;

end;

{$ENDREGION}

end.
