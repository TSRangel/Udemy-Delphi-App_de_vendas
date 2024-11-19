unit uDTMVenda;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Datasnap.DBClient;

type
  TdtmVendas = class(TDataModule)
    qryClientes: TFDQuery;
    qryClientesclienteId: TFDAutoIncField;
    qryClientesnome: TStringField;
    qryProdutos: TFDQuery;
    qryProdutosprodutoId: TFDAutoIncField;
    qryProdutosnome: TStringField;
    qryProdutosvalor: TFMTBCDField;
    qryProdutosquantidade: TFMTBCDField;
    dtsItensVenda: TDataSource;
    dtsClientes: TDataSource;
    dtsProdutos: TDataSource;
    cdsItensVenda: TClientDataSet;
    cdsItensVendaprodutoId: TIntegerField;
    cdsItensVendaNomeProduto: TStringField;
    cdsItensVendaQuantidade: TFloatField;
    cdsItensVendaValorUnitario: TFloatField;
    cdsItensVendatotalProduto: TFloatField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dtmVendas: TdtmVendas;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TdtmVendas.DataModuleCreate(Sender: TObject);
begin
  cdsItensVenda.CreateDataSet;

  qryClientes.Open;
  qryProdutos.Open;
end;

procedure TdtmVendas.DataModuleDestroy(Sender: TObject);
begin
  cdsItensVenda.Close;
  qryClientes.Close;
  qryProdutos.Close;
end;

end.
