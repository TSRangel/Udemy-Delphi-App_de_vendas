unit cProVenda;

interface

uses System.Classes, System.SysUtils, Vcl.Controls, Vcl.ExtCtrls, Vcl.Dialogs,
  FireDAC.Comp.Client, FireDAC.Stan.Param, Datasnap.DBClient, uEnum,
  cControleEstoque;

type
  TVenda = class
  private
    ConexaoDB: TFDConnection;
    F_vendaId: Integer;
    F_clienteId: Integer;
    F_dataVenda: TDateTime;
    f_totalVenda: Double;
    function InserirItens(cds: TClientDataSet; IdVenda: Integer): Boolean;
    function ApagaItens(cds: TClientDataSet): Boolean;
    function InNot(cds: TClientDataSet): String;
    function EsteItemExiste(vendaId, produtoId: Integer): Boolean;
    function AtualizarItem(cds: TClientDataSet): Boolean;
    procedure RetornarEstoque(sCodigo: String; Acao: TAcaoExcluirEstoque);
    procedure BaixarEstoque(produtoId: Integer; quantidade: Double);
  public
    constructor Create(Conexao: TFDConnection);
    destructor Destroy; override;
    function Inserir(cds: TClientDataSet): Integer;
    function Atualizar(cds: TClientDataSet): Boolean;
    function Apagar: Boolean;
    function Selecionar(Id: Integer; var cds: TClientDataSet): Boolean;
  published
    property vendaId: Integer read F_vendaId write F_vendaId;
    property clienteId: Integer read F_clienteId write F_clienteId;
    property dataVenda: TDateTime read F_dataVenda write F_dataVenda;
    property totalVenda: Double read f_totalVenda write f_totalVenda;
  end;

var
  Qry: TFDQuery;

implementation

{$REGION 'Constructos and Destructor'}

constructor TVenda.Create(Conexao: TFDConnection);
begin
  ConexaoDB := Conexao;
end;

destructor TVenda.Destroy;
begin
  inherited;
end;

{$ENDREGION}
{$REGION 'CRUD Functions'}

function TVenda.Inserir(cds: TClientDataSet): Integer;
var
  IdVendaGerado: Integer;
begin
  try
    ConexaoDB.StartTransaction;
    Qry := TFDQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('insert into vendas (clienteId, dataVenda, totalVenda) ' +
      'values (:clienteId, :dataVenda, :totalVenda)');
    Qry.ParamByName('clienteId').AsInteger := Self.F_clienteId;
    Qry.ParamByName('dataVenda').AsDateTime := Self.F_dataVenda;
    Qry.ParamByName('totalVenda').AsFloat := Self.f_totalVenda;
    try
      Qry.ExecSQL;

      Qry.SQL.Clear;
      Qry.SQL.Add('select LAST_INSERT_ID() as ID');
      Qry.Open;

      IdVendaGerado := Qry.FieldByName('ID').AsInteger;

      cds.First;
      while not cds.Eof do
      begin
        InserirItens(cds, IdVendaGerado);
        cds.Next;
      end;

      ConexaoDB.Commit;
      Result := IdVendaGerado;
    except
      ConexaoDB.Rollback;
      Result := -1;
    end;
  finally
    if Assigned(Qry) then
      FreeAndNil(Qry);
  end;
end;

function TVenda.Atualizar(cds: TClientDataSet): Boolean;
begin
  try
    Result := True;
    ConexaoDB.StartTransaction;
    Qry := TFDQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('update vendas set clienteId = :clienteId, ' +
      'dataVenda = :dataVenda, totalVenda = :totalVenda ' +
      'where vendaId = :vendaId');
    Qry.ParamByName('clienteId').AsInteger := Self.F_clienteId;
    Qry.ParamByName('dataVenda').AsDateTime := Self.F_dataVenda;
    Qry.ParamByName('totalVenda').AsFloat := Self.f_totalVenda;
    Qry.ParamByName('vendaId').AsInteger := Self.F_vendaId;
    try
      Qry.ExecSQL;

      ApagaItens(cds);

      cds.First;
      while not cds.Eof do
      begin
        if EsteItemExiste(Self.F_vendaId, cds.FieldByName('produtoId').AsInteger)
        then
        begin
          AtualizarItem(cds);
        end
        else
        begin
          InserirItens(cds, Self.F_vendaId);
        end;
        cds.Next;
      end;
      ConexaoDB.Commit;
    except
      Result := False;
      ConexaoDB.Rollback;
    end;

  finally
    if Assigned(Qry) then
      FreeAndNil(Qry);
  end;
end;

