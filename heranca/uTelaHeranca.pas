unit uTelaHeranca;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Buttons, Vcl.DBCtrls,
  Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Mask, Vcl.ComCtrls, Vcl.ExtCtrls,
  uDTMConexao, uEnum, RxToolEdit, RxCurrEdit;

type
  TfrmTelaHeranca = class(TForm)
    pgcPrincipal: TPageControl;
    pnlRodaPe: TPanel;
    tabListagem: TTabSheet;
    tabManutencao: TTabSheet;
    btnNovo: TBitBtn;
    btnAlterar: TBitBtn;
    btnCancelar: TBitBtn;
    btnGravar: TBitBtn;
    btnFechar: TBitBtn;
    btnNavigator: TDBNavigator;
    btnApagar: TBitBtn;
    qryListagem: TFDQuery;
    dtsListagem: TDataSource;
    pnlListagemTopo: TPanel;
    mskPesquisar: TMaskEdit;
    btnPesquisar: TBitBtn;
    grdListagem: TDBGrid;
    lblIndice: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnApagarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure grdListagemTitleClick(Column: TColumn);
    procedure grdListagemDblClick(Sender: TObject);
    procedure grdListagemKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnPesquisarClick(Sender: TObject);
    procedure mskPesquisarClick(Sender: TObject);
  private
    { Private declarations }
    SelectOriginal: String;
    procedure ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar,
      btnApagar: TBitBtn; Navegador: TDBNavigator; pgcPrincipal: TPageControl;
      Flag: Boolean);
    procedure ControlarIndiceTab(pgcPrincipal: TPageControl; Indice: Integer);
    function RetornarCampoTraduzido(Campo: String): String;
    procedure ExibirLabelIndice(Campo: String; lblIndice: TLabel);
    function ExisteCampoObrigatorio: Boolean;
    procedure DesabilidarEditPK;
    procedure LimparEdits;
  public
    { Public declarations }
    EstadoDoCadastro: TEstadoDoCadastro;
    IndiceAtual: String;
    function Apagar: Boolean; virtual;
    function Gravar(EstadoDoCadastro: TEstadoDoCadastro): Boolean; virtual;
    procedure BloqueiaCTRL_DEL_DBGrid(var Key: Word; Shift: TShiftState);

  end;

var
  frmTelaHeranca: TfrmTelaHeranca;

implementation

uses uPrincipal, cUsuarioLogado;

{$R *.dfm}
{$REGION 'Functions and Procedures'}

function TfrmTelaHeranca.RetornarCampoTraduzido(Campo: String): String;
begin
  var
    I: Integer;
  for I := 0 to qryListagem.Fields.Count - 1 do
  begin
    if lowercase(qryListagem.Fields[I].FieldName) = lowercase(Campo) then
    begin
      Result := qryListagem.Fields[I].DisplayLabel;
      Break;
    end;
  end;
end;

function TfrmTelaHeranca.ExisteCampoObrigatorio: Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := 0 to ComponentCount - 1 do
  begin
    if Components[I] is TLabeledEdit then
    begin
      if (TLabeledEdit(Components[I]).Tag = 2) and
        (TLabeledEdit(Components[I]).Text = EmptyStr) then
      begin
        MessageDlg(TLabeledEdit(Components[I]).EditLabel.Caption +
          ' é um campo obrigatório', mtInformation, [mbOk], 0);
        TLabeledEdit(Components[I]).SetFocus;
        Result := True;
        Break;
      end;
    end;
  end;
end;

procedure TfrmTelaHeranca.ExibirLabelIndice(Campo: String; lblIndice: TLabel);
begin
  lblIndice.Caption := RetornarCampoTraduzido(Campo);
end;

procedure TfrmTelaHeranca.ControlarBotoes(btnNovo, btnAlterar, btnCancelar,
  btnGravar, btnApagar: TBitBtn; Navegador: TDBNavigator;
  pgcPrincipal: TPageControl; Flag: Boolean);
