unit uDTMConexao;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet;

type
  TdtmPrincipal = class(TDataModule)
    ConexaoDB: TFDConnection;
  private
    { Private declarations }
    procedure test;
  public
    { Public declarations }
  end;

var
  dtmPrincipal: TdtmPrincipal;

implementation

procedure TdtmPrincipal.test;
begin
  ConexaoDB.TxOptions.Isolation := xiReadCommitted;
end;
{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
