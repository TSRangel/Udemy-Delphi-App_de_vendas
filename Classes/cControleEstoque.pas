unit cControleEstoque;

interface

uses System.Classes, System.SysUtils, Vcl.Controls, Vcl.ExtCtrls, Vcl.Dialogs,
  FireDAC.Comp.Client, FireDAC.Stan.Param, Datasnap.DBClient;

type
  TControleEstoque = class
  private
    ConexaoDB: TFDConnection;
    F_produtoId: Integer;
    F_quantidade: Double;
  public
    constructor Create(Conexao: TFDConnection);
    destructor Destroy; override;
    function BaixarEstoque: Boolean;
    function RetornarEstoque: Boolean;
  published
    property produtoId: Integer read F_produtoId write F_produtoId;
    property quantidade: Double read F_quantidade write F_quantidade;
  end;

var
  Qry: TFDQuery;

implementation

{$REGION 'Constructor and Destructor'}

constructor TControleEstoque.Create(Conexao: TFDConnection);
begin
  ConexaoDB := Conexao;
end;

destructor TControleEstoque.Destroy;
begin
  inherited;
end;

{$ENDREGION}
{$REGION 'Functions'}

function TControleEstoque.BaixarEstoque: Boolean;
begin
  try
    Result := True;
    Qry := TFDQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('update produtos set quantidade = quantidade - :baixa where ' +
      'produtoId = :produtoId');
    Qry.ParamByName('produtoId').AsInteger := Self.F_produtoId;
    Qry.ParamByName('baixa').AsFloat := Self.F_quantidade;

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

function TControleEstoque.RetornarEstoque: Boolean;
begin
  try
    Result := True;
    Qry := TFDQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('update produtos set quantidade = quantidade + :retorno where '
      + 'produtoId = :produtoId');
    Qry.ParamByName('produtoId').AsInteger := Self.F_produtoId;
    Qry.ParamByName('retorno').AsFloat := Self.F_quantidade;

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