function TVenda.Apagar: Boolean;
begin
  if MessageDlg('Apagar o registro: ' + #13 + #13 + 'Venda numero: ' +
    IntToStr(Self.F_vendaId), mtConfirmation, [mbYes, mbNo], 0) = mrNo then
  begin
    Result := False;
    Abort;
  end;

  try
    Result := True;
    Qry := TFDQuery.Create(nil);
    ConexaoDB.StartTransaction;
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('delete from vendasItens where vendaId = :vendaId');
    Qry.ParamByName('vendaId').AsInteger := Self.F_vendaId;
    try
      Qry.ExecSQL;

      Qry.SQL.Clear;
      Qry.SQL.Add('delete from vendas where vendaId = :vendaId');
      Qry.ParamByName('vendaId').AsInteger := Self.F_vendaId;
      Qry.ExecSQL;
      ConexaoDB.Commit;
    except
      ConexaoDB.Rollback;
      Result := False;
    end;
  finally
    if Assigned(Qry) then
      FreeAndNil(Qry);
  end;

end;

function TVenda.Selecionar(Id: Integer; var cds: TClientDataSet): Boolean;
begin
  try
    Result := True;
    Qry := TFDQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('select vendaId, clienteId, dataVenda, totalVenda ' +
      'from vendas where vendaId = :Id');
    Qry.ParamByName('Id').AsInteger := Id;
    try
      Qry.Open;

      Self.F_vendaId := Qry.FieldByName('vendaId').AsInteger;
      Self.F_clienteId := Qry.FieldByName('clienteId').AsInteger;
      Self.F_dataVenda := Qry.FieldByName('dataVenda').AsDateTime;
      Self.f_totalVenda := Qry.FieldByName('totalVenda').AsFloat;

      cds.First;
      while not cds.Eof do
        cds.Delete;

      Qry.Close;
      Qry.SQL.Clear;
      Qry.SQL.Add('select vendasitens.produtoId, produtos.nome, ' +
        'vendasitens.valorUnitario, vendasitens.quantidade, ' +
        'vendasitens.totalProduto from vendasitens inner join produtos ' +
        'on produtos.produtoId = vendasitens.produtoId where vendasitens.vendaId '
        + '= :vendaId');
      Qry.ParamByName('vendaId').AsInteger := Self.F_vendaId;
      Qry.Open;

      Qry.First;
      while not Qry.Eof do
      begin
        cds.Append;
        cds.FieldByName('produtoId').AsInteger := Qry.FieldByName('produtoId')
          .AsInteger;
        cds.FieldByName('nomeProduto').AsString :=
          Qry.FieldByName('nome').AsString;
        cds.FieldByName('quantidade').AsFloat :=
          Qry.FieldByName('quantidade').AsFloat;
        cds.FieldByName('valorUnitario').AsFloat :=
          Qry.FieldByName('valorUnitario').AsFloat;
        cds.FieldByName('totalProduto').AsFloat :=
          Qry.FieldByName('totalProduto').AsFloat;
        cds.Post;
        Qry.Next;
      end;
      cds.First;
    except
      Result := False;
    end;
  finally
    Qry.Close;
    if Assigned(Qry) then
      FreeAndNil(Qry);
  end;
end;
{$ENDREGION}
{$REGION 'Functions and Procedures'}

function TVenda.InserirItens(cds: TClientDataSet; IdVenda: Integer): Boolean;
begin
  try
    Result := True;
    Qry := TFDQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('insert into vendasitens (vendaId, produtoId, valorUnitario, ' +
      'quantidade, totalProduto) values (:vendaId, :produtoId, :valorUnitario, '
      + ':quantidade, :totalProduto)');
    Qry.ParamByName('vendaId').AsInteger := IdVenda;
    Qry.ParamByName('produtoId').AsInteger := cds.FieldByName('produtoId')
      .AsInteger;
    Qry.ParamByName('valorUnitario').AsFloat :=
      cds.FieldByName('valorUnitario').AsFloat;
    Qry.ParamByName('quantidade').AsFloat :=
      cds.FieldByName('quantidade').AsFloat;
    Qry.ParamByName('totalProduto').AsFloat :=
      cds.FieldByName('totalProduto').AsFloat;
    try
      ConexaoDB.StartTransaction;
      Qry.ExecSQL;
      ConexaoDB.Commit;
      BaixarEstoque(cds.FieldByName('produtoId').AsInteger,
        cds.FieldByName('quantidade').AsFloat)
    except
      ConexaoDB.Rollback;
      Result := False;
    end;
  finally
    if Assigned(Qry) then
      FreeAndNil(Qry);
  end;
end;

function TVenda.ApagaItens(cds: TClientDataSet): Boolean;
var
  sCodNoCds: String;
