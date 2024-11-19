unit cUsuarioLogado;

interface

uses System.Classes, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, System.SysUtils;

type TUsuarioLogado = class
  private
    F_usuarioId : Integer;
    F_nome : String;
    F_senha : String;
  public
    class function TenhoAcesso(Id: Integer; Chave: String;
      Conexao: TFDConnection): Boolean; static;
  published
    property codigo : Integer read F_usuarioId write F_usuarioId;
    property nome : String read F_nome write F_nome;
    property senha :String read F_senha write F_senha;
end;

implementation

class function TUsuarioLogado.TenhoAcesso(Id: Integer; Chave: String;
  Conexao: TFDConnection): Boolean;
var
  Qry: TFDQuery;
begin
  try
    Result := True;
    Qry := TFDQuery.Create(nil);
    Qry.Connection := Conexao;
    Qry.SQL.Clear;
    Qry.SQL.Add('select usuarioId from usuarioacaoacesso where usuarioId = ' +
      ':usuarioId and acaoAcessoId = (select acaoAcessoId from acaoAcesso ' +
      'where chave = :chave and ativo = 1 limit 1)');
    Qry.ParamByName('usuarioId').AsInteger := Id;
    Qry.ParamByName('chave').AsString := Chave;
    Qry.Open;

    if Qry.IsEmpty then
      Result := False;
  finally
    if Assigned(Qry) then
      FreeAndNil(Qry);
  end;
end;

end.
