unit uFuncaoCriptografia;

interface

uses Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs;

function Criptografar(const Entrada: String): String;
function Descriptografar(const Entrada: String): String;

implementation

function Criptografar(const Entrada: String): String;
var
  I, QtdeEnt, Intervalo: Integer;
  Saida, ProximoCaracter: String;
begin
  Intervalo := 6;
  I := 0;
  QtdeEnt := 0;

  if (Entrada <> EmptyStr) then
  begin
    QtdeEnt := Length(Entrada);
    for I := QtdeEnt downto 1 do
    begin
      ProximoCaracter := Copy(Entrada, I, 1);
      Saida := Saida + (char(ord(ProximoCaracter[1]) + Intervalo));
    end;
  end;

  Result := Saida;
end;

function Descriptografar(const Entrada: String): String;
var
  I, QtdeEnt, Intervalo: Integer;
  Saida, ProximoCaracter: String;
begin
  Intervalo := 6;
  I := 0;
  QtdeEnt := 0;
  if (Entrada <> EmptyStr) then
  begin
    QtdeEnt := Length(Entrada);
    for I := QtdeEnt downto 1 do
    begin
      ProximoCaracter := Copy(Entrada, I, 1);
      Saida := Saida + (char(ord(ProximoCaracter[1]) - Intervalo));
    end;
  end;

  Result := Saida;
end;

end.
