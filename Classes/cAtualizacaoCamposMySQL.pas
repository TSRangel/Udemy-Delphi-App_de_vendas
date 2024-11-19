unit cAtualizacaoCamposMySQL;

interface

uses System.Classes, System.SysUtils, Vcl.Controls, Vcl.ExtCtrls, Vcl.Dialogs,
  FireDAC.Comp.Client, FireDAC.Stan.Param, cAtualizacaoDB;

type
  TAtualizacaoCamposMySQL = class(TAtualizacaoDB)
  private
    function CampoExiste(NomeDaTabela, Campo: String): Boolean;
  public
    constructor Create(Conexao: TFDConnection);
    destructor Destroy; override;
  end;

implementation

{ TAtualizacaoCamposMySQL }

{$REGION 'Constructor and Destructor'}

constructor TAtualizacaoCamposMySQL.Create(Conexao: TFDConnection);
begin
  ConexaoDB := Conexao;
end;

destructor TAtualizacaoCamposMySQL.Destroy;
begin

  inherited;
end;

{$ENDREGION}
{$REGION 'Functions and Procedures'}

function TAtualizacaoCamposMySQL.CampoExiste(NomeDaTabela,
  Campo: String): Boolean;
var Qry : TFDQuery;
begin
  try
  Result := False;
  Qry := TFDQuery.Create(nil);
  Qry.SQL.CLear;
  Qry.SQL.Add('select count(column_name) as qtde from ' +
  'information_schema.columns where table_name = :tabela and column_name = ' +
  ':coluna');
  Qry.ParamByName('tabela').AsString := NomeDaTabela;
  Qry.ParamByName('coluna').AsString := Campo;
  Qry.Open;

  if Qry.FieldByName('qtde').AsInteger > 0 then
    Result := True;

  finally
    Qry.Close;
    if Assigned(Qry) then
      FreeAndNil(Qry);
  end;
end;

{$ENDREGION}

end.
