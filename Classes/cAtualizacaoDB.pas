unit cAtualizacaoDB;

interface

uses System.Classes, System.SysUtils, Vcl.Controls, Vcl.ExtCtrls, Vcl.Dialogs,
  FireDAC.Comp.Client, FireDAC.Stan.Param;

type TAtualizacaoDB = class
  private
  public
    ConexaoDB : TFDConnection;
    constructor Create(Conexao: TFDConnection);
    destructor Destroy; override;
    procedure ExecutaDiretoBancoDeDados(Script: String);
end;

implementation

uses cAtualizacaoTabelasMySQL, cAtualizacaoCamposMySQL;

{ TAtualizacaoDB }

{$REGION 'Constructor and Destructor'}

constructor TAtualizacaoDB.Create(Conexao: TFDConnection);
begin
  ConexaoDB := Conexao;
end;

destructor TAtualizacaoDB.Destroy;
begin

  inherited;
end;

{$ENDREGION}
{$REGION 'Functions and Procedures'}

procedure TAtualizacaoDB.ExecutaDiretoBancoDeDados(Script: String);
var Qry : TFDQuery;
begin
  try
    Qry := TFDQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add(Script);

    try
      ConexaoDB.StartTransaction;
      Qry.ExecSQL;
      ConexaoDB.Commit;
    except
      ConexaoDB.Rollback;
    end;

  finally
    if Assigned(Qry) then
      FreeAndNil(Qry);
  end;
end;

{$ENDREGION}

end.
