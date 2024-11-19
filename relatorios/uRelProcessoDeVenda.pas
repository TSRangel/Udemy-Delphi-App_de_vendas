unit uRelProcessoDeVenda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uDTMConexao, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, RLReport, RLFilters,
  RLPDFFilter, RLXLSXFilter, RLXLSFilter;

type
  TfrmRelProcessoDeVenda = class(TForm)
    qryVenda: TFDQuery;
    dtsVenda: TDataSource;
    relatorio: TRLReport;
    cabecalho: TRLBand;
    RLLabel1: TRLLabel;
    RLDraw1: TRLDraw;
    RLPDFFilter1: TRLPDFFilter;
    rodape: TRLBand;
    RLDraw2: TRLDraw;
    RLSystemInfo1: TRLSystemInfo;
    RLSystemInfo2: TRLSystemInfo;
    RLSystemInfo3: TRLSystemInfo;
    RLLabel2: TRLLabel;
    RLXLSFilter1: TRLXLSFilter;
    RLXLSXFilter1: TRLXLSXFilter;
    bandaDoGrupo: TRLGroup;
    RLBand3: TRLBand;
    RLBand1: TRLBand;
    RLDBText1: TRLDBText;
    RLDBText2: TRLDBText;
    RLDBText4: TRLDBText;
    lblVenda: TRLLabel;
    RLDBText5: TRLDBText;
    RLBand5: TRLBand;
    RLDBResult2: TRLDBResult;
    RLDraw4: TRLDraw;
    RLLabel5: TRLLabel;
    qryVendaItens: TFDQuery;
    dtsVendaItens: TDataSource;
    qryVendavendaId: TFDAutoIncField;
    qryVendaclienteId: TIntegerField;
    qryVendanome: TStringField;
    qryVendadataVenda: TDateTimeField;
    qryVendatotalVenda: TFMTBCDField;
    qryVendaItensvendaId: TIntegerField;
    qryVendaItensprodutoId: TIntegerField;
    qryVendaItensnome: TStringField;
    qryVendaItensquantidade: TFMTBCDField;
    qryVendaItensvalorUnitario: TFMTBCDField;
    qryVendaItenstotalProduto: TFMTBCDField;
    RLLabel7: TRLLabel;
    RLLabel3: TRLLabel;
    RLLabel4: TRLLabel;
    RLSubDetail1: TRLSubDetail;
    RLBand2: TRLBand;
    RLBand4: TRLBand;
    RLDBText3: TRLDBText;
    RLDBText6: TRLDBText;
    RLLabel6: TRLLabel;
    lblProdutos: TRLLabel;
    RLDBText7: TRLDBText;
    RLDBText8: TRLDBText;
    RLDBText9: TRLDBText;
    RLLabel8: TRLLabel;
    RLLabel9: TRLLabel;
    RLLabel10: TRLLabel;
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRelProcessoDeVenda: TfrmRelProcessoDeVenda;

implementation

{$R *.dfm}

procedure TfrmRelProcessoDeVenda.FormDestroy(Sender: TObject);
begin
  qryVenda.Close;
  qryVendaItens.Close;
end;

end.
