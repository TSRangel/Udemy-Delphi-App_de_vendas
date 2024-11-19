unit uCadUsuarios;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uTelaHeranca, Data.DB,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.Buttons, Vcl.DBCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Mask,
  Vcl.ExtCtrls, Vcl.ComCtrls, cCadUsuario, uEnum, uDTMConexao;

type
  TfrmCadUsuarios = class(TfrmTelaHeranca)
    qryListagemusuarioId: TFDAutoIncField;
    qryListagemnome: TStringField;
    qryListagemsenha: TStringField;
    edtUsuarioId: TLabeledEdit;
    edtNome: TLabeledEdit;
    edtSenha: TLabeledEdit;
    procedure btnAlterarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    oUsuario: TUsuario;
    function Gravar(EstadoDoCadastro: TEstadoDoCadastro): Boolean; override;
    function Apagar: Boolean; override;
  public
    { Public declarations }
  end;

var
  frmCadUsuarios: TfrmCadUsuarios;

implementation

uses cAcaoAcesso;

{$R *.dfm}

{$REGION 'Overrides'}

function TfrmCadUsuarios.Apagar: Boolean;
begin
  if oUsuario.Selecionar(StrToInt(qryListagem.FieldByName('usuarioId').Text)) then
    Result := oUsuario.Apagar
  else
    Result := False;
end;

function TfrmCadUsuarios.Gravar(EstadoDoCadastro: TEstadoDoCadastro) : Boolean;
begin
  if EstadoDoCadastro = ecInserir then
    Result:= oUsuario.Inserir
  else if EstadoDoCadastro = ecAlterar then
    Result:= oUsuario.Atualizar;

  TAcaoAcesso.PreencherUsuariosAcoes(dtmPrincipal.ConexaoDB);
end;

{$ENDREGION}
{$REGION 'Buttons events'}

procedure TfrmCadUsuarios.btnAlterarClick(Sender: TObject);
begin
  if oUsuario.Selecionar(qryListagem.FieldByName('usuarioId').AsInteger) then
  begin
    edtUsuarioId.Text := IntToStr(oUsuario.codigo);
    edtNome.Text := oUsuario.nome;
    edtSenha.Text := oUsuario.senha;
  end
  else
  begin
    btnCancelar.Click;
    Abort;
  end;

  inherited;
end;

procedure TfrmCadUsuarios.btnGravarClick(Sender: TObject);
begin
  if oUsuario.UsuarioExiste(edtNome.Text) then
  begin
    MessageDlg('Usuário já cadastrado', mtInformation, [mbOk], 0);
    edtNome.SetFocus;
    Abort;
  end;

  if edtUsuarioId.Text <> EmptyStr then
    oUsuario.codigo := StrToInt(edtUsuarioId.Text)
  else
    oUsuario.codigo := 0;

  oUsuario.nome := edtNome.Text;
  oUsuario.senha := edtSenha.Text;

  inherited;
end;

procedure TfrmCadUsuarios.btnNovoClick(Sender: TObject);
begin
  inherited;
  edtNome.SetFocus;
end;

{$ENDREGION}
{$REGION 'Form events'}

procedure TfrmCadUsuarios.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  if Assigned(oUsuario) then
    FreeAndNil(oUsuario);
end;

procedure TfrmCadUsuarios.FormCreate(Sender: TObject);
begin
  inherited;
  oUsuario := TUsuario.Create(dtmPrincipal.ConexaoDB);
  IndiceAtual := 'nome';
end;

{$ENDREGION}

end.
