unit cAcaoAcesso;

interface

uses System.Classes, System.SysUtils, Vcl.Controls, Vcl.ExtCtrls, Vcl.Dialogs,
  Vcl.Forms, Vcl.Buttons, FireDAC.Comp.Client, FireDAC.Stan.Param;

type
  TAcaoAcesso = class
  private
    ConexaoDB: TFDConnection;
    F_acaoAcessoId: Integer;
    F_descricao: String;
    F_chave: String;
    class procedure PreencherAcoes(Form: TForm; Conexao: TFDConnection); static;
    class procedure VerificarUsuarioAcao(UsuarioId, AcaoAcessoId: Integer;
      Conexao: TFDConnection); static;
  public
    constructor Create(Conexao: TFDConnection);
    destructor Destroy; override;
    function Inserir: Boolean;
    function Atualizar: Boolean;
    function Apagar: Boolean;
    function Selecionar(Id: Integer): Boolean;
    function ChaveExiste(Chave: String; Id: Integer = 0): Boolean;
    class procedure CriarAcoes(NomeForm: TFormClass;
      Conexao: TFDConnection); static;
    class procedure PreencherUsuariosAcoes(Conexao : TFDConnection); static;
  published
    property codigo: Integer read F_acaoAcessoId write F_acaoAcessoId;
    property descricao: String read F_descricao write F_descricao;
    property Chave: String read F_chave write F_chave;
  end;

var
  Qry: TFDQuery;

implementation

{ TAcaoAcesso }

{$REGION 'Constructor and Destructor'}

constructor TAcaoAcesso.Create(Conexao: TFDConnection);
begin
  ConexaoDB := Conexao;
end;

destructor TAcaoAcesso.Destroy;
begin
  inherited;
end;

{$ENDREGION}
{$REGION 'CRUD Functions'}

function TAcaoAcesso.Inserir: Boolean;
begin
  try
    Result := True;
    Qry := TFDQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('insert into acaoAcesso (descricao, chave) values ' +
      '(:descricao, :chave)');
    Qry.ParambyName('descricao').AsString := Self.F_descricao;
    Qry.ParambyName('chave').AsString := Self.F_chave;

    try
      ConexaoDB.StartTransaction;
      Qry.ExecSQL;
      ConexaoDB.Commit;
    except
      ConexaoDB.Rollback;
      Result := False;
    end;

  finally
    if Assigned(Qry) then
      FreeAndNil(Qry);
  end;
end;

function TAcaoAcesso.Atualizar: Boolean;
begin
  try
    Result := True;
    Qry := TFDQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('update acaoacesso set descricao = :descricao, ' +
      'chave = :chave where acaoAcessoId = :Id');
    Qry.ParambyName('descricao').AsString := Self.F_descricao;
    Qry.ParambyName('chave').AsString := Self.F_chave;
    Qry.ParambyName('Id').AsInteger := Self.F_acaoAcessoId;

    try
      ConexaoDB.StartTransaction;
      Qry.ExecSQL;
      ConexaoDB.Commit;
    except
      ConexaoDB.Rollback;
      Result := False;
    end;

  finally
    if Assigned(Qry) then
      FreeAndNil(Qry);
  end;
end;

function TAcaoAcesso.Apagar: Boolean;
begin
  if MessageDlg('Apagar o registro: ' + #13 + #13 + 'Código: ' +
    IntToStr(F_acaoAcessoId) + #13 + 'Descrição: ' + F_descricao,
    mtCOnfirmation, [mbYes, mbNo], 0) = mrNo then
  begin
    Result := False;
    Abort;
  end;

  try
    Result := True;
    Qry := TFDQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('delete from acaoacesso where acaoAcessoId = :Id');
    Qry.ParambyName('Id').AsInteger := Self.F_acaoAcessoId;

    try
      ConexaoDB.StartTransaction;
      Qry.ExecSQL;
      ConexaoDB.Commit;
    except
      ConexaoDB.Rollback;
      Result := False
    end;

  finally
    if Assigned(Qry) then
      FreeAndNil(Qry);
  end;
end;

function TAcaoAcesso.Selecionar(Id: Integer): Boolean;
begin
  try
    Result := True;
    Qry := TFDQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('select acaoAcessoId, descricao, chave from acaoacesso ' +
      'where acaoAcessoId = :Id');
    Qry.ParambyName('Id').AsInteger := Id;

    try
      Qry.Open;

      Self.F_acaoAcessoId := Qry.FieldByName('acaoAcessoId').AsInteger;
      Self.F_descricao := Qry.FieldByName('descricao').AsString;
      Self.F_chave := Qry.FieldByName('chave').AsString;
    except
      Result := False
    end;

  finally
    if Assigned(Qry) then
      FreeAndNil(Qry);
  end;
end;

{$ENDREGION}
{$REGION 'Functions and Procedures'}

