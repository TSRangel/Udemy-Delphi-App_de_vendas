unit uRelProdutosComGrupoCategoria;

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
  TfrmRelProdutosComGrupoCategoria = class(TForm)
    qryProdutos: TFDQuery;
    dtsProdutos: TDataSource;
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
    RLBand2: TRLBand;
    RLBand1: TRLBand;
    RLDBText1: TRLDBText;
    RLDBText2: TRLDBText;
    RLDBText3: TRLDBText;
    RLDBText4: TRLDBText;
    RLLabel7: TRLLabel;
    RLDBText5: TRLDBText;
    RLDBText6: TRLDBText;
    RLLabel8: TRLLabel;
    RLLabel4: TRLLabel;
    RLLabel3: TRLLabel;
    RLLabel5: TRLLabel;
    RLLabel6: TRLLabel;
    RLBand4: TRLBand;
    RLDBResult1: TRLDBResult;
    RLDraw3: TRLDraw;
    RLLabel9: TRLLabel;
    RLLabel10: TRLLabel;
    RLDBResult2: TRLDBResult;
    qryProdutosprodutoId: TIntegerField;
    qryProdutosnome: TStringField;
    qryProdutosdescricao: TStringField;
    qryProdutosvalor: TFMTBCDField;
    qryProdutosquantidade: TFMTBCDField;
    qryProdutoscategoriaId: TIntegerField;
    qryProdutosdescricaoCategoria: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRelProdutosComGrupoCategoria: TfrmRelProdutosComGrupoCategoria;

implementation

{$R *.dfm}

procedure TfrmRelProdutosComGrupoCategoria.FormCreate(Sender: TObject);
begin
  qryProdutos.Open;
end;

procedure TfrmRelProdutosComGrupoCategoria.FormDestroy(Sender: TObject);
begin
  qryProdutos.Close;
end;

end.
