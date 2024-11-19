unit uCadClientes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uTelaHeranca, Data.DB,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.Buttons, Vcl.DBCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Mask,
  Vcl.ExtCtrls, Vcl.ComCtrls, RxToolEdit, cCadCliente, uEnum, uDTMConexao;

type
  TfrmCadClientes = class(TfrmTelaHeranca)
    edtClienteId: TLabeledEdit;
    edtNome: TLabeledEdit;
    edtCEP: TMaskEdit;
    lblCEP: TLabel;
    edtEndereco: TLabeledEdit;
    edtBairro: TLabeledEdit;
    edtCidade: TLabeledEdit;
    edtTelefone: TMaskEdit;
    lblTelefone: TLabel;
    edtEmail: TLabeledEdit;
    edtDataNascimento: TDateEdit;
    Label1: TLabel;
    qryListagemclienteId: TFDAutoIncField;
    qryListagemnome: TStringField;
    qryListagemendereco: TStringField;
    qryListagemcidade: TStringField;
    qryListagembairro: TStringField;
    qryListagemestado: TStringField;
    qryListagemcep: TStringField;
    qryListagemtelefone: TStringField;
    qryListagememail: TStringField;
    qryListagemdataNascimento: TDateTimeField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnNovoClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
  private
    { Private declarations }
    oCliente: TCliente;
    function Apagar: Boolean; override;
    function Gravar(EstadoDoCadastro: TEstadoDoCadastro): Boolean; override;
  public
    { Public declarations }
  end;

var
  frmCadClientes: TfrmCadClientes;

implementation

{$R *.dfm}
{$REGION 'Override'}

function TfrmCadClientes.Apagar: Boolean;
begin
  if oCliente.Selecionar(qryListagem.FieldByName('clienteId').AsInteger) then
    Result := oCliente.Apagar;
end;

function TfrmCadClientes.Gravar(EstadoDoCadastro: TEstadoDoCadastro): Boolean;
begin
  if (EstadoDoCadastro = ecInserir) then
    Result:= oCliente.Inserir
  else if (EstadoDoCadastro = ecAlterar) then
    Result:= oCliente.Atualizar;
end;
{$ENDREGION}
{$REGION 'Buttons events'}

procedure TfrmCadClientes.btnAlterarClick(Sender: TObject);
begin
  inherited;
  if oCliente.Selecionar(qryListagem.FieldByName('clienteId').AsInteger) then
    begin
      edtClienteId.Text := IntToStr(oCliente.codigo);
      edtNome.Text := oCliente.nome;
      edtEndereco.Text := oCliente.endereco;
      edtCidade.Text := oCliente.cidade;
      edtBairro.Text := oCliente.bairro;
      edtCep.Text := oCliente.cep;
      edtTelefone.Text := oCliente.telefone;
      edtEmail.Text := oCliente.email;
      edtDataNascimento.Date := oCliente.dataNascimento;
    end
  else
  begin
    btnCancelar.Click;
    Abort;
  end;
end;

procedure TfrmCadClientes.btnGravarClick(Sender: TObject);
begin
  if edtClienteId.Text <> EmptyStr then
    oCliente.codigo := StrToInt(edtClienteId.Text)
  else
  oCliente.codigo := 0;

  oCliente.nome := edtNome.Text;
  oCliente.endereco := edtEndereco.Text;
  oCliente.cidade := edtCidade.Text;
  oCliente.bairro := edtBairro.Text;
  oCliente.cep := edtCep.Text;
  oCliente.telefone := edtTelefone.Text;
  oCliente.email := edtEmail.Text;
  oCliente.dataNascimento := edtDataNascimento.Date;

  inherited;
end;

procedure TfrmCadClientes.btnNovoClick(Sender: TObject);
begin
  inherited;
  edtDataNascimento.Date := Date;
  edtNome.SetFocus;
end;

{$ENDREGION}
{$REGION 'Form events'}

procedure TfrmCadClientes.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  if Assigned(oCliente) then
    FreeAndNil(oCliente);
end;

procedure TfrmCadClientes.FormCreate(Sender: TObject);
begin
  inherited;
  oCliente:= TCliente.Create(dtmPrincipal.ConexaoDB);
  IndiceAtual:= 'nome'
end;

{$ENDREGION}
end.