begin
  btnNovo.Enabled := Flag;
  btnApagar.Enabled := Flag;
  btnAlterar.Enabled := Flag;
  Navegador.Enabled := Flag;
  pgcPrincipal.Pages[0].TabVisible := Flag;
  btnCancelar.Enabled := not(Flag);
  btnGravar.Enabled := not(Flag);
end;

procedure TfrmTelaHeranca.ControlarIndiceTab(pgcPrincipal: TPageControl;
  Indice: Integer);
begin
  if not(pgcPrincipal.Pages[Indice].TabVisible) then
    pgcPrincipal.Pages[Indice].TabVisible := True;
  pgcPrincipal.TabIndex := Indice;
end;

procedure TfrmTelaHeranca.DesabilidarEditPK;
var
  I: Integer;
begin
  for I := 0 to ComponentCount - 1 do
  begin
    if Components[I] is TLabeledEdit then
    begin
      if (TLabeledEdit(Components[I]).Tag = 1) then
      begin
        TLabeledEdit(Components[I]).Enabled := False;
        Break;
      end;
    end;
  end;
end;

procedure TfrmTelaHeranca.LimparEdits;
var
  I: Integer;
begin
  for I := 0 to ComponentCount - 1 do
  begin
    if (Components[I] is TLabeledEdit) then
      TLabeledEdit(Components[I]).Text := EmptyStr
    else if (Components[I] is TEdit) then
      TEdit(Components[I]).Text := EmptyStr
    else if (Components[I] is TMemo) then
      TMemo(Components[I]).Text := EmptyStr
    else if (Components[I] is TDBLookupComboBox) then
      TDBLookupComboBox(Components[I]).KeyValue := Null
    else if (Components[I] is TCurrencyEdit) then
      TCurrencyEdit(Components[I]).Value := 0
    else if (Components[I] is TDateEdit) then
      TDateEdit(Components[I]).Date := 0;
  end;
end;

{$ENDREGION}
{$REGION 'Virtual methods'}

function TfrmTelaHeranca.Apagar: Boolean;
begin
  ShowMessage('Deletado');
  Result := True;
end;

function TfrmTelaHeranca.Gravar(EstadoDoCadastro: TEstadoDoCadastro): Boolean;
begin
  if EstadoDoCadastro = ecInserir then
    ShowMessage('Inserido')
  else if EstadoDoCadastro = ecAlterar then
    ShowMessage('Alterado');
  Result := True;
end;

{$ENDREGION}
{$REGION 'Buttons events'}

procedure TfrmTelaHeranca.btnNovoClick(Sender: TObject);
begin
  if not TUsuarioLogado.TenhoAcesso(oUsuarioLogado.codigo, Self.Name + '_' + TBitBtn(Sender)
    .Name, dtmPrincipal.ConexaoDB) then
  begin
    MessageDlg('Usuário: ' + oUsuarioLogado.nome +
      ', não tem permissão de acesso', mtWarning, [mbOk], 0);
    Abort;
  end;

  ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar, btnApagar,
    btnNavigator, pgcPrincipal, False);
  EstadoDoCadastro := ecInserir;
  LimparEdits;
end;

procedure TfrmTelaHeranca.btnPesquisarClick(Sender: TObject);
var I : Integer;
    TIpoCampo : TFieldType;
    NomeCampo, WhereOrAnd, CondicaoSQL : String;
    FormatoOriginal, FormatoDestino : TFormatSettings;
    DataConvertida : TDateTime;
