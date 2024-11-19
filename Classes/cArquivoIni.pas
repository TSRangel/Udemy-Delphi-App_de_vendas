unit cArquivoIni;

interface

uses System.Classes, Vcl.Controls, Vcl.ExtCtrls, Vcl.Dialogs, System.SysUtils,
System.IniFiles, Vcl.Forms;

type TArquivoIni = class
  private
  public
    class function ArquivoIni : String; static;
    class function LerIni(Secao, Entrada : String) : String; static;
    class procedure AtualizarIni(Secao, Entrada, Valor : String); static;
end;

implementation

{ TArquivoIni }

class function TArquivoIni.ArquivoIni: String;
begin
  Result := ChangeFileExt(Application.ExeName, '.INI');
end;

class procedure TArquivoIni.AtualizarIni(Secao, Entrada, Valor: String);
var Ini : TIniFile;
begin
  try
    Ini := TIniFile.Create(ArquivoIni);
    Ini.WriteString(Secao, Entrada, Valor);
  finally
    Ini.Free;
  end;
end;

class function TArquivoIni.LerIni(Secao, Entrada: String): String;
var Ini : TIniFile;
begin
  try
    Ini := TIniFile.Create(ArquivoIni);
    Result := Ini.ReadString(Secao, Entrada, 'Não encontrado.');
  finally
    Ini.Free;
  end;
end;

end.
