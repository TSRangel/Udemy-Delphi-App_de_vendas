unit cCadCategoria;

interface

uses System.Classes, System.SysUtils, Vcl.Controls, Vcl.ExtCtrls, Vcl.Dialogs,
  FireDAC.Comp.Client, FireDAC.Stan.Param;

type
  TCategoria = class
  private
    ConexaoDB: TFDConnection;
    F_categoriaId: Integer;
    F_descricao: String;
    function getCodigo: Integer;
    function getDescricao: String;
    procedure setCodigo(const Value: Integer);
    procedure setDescricao(const Value: String);

  public
    constructor Create(Conexao: TFDConnection);
    destructor Destroy; override;
    function Inserir: Boolean;
    function Atualizar: Boolean;
    function Apagar: Boolean;
    function Selecionar(Id: Integer): Boolean;
  published
    property codigo: Integer read getCodigo write setCodigo;
    property descricao: String read getDescricao write setDescricao;
  end;

var
  Qry: TFDQuery;

implementation

{$REGION 'Constructor e Destructor'}

constructor TCategoria.Create(Conexao: TFDConnection);
begin
  ConexaoDB := Conexao
end;

destructor TCategoria.Destroy;
begin
  inherited;
end;

{$ENDREGION}
{$REGION 'CRUD Functions'}

function TCategoria.Inserir: Boolean;
begin
  try
    Result := True;
    Qry := TFDQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('insert into categorias (descricao) values (:descricao)');
    Qry.ParamByName('descricao').AsString := Self.F_descricao;

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

function TCategoria.Atualizar: Boolean;
begin
  try
    Result := True;
    Qry := TFDQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add
      ('update categorias set descricao = :Desc where categoriaId = :Id');
    Qry.ParamByName('Desc').AsString := Self.F_descricao;
    Qry.ParamByName('Id').AsInteger := Self.F_categoriaId;

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

function TCategoria.Apagar: Boolean;
begin
  if MessageDlg('Apagar o registro: ' + #13 + #13 + 'Código: ' +
    IntToStr(Self.F_categoriaId) + #13 + 'Descrição: ' + Self.F_descricao,
    mtConfirmation, [mbYes, mbNo], 0) = mrNo then
  begin
    Result := False;
    Abort;
  end;

  try
    Result := True;
    Qry := TFDQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('delete from categorias where categoriaId = :Id');
    Qry.ParamByName('Id').AsInteger := Self.F_categoriaId;

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

function TCategoria.Selecionar(Id: Integer): Boolean;
begin
  try
    Result := True;
    Qry := TFDQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add
      ('select categoriaId, descricao from categorias where categoriaId = :Id');
    Qry.ParamByName('Id').AsInteger := Id;
    try
      Qry.Open;

      Self.F_categoriaId := Qry.FieldByName('categoriaId').AsInteger;
      Self.F_descricao := Qry.FieldByName('descricao').AsString;
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
{$REGION 'Getters and Setters'}

function TCategoria.getCodigo: Integer;
begin
  Result := Self.F_categoriaId;
end;

function TCategoria.getDescricao: String;
begin
  Result := F_descricao;
end;

procedure TCategoria.setCodigo(const Value: Integer);
begin
  Self.F_categoriaId := Value;
end;

procedure TCategoria.setDescricao(const Value: String);
begin
  Self.F_descricao := Value;
end;
{$ENDREGION}

end.