begin
  if not TUsuarioLogado.TenhoAcesso(oUsuarioLogado.codigo, Self.Name + '_' + TBitBtn(Sender)
    .Name, dtmPrincipal.ConexaoDB) then
  begin
    MessageDlg('Usuário: ' + oUsuarioLogado.nome +
      ', não tem permissão de acesso', mtWarning, [mbOk], 0);
    Abort;
  end;

  if mskPesquisar.Text = '' then
  begin
    qryListagem.Close;
    qryListagem.SQL.Clear;
    qryListagem.SQL.Add(SelectOriginal);
    qryListagem.Open;
    Abort;
  end;

  for I := 0 to qryListagem.FieldCount -1 do
  begin
    if qryListagem.Fields[I].FieldName = IndiceAtual then
    begin
      TipoCampo := qryListagem.Fields[I].DataType;
      if qryListagem.Fields[I].Origin <> '' then
      begin
        if Pos('.', qryListagem.Fields[I].Origin) > 0then
        begin
          NomeCampo := qryListagem.Fields[I].Origin
        end
        else
        begin
          NomeCampo := qryListagem.Fields[I].Origin +
          '.' + qryListagem.Fields[I].FieldName;
        end;
      end
      else
        NomeCampo := qryListagem.Fields[I].FieldName;
      Break;
    end;
  end;

  if Pos('where', LowerCase(SelectOriginal)) > 1 then
  begin
    WhereOrAnd := ' and ';
  end
  else
  begin
    WhereOrAnd := ' where ';
  end;

  if (TipoCampo = ftString) or (TipoCampo = ftWideString) then
  begin
    CondicaoSQL := WhereOrAnd + NomeCampo + ' like ' +
      QuotedStr('%' + mskPesquisar.Text + '%');
  end
  else if (TipoCampo = ftInteger) or (TipoCampo = ftSmallInt) or
    (TipoCampo = ftAutoInc) then
  begin
    CondicaoSQL := WhereOrAnd + NomeCampo + ' = ' + mskPEsquisar.Text;
  end
  else if (TipoCampo = ftDate) or (TipoCampo = ftDateTime) then
  begin
    FormatoOriginal := TFormatSettings.Create;
    FormatoOriginal.ShortDateFormat := 'dd/MM/yyyy';
    FormatoOriginal.DateSeparator := '/';

    FormatoDestino := FormatSettings.Create;
    FormatoDestino.ShortDateFormat := 'yyyy/MM/dd';
    FormatoDestino.DateSeparator := '/';

    if TryStrToDate(mskPesquisar.Text, DataConvertida, FormatoOriginal) then
    begin
      CondicaoSQL := WhereOrAnd + NomeCampo + ' = ' +
        QuotedStr(DateToStr(DataConvertida, FormatoDestino));
    end;
  end
  else if (TipoCampo = ftFloat) or (TipoCampo = ftCurrency) or
    (TipoCampo = ftFMTBcd) then
  begin
    CondicaoSQL := WhereOrAnd + NomeCampo + ' = ' +
      StringReplace(mskPesquisar.Text, ',', '.', [rfReplaceAll]);
  end;

  qryListagem.Close;
  qryListagem.SQL.Clear;
  qryListagem.SQL.Add(SelectOriginal);
  qryListagem.SQL.Add(CondicaoSQL);
  qryListagem.Open;

  mskPesquisar.Clear;
  mskPesquisar.SetFocus;
end;

procedure TfrmTelaHeranca.btnAlterarClick(Sender: TObject);
begin
  if not TUsuarioLogado.TenhoAcesso(oUsuarioLogado.codigo, Self.Name + '_' + TBitBtn(Sender)
    .Name, dtmPrincipal.ConexaoDB) then
  begin
    MessageDlg('Usuário: ' + oUsuarioLogado.nome +
      ', não tem permissão de acesso', mtWarning, [mbOk], 0);
    Abort;
  end;

  ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar, btnApagar,
    btnNavigator, pgcPrincipal, False);
  EstadoDoCadastro := ecAlterar;
  qryListagem.Refresh;
end;

procedure TfrmTelaHeranca.btnCancelarClick(Sender: TObject);
begin
  ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar, btnApagar,
    btnNavigator, pgcPrincipal, True);
  ControlarIndiceTab(pgcPrincipal, 0);
  EstadoDoCadastro := ecNenhum;
  LimparEdits;
end;

