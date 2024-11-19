unit uAcoesPorUsuario;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Data.DB,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.Grids, Vcl.DBGrids, uDTMConexao, Vcl.StdCtrls, Vcl.Buttons;

type
  TfrmAcoesPorUsuario = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Splitter1: TSplitter;
    grdUsuarios: TDBGrid;
    grdAcoes: TDBGrid;
    qryAcoes: TFDQuery;
    qryUsuarios: TFDQuery;
    dtsAcoes: TDataSource;
    dtsUsuarios: TDataSource;
    qryUsuariosusuarioId: TFDAutoIncField;
    qryUsuariosnome: TStringField;
    qryAcoesusuarioId: TIntegerField;
    qryAcoesacaoAcessoId: TIntegerField;
    qryAcoesdescricao: TStringField;
    qryAcoesativo: TBooleanField;
    btnFechar: TBitBtn;
    procedure btnFecharClick(Sender: TObject);
    procedure qryUsuariosAfterScroll(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure grdAcoesDblClick(Sender: TObject);
    procedure grdAcoesDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    { Private declarations }
    procedure SelecionarAcoesAcessoPorUsuario;
  public
    { Public declarations }
  end;

var
  frmAcoesPorUsuario: TfrmAcoesPorUsuario;

implementation

{$R *.dfm}
{$REGION 'Form events'}

procedure TfrmAcoesPorUsuario.FormShow(Sender: TObject);
begin
  try
    qryUsuarios.DisableControls;
    qryUsuarios.Open;
    SelecionarAcoesAcessoPorUsuario;
  finally
    qryUsuarios.EnableControls;
  end;
end;

{$ENDREGION}
{$REGION 'Buttons events'}

procedure TfrmAcoesPorUsuario.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmAcoesPorUsuario.grdAcoesDblClick(Sender: TObject);
var
  Qry: TFDQuery;
  bmRegistroAtual : TBookmark;
begin
  try
    bmRegistroAtual := QryAcoes.GetBookmark;
    Qry := TFDQuery.Create(nil);
    Qry.Connection := dtmPrincipal.ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('update usuarioacaoacesso set ativo = :ativo where ' +
      'usuarioId = :usuarioId and acaoAcessoId = :acaoAcessoId');
    Qry.ParamByName('usuarioId').AsInteger := qryAcoes.FieldByName('usuarioId')
      .AsInteger;
    Qry.ParamByName('acaoAcessoId').AsInteger :=
      qryAcoes.FieldByName('acaoAcessoId').AsInteger;
    Qry.ParamByName('ativo').AsBoolean := not qryAcoes.FieldByName('ativo')
      .AsBoolean;

    try
      dtmPrincipal.ConexaoDB.StartTransaction;
      Qry.ExecSQL;
      dtmPrincipal.ConexaoDB.Commit;
    except
      dtmPrincipal.ConexaoDB.Rollback;
    end;
  finally
    SelecionarAcoesAcessoPorUsuario;
    QryAcoes.GotoBookmark(bmRegistroAtual);
    if Assigned(Qry) then
      FreeAndNil(Qry);
  end;
end;

procedure TfrmAcoesPorUsuario.grdAcoesDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if not qryAcoes.FieldByName('ativo').AsBoolean then
  begin
    TDBGrid(Sender).Canvas.Font.Color := clWhite;
    TDBGrid(Sender).Canvas.Brush.Color := clRed;
  end;
  TDBGrid(Sender).DefaultDrawDataCell(Rect, TDBGrid(Sender).Columns[DataCol]
    .Field, State);
end;

procedure TfrmAcoesPorUsuario.qryUsuariosAfterScroll(DataSet: TDataSet);
begin
  SelecionarAcoesAcessoPorUsuario;
end;

{$ENDREGION}
{$REGION 'Functions and Procedures'}

procedure TfrmAcoesPorUsuario.SelecionarAcoesAcessoPorUsuario;
begin
  qryAcoes.Close;
  qryAcoes.ParamByName('usuarioId').AsInteger :=
    qryUsuarios.FieldByName('usuarioId').AsInteger;
  qryAcoes.Open;
end;

{$ENDREGION}

end.
