unit uLogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, cCadUsuario,
  uDTMConexao;

type
  TfrmLogin = class(TForm)
    btnSair: TBitBtn;
    btnAcessar: TBitBtn;
    lblUsuario: TLabel;
    lblSenha: TLabel;
    edtUsuario: TEdit;
    edtSenha: TEdit;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormShow(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure btnAcessarClick(Sender: TObject);
  private
    { Private declarations }
    Fechar: Boolean;
    oUsuario : TUsuario;
  public
    { Public declarations }
  end;

var
  frmLogin: TfrmLogin;

implementation

uses uPrincipal;

{$R *.dfm}

{$REGION 'Form events'}

procedure TfrmLogin.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := Fechar;
end;

procedure TfrmLogin.FormShow(Sender: TObject);
begin
  Fechar := False;
end;

{$ENDREGION}
{$REGION 'Buttons events'}

procedure TfrmLogin.btnAcessarClick(Sender: TObject);
begin
  try
    oUsuario := TUsuario.Create(dtmPrincipal.ConexaoDB);
    if oUsuario.Logar(edtUsuario.Text, edtSenha.Text) then
    begin
      oUsuarioLogado.codigo := oUsuario.codigo;
      oUsuarioLogado.nome := oUsuario.nome;
      OusuarioLogado.senha := oUsuario.senha;
      Fechar := True;
      Close;
    end
    else
    begin
      MessageDlg('Usuário invállido.', mtInformation, [mbOk],  0);
      edtUsuario.SetFocus;
    end;
  finally
    if Assigned(oUsuario) then
      FreeAndNil(oUsuario);
  end;
end;

procedure TfrmLogin.btnSairClick(Sender: TObject);
begin
  Fechar := True;
  Application.Terminate;
end;

{$ENDREGION}

end.