procedure TfrmTelaHeranca.btnGravarClick(Sender: TObject);
begin
  if not TUsuarioLogado.TenhoAcesso(oUsuarioLogado.codigo, Self.Name + '_' + TBitBtn(Sender)
    .Name, dtmPrincipal.ConexaoDB) then
  begin
    MessageDlg('Usuário: ' + oUsuarioLogado.nome +
      ', não tem permissão de acesso', mtWarning, [mbOk], 0);
    Abort;
  end;

  if ExisteCampoObrigatorio then
    Abort;

  try
    if Gravar(EstadoDoCadastro) then
    begin
      ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar, btnApagar,
        btnNavigator, pgcPrincipal, True);
      ControlarIndiceTab(pgcPrincipal, 0);
      EstadoDoCadastro := ecNenhum;
      LimparEdits;
      qryListagem.Refresh;
    end
    else
    begin
      MessageDlg('Erro na gravação', mtError, [mbOk], 0);
    end;
  finally
  end;
end;

procedure TfrmTelaHeranca.btnApagarClick(Sender: TObject);
begin
  if not TUsuarioLogado.TenhoAcesso(oUsuarioLogado.codigo, Self.Name + '_' + TBitBtn(Sender)
    .Name, dtmPrincipal.ConexaoDB) then
  begin
    MessageDlg('Usuário: ' + oUsuarioLogado.nome +
      ', não tem permissão de acesso', mtWarning, [mbOk], 0);
    Abort;
  end;

  Try
    if (Apagar) then
    begin
      ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar, btnApagar,
        btnNavigator, pgcPrincipal, True);
      ControlarIndiceTab(pgcPrincipal, 0);
      EstadoDoCadastro := ecNenhum;
      LimparEdits;
      qryListagem.Refresh;
    end
    else
    begin
      MessageDlg('Erro na exclusão', mtError, [mbOk], 0);
    end;
  Finally
    EstadoDoCadastro := ecNenhum;
  End;

end;

procedure TfrmTelaHeranca.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmTelaHeranca.grdListagemDblClick(Sender: TObject);
begin
  btnAlterar.Click;
end;

procedure TfrmTelaHeranca.grdListagemKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  BloqueiaCTRL_DEL_DBGrid(Key, Shift);
end;

procedure TfrmTelaHeranca.grdListagemTitleClick(Column: TColumn);
begin
  IndiceAtual := Column.FieldName;
  qryListagem.IndexFieldNames := IndiceAtual;
  ExibirLabelIndice(IndiceAtual, lblIndice);
end;

procedure TfrmTelaHeranca.mskPesquisarClick(Sender: TObject);
begin
  mskPesquisar.Clear;
end;

procedure TfrmTelaHeranca.BloqueiaCTRL_DEL_DBGrid(var Key: Word;
  Shift: TShiftState);
begin
  if (Shift = [ssCtrl]) and (Key = 46) then
    Key := 0;
end;

{$ENDREGION}
{$REGION 'Form events'}

procedure TfrmTelaHeranca.FormCreate(Sender: TObject);
begin
  qryListagem.Connection := dtmPrincipal.ConexaoDB;
  dtsListagem.DataSet := qryListagem;
  grdListagem.DataSource := dtsListagem;
  btnNavigator.DataSource := dtsListagem;
  grdListagem.Options := [dgTitles, dgIndicator, dgColumnResize, dgColLines,
    dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgCancelOnExit,
    dgTitleClick, dgTitleHotTrack]
end;

procedure TfrmTelaHeranca.FormShow(Sender: TObject);
begin
  if qryListagem.SQL.Text <> EmptyStr then
  begin
    qryListagem.IndexFieldNames := IndiceAtual;
    ExibirLabelIndice(IndiceAtual, lblIndice);
    SelectOriginal := qryListagem.SQL.Text;
    qryListagem.Open;
  end;
  ControlarIndiceTab(pgcPrincipal, 0);
  DesabilidarEditPK;
  ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar, btnApagar,
    btnNavigator, pgcPrincipal, True);
end;

procedure TfrmTelaHeranca.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  qryListagem.Close;
end;

{$ENDREGION}

end.