begin
  try
    Result := True;
    sCodNoCds := InNot(cds);
    RetornarEstoque(sCodNoCds, aeeApagar);

    Qry := TFDQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('delete from vendasitens where vendaId = :vendaId and ' +
      'produtoId not in (' + sCodNoCds + ')');
    Qry.ParamByName('vendaId').AsInteger := Self.F_vendaId;

    try
      ConexaoDB.StartTransaction;
      Qry.ExecSQL;
      ConexaoDB.Commit;
    except
      ConexaoDB.Rollback;
      Result := False;
    end;

  finally
    if Assigned(Qry) then
      FreeAndNil(Qry);
  end;
end;

function TVenda.InNot(cds: TClientDataSet): String;
var
  sInNot: String;
begin
  sInNot := EmptyStr;
  cds.First;
  while not cds.Eof do
  begin
    if sInNot = EmptyStr then
      sInNot := cds.FieldByName('produtoId').AsString
    else
      sInNot := sInNot + ', ' + cds.FieldByName('produtoId').AsString;

    cds.Next;
  end;
  Result := sInNot;
end;

function TVenda.EsteItemExiste(vendaId, produtoId: Integer): Boolean;
begin
  try
    Qry := TFDQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('select count(vendaId) as qtde from vendasitens where ' +
      'vendaId = :vendaId and produtoId = :produtoId');
    Qry.ParamByName('vendaId').AsInteger := vendaId;
    Qry.ParamByName('produtoId').AsInteger := produtoId;
    try
      Qry.Open;

      if Qry.FieldByName('qtde').AsInteger > 0 then
        Result := True
      else
        Result := False;
    except
      Result := False;
    end;
  finally
    if Assigned(Qry) then
      FreeAndNil(Qry);
  end;
end;

function TVenda.AtualizarItem(cds: TClientDataSet): Boolean;
begin
  try
    Result := True;
    RetornarEstoque(cds.FieldByName('produtoId').AsString, aeeAlterar);
    Qry := TFDQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('update vendasitens set valorUnitario = :valorUnitario, ' +
      'quantidade = :quantidade, totalProduto = :totalProduto where vendaId = '
      + ':vendaId and produtoId = :produtoId');
    Qry.ParamByName('vendaId').AsInteger := Self.F_vendaId;
    Qry.ParamByName('produtoId').AsInteger := cds.FieldByName('produtoId')
      .AsInteger;
    Qry.ParamByName('valorUnitario').AsFloat :=
      cds.FieldByName('valorUnitario').AsFloat;
    Qry.ParamByName('quantidade').AsFloat :=
      cds.FieldByName('quantidade').AsFloat;
    Qry.ParamByName('totalProduto').AsFloat :=
      cds.FieldByName('totalProduto').AsFloat;

    try
      ConexaoDB.StartTransaction;
      Qry.ExecSQL;
      ConexaoDB.Commit;

      BaixarEstoque(cds.FieldByName('produtoId').AsInteger,
        cds.FieldByName('quantidade').AsFloat);
    except
      ConexaoDB.Rollback;
      Result := False;
    end;
  finally
    if Assigned(Qry) then
      FreeAndNil(Qry);
  end;
end;

procedure TVenda.RetornarEstoque(sCodigo: String; Acao: TAcaoExcluirEstoque);
var
  oControleEstoque: TControleEstoque;
begin
  Qry := TFDQuery.Create(nil);
  Qry.Connection := ConexaoDB;
  Qry.SQL.Clear;
  Qry.SQL.Add('select produtoId, quantidade from vendasitens where ' +
    'vendaId = :vendaId');
  if Acao = aeeApagar then
    Qry.SQL.Add(' and produtoId not in (' + sCodigo + ')')
  else
    Qry.SQL.Add(' and produtoId = (' + sCodigo + ')');

  Qry.ParamByName('vendaId').AsInteger := Self.F_vendaId;
  try
    oControleEstoque := TControleEstoque.Create(ConexaoDB);
    Qry.Open;
    Qry.First;

    while not Qry.Eof do
    begin
      oControleEstoque.produtoId := Qry.FieldByName('produtoId').AsInteger;
      oControleEstoque.quantidade := Qry.FieldByName('quantidade').AsFloat;
      oControleEstoque.RetornarEstoque;
      Qry.Next;
    end;
  finally
    if Assigned(Qry) then
      FreeAndNil(Qry);
    if Assigned(oControleEstoque) then
      FreeAndNil(oControleEstoque);
  end;
end;

procedure TVenda.BaixarEstoque(produtoId: Integer; quantidade: Double);
var
  oControleEstoque: TControleEstoque;
begin
  try
    oControleEstoque := TControleEstoque.Create(ConexaoDB);
    oControleEstoque.produtoId := produtoId;
    oControleEstoque.quantidade := quantidade;
    oControleEstoque.BaixarEstoque;
  finally
    if Assigned(oControleEstoque) then
      FreeAndNil(oControleEstoque);
  end;
end;

{$ENDREGION}

end.
