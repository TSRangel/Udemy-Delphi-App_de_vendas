unit uFRMAtualizaDB;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls;

type
  TfrmAtualizaDB = class(TForm)
    Panel1: TPanel;
    pnlTop: TPanel;
    Image1: TImage;
    lblTitulo: TLabel;
    chklConexao: TCheckBox;
    chkProduto: TCheckBox;
    chkCategoria: TCheckBox;
    chkCliente: TCheckBox;
    chkVenda: TCheckBox;
    chkVendasItens: TCheckBox;
    chkUsuarios: TCheckBox;
    chkAcaoAcesso: TCheckBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAtualizaDB: TfrmAtualizaDB;

implementation

{$R *.dfm}

end.
