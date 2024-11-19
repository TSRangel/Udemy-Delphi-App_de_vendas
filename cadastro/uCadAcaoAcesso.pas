unit uCadAcaoAcesso;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uTelaHeranca, Data.DB,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.Buttons, Vcl.DBCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Mask,
  Vcl.ExtCtrls, Vcl.ComCtrls, cAcaoAcesso, uEnum, uDTMConexao;

type
  TfrmCadAcaoAcesso = class(TfrmTelaHeranca)
    qryListagemacaoAcessoId: TFDAutoIncField;
    qryListagemdescricao: TStringField;
    qryListagemchave: TStringField;
    edtAcaoAcessoId: TLabeledEdit;
    edtDescricao: TLabeledEdit;
    edtChave: TLabeledEdit;
    procedure btnAlterarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnNovoClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    oAcaoAcesso : TAcaoAcesso;
    function Gravar(EstadoDoCadastro: TEstadoDoCadastro): Boolean; override;
    function Apagar: Boolean; override;
  end;

var
  frmCadAcaoAcesso: TfrmCadAcaoAcesso;

implementation

{$R *.dfm}

{$REGION 'Overrides'}

function TfrmCadAcaoAcesso.Gravar(EstadoDoCadastro: TEstadoDoCadastro): Boolean;
begin
  if EstadoDoCadastro = ecInserir then
    Result := oAcaoAcesso.Inserir
  else if EstadoDoCadastro = ecAlterar then
    Result := oAcaoAcesso.Atualizar;
end;

function TfrmCadAcaoAcesso.Apagar: Boolean;
begin
  if oAcaoAcesso.Selecionar(qryListagem.FieldByName('acaoAcessoId').AsInteger) then
    Result := oAcaoAcesso.Apagar;
end;

{$ENDREGION}
{$REGION 'Buttons events'}

procedure TfrmCadAcaoAcesso.btnNovoClick(Sender: TObject);
begin
  inherited;
  edtDescricao.SetFocus;
end;


procedure TfrmCadAcaoAcesso.btnAlterarClick(Sender: TObject);
begin
  if oAcaoAcesso.Selecionar(qryListagem.FieldByName('acaoAcessoId').AsInteger) then
  begin
    edtAcaoAcessoId.Text := IntToStr(oAcaoAcesso.codigo);
    edtDescricao.Text := oAcaoAcesso.descricao;
    edtChave.Text := oAcaoAcesso.chave;
  end
  else
  begin
    btnCancelar.Click;
    Abort;
  end;

  inherited;
end;

procedure TfrmCadAcaoAcesso.btnGravarClick(Sender: TObject);
begin

  if edtAcaoAcessoId.Text <> EmptyStr then
    oAcaoAcesso.codigo := StrToInt(edtAcaoAcessoId.Text)
  else
    oAcaoAcesso.codigo := 0;

  oAcaoAcesso.descricao := edtDescricao.Text;
  oAcaoAcesso.chave := edtChave.Text;

  if (oAcaoAcesso.ChaveExiste(edtChave.Text, oAcaoAcesso.codigo)) then
  begin
    MessageDlg('Chave j� cadastrada', mtInformation, [mbOk], 0);
    edtChave.SetFocus;
    Abort;
  end;

  inherited;
end;

{$ENDREGION}
{$REGION 'Form events'}

procedure TfrmCadAcaoAcesso.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  if Assigned(oAcaoAcesso) then
    FreeAndNil(oAcaoAcesso);
end;

procedure TfrmCadAcaoAcesso.FormCreate(Sender: TObject);
begin
  inherited;
  oAcaoAcesso := TAcaoAcesso.Create(dtmPrincipal.ConexaoDB);
  IndiceAtual := 'descricao';
end;

{$ENDREGION}

end.
