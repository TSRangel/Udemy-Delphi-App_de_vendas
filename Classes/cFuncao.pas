unit cFuncao;

interface

uses System.Classes, Vcl.Controls, Vcl.ExtCtrls, Vcl.Dialogs, System.SysUtils,
  Vcl.Forms, Vcl.Buttons, cAcaoAcesso, cUsuarioLogado, RLReport, Data.DB,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error,
  FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async,
  FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TFuncao = class
  private

  public
    class procedure CriarForm(NomeForm: TFormClass;
      oUsuarioLogado: TUsuarioLogado; Conexao: TFDConnection); static;
    class procedure CriarRelatorio(NomeForm: TFormClass;
      oUsuarioLogado: TUsuarioLogado; Conexao: TFDConnection); static;
  end;

implementation

{ TFuncao }

class procedure TFuncao.CriarForm(NomeForm: TFormClass;
  oUsuarioLogado: TUsuarioLogado; Conexao: TFDConnection);
var
  form: TForm;
begin
  try
    form := NomeForm.Create(Application);
    if TUsuarioLogado.TenhoAcesso(oUsuarioLogado.codigo, form.Name, Conexao)
    then
      form.ShowModal
    else
      MessageDlg('Usuário: ' + oUsuarioLogado.nome +
        ' não tem permissão de acesso', mtWarning, [mbOk], 0);
  finally
    if Assigned(form) then
      form.Release;
  end;
end;

class procedure TFuncao.CriarRelatorio(NomeForm: TFormClass;
  oUsuarioLogado: TUsuarioLogado; Conexao: TFDConnection);
var
  form: TForm;
  Relatorio: TRLReport;
  I: Integer;
begin
  try
    form := NomeForm.Create(Application);
    if TUsuarioLogado.TenhoAcesso(oUsuarioLogado.codigo, form.Name, Conexao)
    then
    begin
      for I := 0 to form.ComponentCount - 1 do
      begin
        if form.Components[I] is TRLReport then
        begin
          TRLReport(form.Components[I]).PreviewModal;
          Break;
        end;
      end;
    end
    else
    begin
      MessageDlg('Usuário: ' + oUsuarioLogado.nome +
        ' não tem permissão de acesso', mtWarning, [mbOk], 0);
    end;
  finally
    if Assigned(form) then
      form.Release;
  end;
end;

end.
