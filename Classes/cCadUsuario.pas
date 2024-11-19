unit cCadUsuario;

interface

uses System.Classes, System.SysUtils, Vcl.Controls, Vcl.ExtCtrls, Vcl.Dialogs,
  FireDAC.Comp.Client, FireDAC.Stan.Param, uFuncaoCriptografia;

type
  TUsuario = class
  private
    ConexaoDB: TFDConnection;
    F_usuarioId: Integer;
    F_nome: String;
    F_senha: String;
    function getSenha: String;
    procedure setSenha(const Value: String);
  public
    constructor Create(Conexao: TFDConnection);
    destructor Destroy; override;
    function Inserir: Boolean;
    function Atualizar: Boolean;
    function Apagar: Boolean;
    function Selecionar(Id: Integer): Boolean;
    function Logar(Usuario, Senha: String): Boolean;
    function UsuarioExiste(Usuario: String): Boolean;
    function AlterarSenha: Boolean;
  published
    property codigo: Integer read F_usuarioId write F_usuarioId;
    property nome: String read F_nome write F_nome;
    property Senha: String read getSenha write setSenha;
  end;

var
  Qry: TFDQuery;

implementation

{$REGION 'Constructor and Destructor'}

constructor TUsuario.Create(Conexao: TFDConnection);
begin
  ConexaoDB := Conexao;
end;

destructor TUsuario.Destroy;
begin
  inherited;
end;

{$ENDREGION}
{$REGION 'CRUD Functions'}

function TUsuario.Inserir: Boolean;
begin
  try
    Result := True;
    Qry := TFDQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('insert into usuarios (nome, senha) values (:nome, :senha)');
    Qry.ParamByName('nome').AsString := Self.F_nome;
    Qry.ParamByName('senha').AsString := Self.F_senha;

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

function TUsuario.Atualizar: Boolean;
begin
  try
    Result := True;
    Qry := TFDQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('update usuarios set nome = :nome, senha = :senha where ' +
      'usuarioId = :usuarioId');
    Qry.ParamByName('nome').AsString := Self.F_nome;
    Qry.ParamByName('senha').AsString := Self.F_senha;
    Qry.ParamByName('usuarioId').AsInteger := Self.F_usuarioId;

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

function TUsuario.Apagar: Boolean;
begin
  if MessageDlg('Apagar o registro: ' + #13 + #13 + 'Código: ' +
    IntToStr(Self.F_usuarioId) + #13 + 'Nome: ' + Self.F_nome, mtConfirmation,
    [mbYes, mbNo], 0) = mrNo then
  begin
    Result := False;
    Abort;
  end;

  try
    Result := True;
    Qry := TFDQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('delete from usuarios where usuarioId = :usuarioId');
    Qry.ParamByName('usuarioId').AsInteger := Self.F_usuarioId;

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

function TUsuario.Selecionar(Id: Integer): Boolean;
begin
  try
    Result := True;
    Qry := TFDQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('select usuarioId, nome, senha from usuarios where usuarioId = '
      + ':usuarioId');
    Qry.ParamByName('usuarioId').AsInteger := Id;
    try
      Qry.Open;

      Self.F_usuarioId := Qry.FieldByName('usuarioId').AsInteger;
      Self.F_nome := Qry.FieldByName('nome').AsString;
      Self.F_senha := Qry.FieldByName('senha').AsString;
    except
      Result := False
    end;
  finally
    Qry.Close;
    if Assigned(Qry) then
      FreeAndNil(Qry);
  end;
end;

{$ENDREGION}
{$REGION 'Getters and Setters'}

procedure TUsuario.setSenha(const Value: string);
begin
  Self.F_senha := Criptografar(Value);
end;

function TUsuario.getSenha: string;
begin
  Result := Descriptografar(Self.F_senha);
end;

{$ENDREGION}
{$REGION 'Functions and Procedures'}

function TUsuario.Logar(Usuario, Senha: String): Boolean;
begin
  try
    Qry := TFDQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('select usuarioId, nome, senha from usuarios where nome = ' +
      ':nome and senha = :senha');
    Qry.ParamByName('nome').AsString := Usuario;
    Qry.ParamByName('senha').AsString := Criptografar(Senha);
    try
      Qry.Open;

      if Qry.FieldByName('usuarioId').AsInteger > 0 then
      begin
        Result := True;
        Self.F_usuarioId := Qry.FieldByName('usuarioId').AsInteger;
        Self.F_nome := Qry.FieldByName('nome').AsString;
        Self.F_senha := Qry.FieldByName('senha').AsString;
      end
      else
        Result := False;
    except
      Result := False;
    end;
  finally
    if Assigned(Qry) then
      FreeAndNil(Qry);
  end;
end;

function TUsuario.UsuarioExiste(Usuario: String): Boolean;
begin
  try
    Qry := TFDQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('select count(usuarioId) as qtde from usuarios where ' +
      'nome = :nome');
    Qry.ParamByName('nome').AsString := Usuario;
    try
      Qry.Open;

      if Qry.FieldByName('qtde').AsInteger > 0 then
        Result := True
      else
        Result := False;

    except
      Result := False;
    end;
  finally
    if Assigned(Qry) then
      FreeAndNil(Qry);
  end;
end;

function TUsuario.AlterarSenha: Boolean;
begin
  try
    Result := True;
    Qry := TFDQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add
      ('update usuarios set senha = :senha where usuarioId = :usuarioId');
    Qry.ParamByName('senha').AsString := Self.F_senha;
    Qry.ParamByName('usuarioId').AsInteger := Self.F_usuarioId;

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
{$ENDREGION}

end.
