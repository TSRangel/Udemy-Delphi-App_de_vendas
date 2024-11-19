unit cCadCliente;

interface

uses System.Classes, System.SysUtils, Vcl.Controls, Vcl.ExtCtrls, Vcl.Dialogs,
  FireDAC.Comp.Client, FireDAC.Stan.Param;

type
  TCliente = class
  private
    ConexaoDB: TFDConnection;
    F_clienteId: Integer;
    F_nome: String;
    F_endereco: String;
    F_cidade: String;
    F_bairro: String;
    F_estado: String;
    F_cep: String;
    F_telefone: String;
    F_email: String;
    F_dataNascimento: TDateTime;

  public
    constructor Create(Conexao: TFDConnection);
    destructor Destroy; override;
    function Inserir: Boolean;
    function Atualizar: Boolean;
    function Apagar: Boolean;
    function Selecionar(Id: Integer): Boolean;
  published
    property codigo: Integer read F_clienteId write F_clienteId;
    property nome: String read F_nome write F_nome;
    property endereco: String read F_endereco write F_endereco;
    property cidade: String read F_cidade write F_cidade;
    property bairro: String read F_bairro write F_bairro;
    property estado: String read F_estado write F_estado;
    property cep: String read F_cep write F_cep;
    property telefone: String read F_telefone write F_telefone;
    property email: String read F_email write F_email;
    property dataNascimento: TDateTime read F_dataNascimento
      write F_dataNascimento;
  end;

var
  Qry: TFDQuery;

implementation

{ TCliente }

{$REGION 'Constructor and Destructor'}

constructor TCliente.Create(Conexao: TFDConnection);
begin
  ConexaoDB := Conexao;
end;

destructor TCliente.Destroy;
begin

  inherited;
end;

{$ENDREGION}
{$REGION 'CRUD Functions'}

function TCliente.Apagar: Boolean;
begin
  if MessageDlg('Apagar registro: ' + #13 + #13 + 'Código: ' +
    IntToStr(Self.F_clienteId) + #13 + 'Nome: ' + Self.F_nome, mtConfirmation,
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
    Qry.SQL.Add('delete from clientes where clienteId = :Id');
    Qry.ParamByName('Id').AsInteger := Self.F_clienteId;

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

function TCliente.Atualizar: Boolean;
begin
  try
    Result := True;
    Qry := TFDQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('update clientes set nome = :nome, ' + 'endereco = :endereco, '
      + 'cidade = :cidade, ' + 'bairro = :bairro, ' + 'estado = :estado, ' +
      'cep = :cep, ' + 'telefone = :telefone, ' + 'email = :email, ' +
      'dataNascimento = :dataNascimento where clienteId = :Id');
    Qry.ParamByName('Id').AsInteger := Self.F_clienteId;
    Qry.ParamByName('nome').AsString := Self.F_nome;
    Qry.ParamByName('endereco').AsString := Self.F_endereco;
    Qry.ParamByName('cidade').AsString := Self.F_cidade;
    Qry.ParamByName('bairro').AsString := Self.F_bairro;
    Qry.ParamByName('estado').AsString := Self.F_estado;
    Qry.ParamByName('cep').AsString := Self.F_cep;
    Qry.ParamByName('telefone').AsString := Self.F_telefone;
    Qry.ParamByName('email').AsString := Self.F_email;
    Qry.ParamByName('dataNascimento').AsDateTime := Self.F_dataNascimento;

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

function TCliente.Inserir: Boolean;
begin
  try
    Result := True;
    Qry := TFDQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('insert into clientes (nome, endereco, ' +
      'cidade, bairro, estado, cep , telefone, email, dataNascimento) ' +
      'values (:nome, :endereco, :cidade, :bairro, :estado, :cep, :telefone, ' +
      ':email, :dataNascimento)');
    Qry.ParamByName('nome').AsString := Self.F_nome;
    Qry.ParamByName('endereco').AsString := Self.F_endereco;
    Qry.ParamByName('cidade').AsString := Self.F_cidade;
    Qry.ParamByName('bairro').AsString := Self.F_bairro;
    Qry.ParamByName('estado').AsString := Self.F_estado;
    Qry.ParamByName('cep').AsString := Self.F_cep;
    Qry.ParamByName('telefone').AsString := Self.F_telefone;
    Qry.ParamByName('email').AsString := Self.F_email;
    Qry.ParamByName('dataNascimento').AsDateTime := Self.F_dataNascimento;

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

function TCliente.Selecionar(Id: Integer): Boolean;
begin
  try
    Result := True;
    Qry := TFDQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('select clienteId, nome, endereco, cidade, ' +
      'bairro, estado, cep, telefone, email, dataNascimento from clientes ' +
      'where clienteId = :Id');
    Qry.ParamByName('Id').AsInteger := Id;
    try
      Qry.Open;

      Self.F_clienteId := Qry.FieldByName('clienteId').AsInteger;
      Self.F_nome := Qry.FieldByName('nome').AsString;
      Self.F_endereco := Qry.FieldByName('endereco').AsString;
      Self.F_cidade := Qry.FieldByName('cidade').AsString;
      Self.F_bairro := Qry.FieldByName('bairro').AsString;
      Self.F_estado := Qry.FieldByName('estado').AsString;
      Self.F_cep := Qry.FieldByName('cep').AsString;
      Self.F_telefone := Qry.FieldByName('telefone').AsString;
      Self.F_email := Qry.FieldByName('email').AsString;
      Self.F_dataNascimento := Qry.FieldByName('dataNascimento').AsDateTime;
    except
      Result := False;
    end;
  finally
    Qry.Close;
    if Assigned(Qry) then
      FreeAndNil(Qry);
  end;
end;

{$ENDREGION}

end.