function TAcaoAcesso.ChaveExiste(Chave: String; Id: Integer = 0): Boolean;
begin
  try
    Result := True;
    Qry := TFDQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('select count(acaoAcessoId) as qtde from acaoacesso ' +
      'where chave = :chave');

    if Id > 0 then
    begin
      Qry.SQL.Add('and acaoAcessoId <> :acaoAcessoId');
      Qry.ParambyName('acaoAcessoId').AsInteger := Id;
    end;

    Qry.ParambyName('chave').AsString := Chave;

    try
      Qry.Open;

      if not(Qry.FieldByName('qtde').AsInteger > 0) then
        Result := False;

    except
      Result := False;
    end;
  finally
    if Assigned(Qry) then
      FreeAndNil(Qry);
  end;
end;

class procedure TAcaoAcesso.PreencherAcoes(Form: TForm; Conexao: TFDConnection);
var
  I: Integer;
  oAcaoAcesso: TAcaoAcesso;
begin
  try
    oAcaoAcesso := TAcaoAcesso.Create(Conexao);
    oAcaoAcesso.descricao := Form.Caption;
    oAcaoAcesso.Chave := Form.Name;

    if not oAcaoAcesso.ChaveExiste(oAcaoAcesso.Chave) then
      oAcaoAcesso.Inserir;

    for I := 0 to Form.ComponentCount - 1 do
    begin
      if Form.Components[I] is TBitBtn then
      begin
        if TBitBtn(Form.Components[I]).Tag = 99 then
        begin
          oAcaoAcesso.descricao := '    - BOTÃO ' +
            StringReplace(TBitBtn(Form.Components[I]).Caption, '&', '',
            [rfReplaceAll]);
          oAcaoAcesso.Chave := Form.Name + '_' +
            TBitBtn(Form.Components[I]).Name;

          if not oAcaoAcesso.ChaveExiste(oAcaoAcesso.Chave) then
            oAcaoAcesso.Inserir;
        end;
      end;
    end;

  finally
    if Assigned(oAcaoAcesso) then
      FreeAndNil(oAcaoAcesso);
  end;
end;

class procedure TAcaoAcesso.CriarAcoes(NomeForm: TFormClass;
  Conexao: TFDConnection);
var
  Form: TForm;
begin
  try
    Form := NomeForm.Create(Application);
    PreencherAcoes(Form, Conexao);
  finally
    if Assigned(Form) then
      Form.Release;
  end;
end;

class procedure TAcaoAcesso.VerificarUsuarioAcao(UsuarioId,
  AcaoAcessoId: Integer; Conexao: TFDConnection);
begin
  try
    Qry := TFDQuery.Create(nil);
    Qry.Connection := Conexao;
    Qry.SQL.Clear;
    Qry.SQL.Add('select usuarioId from usuarioacaoacesso ' +
    'where usuarioId = :usuarioId and acaoAcessoId = :acaoAcessoId');
    Qry.ParambyName('usuarioId').AsInteger := UsuarioId;
    Qry.ParamByName('acaoAcessoId').AsInteger := AcaoAcessoId;
    Qry.Open;

    if Qry.IsEmpty then
    begin
      Qry.Close;
      Qry.SQl.Clear;
      Qry.SQL.Add('insert into usuarioacaoacesso (usuarioId, acaoAcessoId, ' +
      'ativo) values (:usuarioId, :acaoAcessoId, :ativo)');
      Qry.ParamByName('usuarioId').AsInteger := UsuarioId;
      Qry.ParamByName('acaoAcessoId').AsInteger := AcaoAcessoId;
      Qry.ParamByName('ativo').AsBoolean := True;
      try
        Conexao.StartTransaction;
        Qry.ExecSQL;
        Conexao.Commit;
      except
        Conexao.Rollback;
      end;
    end;

  finally
    if Assigned(Qry) then
      FreeAndNil(Qry);
  end;
end;

class procedure TAcaoAcesso.PreencherUsuariosAcoes(Conexao : TFDConnection);
var QryAcaoAcesso : TFDQuery;
    QryUsuario : TFDQuery;
begin
  try
    QryUsuario := TFDQuery.Create(nil);
    QryUsuario.Connection := Conexao;
    QryUsuario.SQL.Clear;
    QryUsuario.SQL.Add('select usuarioId from usuarios');
    QryUsuario.Open;

    QryAcaoAcesso := TFDQuery.Create(nil);
    QryAcaoAcesso.Connection := Conexao;
    QryAcaoAcesso.SQL.Clear;
    QryAcaoAcesso.SQL.Add('select acaoAcessoId from acaoacesso');
    QryAcaoAcesso.Open;

    QryUsuario.First;
    while not QryUsuario.Eof do
    begin
      QryAcaoAcesso.First;
      while not QryAcaoAcesso.Eof do
      begin
        VerificarUsuarioAcao(QryUsuario.FieldByName('usuarioId').AsInteger,
        QryAcaoAcesso.FieldByName('acaoAcessoId').AsInteger, Conexao);
        QryAcaoAcesso.Next;
      end;

      QryUsuario.Next;
    end;
  finally
    if Assigned(QryUsuario) then
      FreeAndNil(QryUsuario);
    if Assigned(QryAcaoAcesso) then
      FreeAndNil(QryAcaoAcesso);
  end;
end;

{$ENDREGION}

end.
