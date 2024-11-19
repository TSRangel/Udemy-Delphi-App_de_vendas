unit uDTMGraficos;

interface

uses
  System.SysUtils, System.Classes, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, uDTMConexao;

type
  TdtmGrafico = class(TDataModule)
    qryProdutoEstoque: TFDQuery;
    qryProdutoEstoqueLabel: TStringField;
    qryProdutoEstoqueValue: TFMTBCDField;
    qryVendaValorPorCliente: TFDQuery;
    qryVendaValorPorClienteLabel: TStringField;
    qryVendaValorPorClientevalue: TFMTBCDField;
    qry10ProdutosMaisVendidos: TFDQuery;
    qry10ProdutosMaisVendidosLabel: TStringField;
    qry10ProdutosMaisVendidosValue: TFMTBCDField;
    qryVendasUltimaSemana: TFDQuery;
    qryVendasUltimaSemanaLabel: TDateTimeField;
    qryVendasUltimaSemanaValue: TFMTBCDField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dtmGrafico: TdtmGrafico;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
