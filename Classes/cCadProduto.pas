unit cCadProduto;

interface

uses System.Classes, System.SysUtils, Vcl.Controls, Vcl.ExtCtrls, Vcl.Dialogs,
  FireDAC.Comp.Client, FireDAC.Stan.Param;

type
  TProduto = class
  private
    ConexaoDB: TFDConnection;
    F_produtoId: Integer;
    F_nome: String;
    F_descricao: String;
    F_valor: Double;
    F_quantidade: Double;
    F_categoriaId: Integer;
  public
    constructor Create(Conexao: TFDConnection);
    destructor Destroy; override;
    function Inserir: Boolean;
    function Atualizar: Boolean;
    function Apagar: Boolean;
    function Selecionar(Id: Integer): Boolean;
  published
    property codigo: Integer read F_produtoId write F_produtoId;
    property nome: String read F_nome write F_nome;
    property descricao: String read F_descricao write F_descricao;
    property valor: Double read F_valor write F_valor;
    property quantidade: Double read F_quantidade write F_quantidade;
    property categoriaId: Integer read F_categoriaId write F_categoriaId;
  end;

var
  Qry: TFDQuery;

implementation

{$REGION 'Constructor and Destructor'}

constructor TProduto.Create(Conexao: TFDConnection);
begin
  ConexaoDB := Conexao;
end;

destructor TProduto.Destroy;
begin
  inherited;
end;
{$ENDREGION}
{$REGION 'CRUD Functions'}

function TProduto.Inserir: Boolean;
begin
  try
    Result := True;
    Qry := TFDQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('insert into produtos (nome, descricao, valor, ' +
      'quantidade, categoriaId) values (:nome, :descricao, :valor, ' +
      ':quantidade, :categoriaId)');
    Qry.ParamByName('nome').AsString := Self.F_nome;
    Qry.ParamByName('descricao').AsString := Self.F_descricao;
    Qry.ParamByName('valor').AsFloat := Self.F_valor;
    Qry.ParamByName('quantidade').AsFloat := Self.F_quantidade;
    Qry.ParamByName('categoriaId').AsInteger := Self.F_categoriaId;

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

function TProduto.Atualizar: Boolean;
begin
  try
    Result := True;
    Qry := TFDQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('update produtos set nome = :nome, descricao = :descricao, ' +
      'valor = :valor, quantidade = :quantidade, categoriaId = :categoriaId ' +
      'where produtoId = :Id');
    Qry.ParamByName('Id').AsInteger := Self.F_produtoId;
    Qry.ParamByName('nome').AsString := Self.F_nome;
    Qry.ParamByName('descricao').AsString := Self.F_descricao;
    Qry.ParamByName('valor').AsFloat := Self.F_valor;
    Qry.ParamByName('quantidade').AsFloat := Self.F_quantidade;
    Qry.ParamByName('categoriaId').AsInteger := Self.F_categoriaId;

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

function TProduto.Apagar: Boolean;
begin
  if MessageDlg('Apagar o registro: ' + #13 + #13 + 'Código: ' + #13 +
    IntToStr(Self.F_produtoId) + 'Nome: ' + Self.F_nome, mtConfirmation,
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
    Qry.SQL.Add('delete from produtos where produtoId = :Id');
    Qry.ParamByName('Id').AsInteger := Self.F_produtoId;

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

function TProduto.Selecionar(Id: Integer): Boolean;
begin
  try
    Result := True;
    Qry := TFDQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('select produtoId, nome, descricao, valor, ' +
      'quantidade, categoriaId from produtos where produtoId = :Id');
    Qry.ParamByName('Id').AsInteger := Id;
    try
      Qry.Open;

      Self.F_produtoId := Qry.FieldByName('produtoId').AsInteger;
      Self.F_nome := Qry.FieldByName('nome').AsString;
      Self.F_descricao := Qry.FieldByName('descricao').AsString;
      Self.F_valor := Qry.FieldByName('valor').AsFloat;
      Self.F_quantidade := Qry.FieldByName('quantidade').AsFloat;
      Self.F_categoriaId := Qry.FieldByName('categoriaId').AsInteger;
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
