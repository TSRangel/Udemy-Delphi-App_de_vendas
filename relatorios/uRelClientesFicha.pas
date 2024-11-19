unit uRelClientesFicha;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uDTMConexao, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, RLReport, RLFilters,
  RLPDFFilter, RLXLSXFilter, RLXLSFilter, Vcl.Imaging.pngimage;

type
  TfrmRelClientesFicha = class(TForm)
    qryClientesFicha: TFDQuery;
    dtsClientes: TDataSource;
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
    ficha: TRLBand;
    rldbClienteId: TRLDBText;
    rldbNome: TRLDBText;
    RLXLSFilter1: TRLXLSFilter;
    RLXLSXFilter1: TRLXLSXFilter;
    rldbEmail: TRLDBText;
    rldbTelefone: TRLDBText;
    qryClientesFichaclienteId: TFDAutoIncField;
    qryClientesFichanome: TStringField;
    qryClientesFichacep: TStringField;
    qryClientesFichaendereco: TStringField;
    qryClientesFichabairro: TStringField;
    qryClientesFichacidade: TStringField;
    qryClientesFichaestado: TStringField;
    qryClientesFichaemail: TStringField;
    qryClientesFichatelefone: TStringField;
    qryClientesFichadataNascimento: TDateTimeField;
    lblCodigo: TRLLabel;
    lblNome: TRLLabel;
    lblEmail: TRLLabel;
    lblTelefone: TRLLabel;
    rldbCep: TRLDBText;
    lblCep: TRLLabel;
    rldbEndereco: TRLDBText;
    lblEndereco: TRLLabel;
    rldbBairro: TRLDBText;
    lblBairro: TRLLabel;
    rldbCidade: TRLDBText;
    lblCidade: TRLLabel;
    rldbEstado: TRLDBText;
    lblEstado: TRLLabel;
    rldbDataDeNascimento: TRLDBText;
    lblDataDeNascimento: TRLLabel;
    RLDraw3: TRLDraw;
    RLImage1: TRLImage;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRelClientesFicha: TfrmRelClientesFicha;

implementation

{$R *.dfm}

procedure TfrmRelClientesFicha.FormCreate(Sender: TObject);
begin
  qryClientesFicha.Open;
end;

procedure TfrmRelClientesFicha.FormDestroy(Sender: TObject);
begin
  qryClientesFicha.Close;
end;

end.
