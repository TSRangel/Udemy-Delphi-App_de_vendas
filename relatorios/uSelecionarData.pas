unit uSelecionarData;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, RxToolEdit,
  Vcl.Buttons, System.DateUtils;

type
  TfrmSelecionarData = class(TForm)
    lblDataInicial: TLabel;
    edtDataInicial: TDateEdit;
    lblDataFinal: TLabel;
    edtDataFinal: TDateEdit;
    btnOk: TBitBtn;
    procedure btnOkClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSelecionarData: TfrmSelecionarData;

implementation

{$R *.dfm}

procedure TfrmSelecionarData.btnOkClick(Sender: TObject);
begin
  if edtDataFinal.Date <= edtDataInicial.Date then
  begin
    MessageDlg('Data final n�o pode ser maior que a data inicial',
      mtInformation, [mbOk], 0);
    edtDataFinal.SetFocus;
    Abort;
  end;

  if (edtDataInicial.Date = 0) or (edtDataFinal.Date = 0) then
  begin
    MessageDlg('Data inicial ou final s�o campos obrigat�rios.', mtInformation,
      [mbOk], 0);
    edtDataInicial.SetFocus;
    Abort;
  end;

  Close;
end;

procedure TfrmSelecionarData.FormShow(Sender: TObject);
begin
  edtDataInicial.Date := StartOfTheMonth(Date);
  edtDataFinal.Date := EndOfTheMonth(Date);
end;

end.
