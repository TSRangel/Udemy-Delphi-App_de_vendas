unit ualterarSenha;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons;

type
  TfrmAlterarSenha = class(TForm)
    lblNovaSenha: TLabel;
    lblConfirmacao: TLabel;
    edtSenhaNova: TEdit;
    edtConfirmacao: TEdit;
    lblSenhaAtual: TLabel;
    edtSenhaAtual: TEdit;
    btnSair: TBitBtn;
    btnAlterar: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
  private
    { Private declarations }
    procedure LimparEdits;
  public
    { Public declarations }
  end;

var
  frmAlterarSenha: TfrmAlterarSenha;

implementation

{$R *.dfm}

uses cCadUsuario, uPrincipal, uDTMConexao;

{$REGION 'Form events'}

procedure TfrmAlterarSenha.FormShow(Sender: TObject);
begin
  LimparEdits;
end;

{$ENDREGION}
{$REGION 'Functions and Procedures'}

procedure TfrmAlterarSenha.LimparEdits;
begin
  edtSenhaAtual.Clear;
  edtSenhaNova.Clear;
  edtConfirmacao.Clear;
end;

{$ENDREGION}
{$REGION 'Buttons events'}

procedure TfrmAlterarSenha.btnAlterarClick(Sender: TObject);
var oUsuario : TUsuario;
begin
  if (edtSenhaAtual.Text = oUsuarioLogado.senha) then
  begin
    if (edtSenhaNova.Text = edtConfirmacao.Text) then
    begin
      try
        oUsuario := TUsuario.Create(dtmPrincipal.ConexaoDB);
        oUsuario.codigo := oUsuarioLogado.codigo;
        oUsuario.senha := edtSenhaNova.Text;
        oUsuario.AlterarSenha;
        oUsuarioLogado.senha := edtSenhaNova.Text;
        MessageDlg('Senha alterada.', mtInformation, [mbOk], 0);
        LimparEdits;
      finally
        FreeAndNil(oUsuario);
      end;
    end
    else
    begin
      MessageDlg('Senhas digitadas não coincidem.', mtInformation, [mbOk], 0);
      edtSenhaNova.SetFocus;
    end;
  end
  else
    MessageDlg('Senha atual está inválida.', mtInformation, [mbOk], 0);
end;

procedure TfrmAlterarSenha.btnSairClick(Sender: TObject);
begin
  Close;
end;

{$ENDREGION}

end.
