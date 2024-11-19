unit cAtualizacaoTabelasMySQL;

interface

uses System.Classes, System.SysUtils, Vcl.Controls, Vcl.ExtCtrls, Vcl.Dialogs,
  FireDAC.Comp.Client, FireDAC.Stan.Param, cAtualizacaoDB;

type
  TAtualizacaoTabelasMySQL = class(TAtualizacaoDB)
  private
    function TabelaExiste(Nome: String): Boolean;
    procedure Categorias;
    procedure Clientes;
    procedure Produtos;
    procedure Usuarios;
    procedure Vendas;
    procedure VendasItens;
    procedure AcaoAcesso;
    procedure UsuariosAcaoAcesso;
  public
    constructor Create(Conexao: TFDConnection);
    destructor Destroy; override;
  end;

implementation

uses cCadUsuario;
{ TAtualizacaoTabelasMySQL }

{$REGION 'Constructor and Destructor'}

constructor TAtualizacaoTabelasMySQL.Create(Conexao: TFDConnection);
begin
  ConexaoDB := Conexao;
  Categorias;
  Produtos;
  Clientes;
  Vendas;
  VendasItens;
  Usuarios;
  AcaoAcesso;
  UsuariosAcaoAcesso;
end;

destructor TAtualizacaoTabelasMySQL.Destroy;
begin

  inherited;
end;

{$ENDREGION}
{$REGION 'Functions and Procedures'}

function TAtualizacaoTabelasMySQL.TabelaExiste(Nome: String): Boolean;
var
  Qry: TFDQuery;
begin
  try
    Result := False;
    Qry := TFDQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('select if(count(*) > 0, 1, 0) as existe from ' +
      'information_schema.tables where table_name = :nome;');
    Qry.ParamByName('nome').AsString := Nome;
    Qry.Open;

    if Qry.FieldByName('existe').AsInteger > 0 then
      Result := True;

  finally
    if Assigned(Qry) then
      FreeAndNil(Qry);
  end;
end;

procedure TAtualizacaoTabelasMySQL.Categorias;
begin
  if not TabelaExiste('categorias') then
  begin
    ExecutaDiretoBancoDeDados('CREATE TABLE `categorias` ' +
      '(`categoriaId` int NOT NULL AUTO_INCREMENT, ' +
      '`descricao` varchar(100) NOT NULL, ' + 'PRIMARY KEY (`categoriaId`)) ' +
      'ENGINE=InnoDB AUTO_INCREMENT=0 ' +
      'DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci');
  end;
end;

procedure TAtualizacaoTabelasMySQL.Produtos;
begin
  if not TabelaExiste('produtos') then
  begin
    ExecutaDiretoBancoDeDados('CREATE TABLE if not exists `produtos` ' +
      '(`produtoId` int NOT NULL AUTO_INCREMENT, ' +
      '`nome` varchar(60) DEFAULT NULL, ' +
      '`descricao` varchar(255) DEFAULT NULL, ' +
      '`valor` decimal(18,5) DEFAULT NULL, ' +
      '`quantidade` decimal(18,5) DEFAULT NULL, ' +
      '`categoriaId` int NOT NULL, ' + 'PRIMARY KEY (`produtoId`), ' +
      'KEY `categoriaId_idx` (`categoriaId`), ' +
      'CONSTRAINT `categoriaId` FOREIGN KEY (`categoriaId`) ' +
      'REFERENCES `categorias` (`categoriaId`)) ' +
      'ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT ' +
      'CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci');
  end;
end;

procedure TAtualizacaoTabelasMySQL.Clientes;
begin
  if not TabelaExiste('clientes') then
  begin
    ExecutaDiretoBancoDeDados('CREATE TABLE  `clientes` ' +
      '(`clienteId` int NOT NULL AUTO_INCREMENT, ' +
      '`nome` varchar(60) DEFAULT NULL, ' +
      '`endereco` varchar(60) DEFAULT NULL, ' +
      '`cidade` varchar(50) DEFAULT NULL, ' +
      '`bairro` varchar(40) DEFAULT NULL, ' +
      '`estado` varchar(2) DEFAULT NULL, ' + '`cep` varchar(10) DEFAULT NULL, '
      + '`telefone` varchar(14) DEFAULT NULL, ' +
      '`email` varchar(100) DEFAULT NULL, ' +
      '`dataNascimento` datetime DEFAULT NULL, ' + 'PRIMARY KEY (`clienteId`)) '
      + 'ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT ' +
      'CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci');
  end;
end;

procedure TAtualizacaoTabelasMySQL.Vendas;
begin
  if not TabelaExiste('vendas') then
  begin
    ExecutaDiretoBancoDeDados('CREATE TABLE `vendas` ' +
      '(`vendaId` int NOT NULL AUTO_INCREMENT, ' + '`clienteId` int NOT NULL, '
      + '`dataVenda` datetime DEFAULT CURRENT_TIMESTAMP, ' +
      '`totalVenda` decimal(18,5) DEFAULT 0.00000, ' +
      'PRIMARY KEY (`vendaId`), ' +
      'KEY `fk_vendasClientes_idx` (`clienteId`), ' +
      'CONSTRAINT `clienteId` FOREIGN KEY (`clienteId`) ' +
      'REFERENCES `clientes` (`clienteId`)) ' +
      'ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT ' +
      'CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci');
  end;
end;

procedure TAtualizacaoTabelasMySQL.VendasItens;
begin
  if not TabelaExiste('vendasitens') then
  begin
    ExecutaDiretoBancoDeDados('CREATE TABLE `vendasitens` ' +
      '(`vendaId` int NOT NULL, ' + '`produtoId` int NOT NULL, ' +
      '`valorUnitario` decimal(18,5) DEFAULT 0.00000, ' +
      '`quantidade` decimal(18,5) DEFAULT 0.00000, ' +
      '`totalProduto` decimal(18,5) DEFAULT 0.00000, ' +
      'PRIMARY KEY (`vendaId`,`produtoId`), ' +
      'KEY `fk_vendasItensProdutos_idx` (`produtoId`), ' +
      'CONSTRAINT `fk_vendasItensProdutos` FOREIGN KEY (`produtoId`) ' +
      'REFERENCES `produtos` (`produtoId`)) ENGINE=InnoDB DEFAULT ' +
      'CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci');
  end;
end;

procedure TAtualizacaoTabelasMySQL.Usuarios;
var oUsuario : TUsuario;
begin
  if not TabelaExiste('usuarios') then
  begin
    ExecutaDiretoBancoDeDados('CREATE TABLE `usuarios` ' +
      '(`usuarioId` int NOT NULL AUTO_INCREMENT, ' +
      '`nome` varchar(50) NOT NULL, ' + '`senha` varchar(40) NOT NULL, ' +
      'PRIMARY KEY (`usuarioId`)) ' + 'ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT '
      + 'CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci');
  end;

  try
    oUsuario := TUsuario.Create(ConexaoDB);
    oUsuario.nome := 'admin';
    oUsuario.senha := 'admin';
    if not oUsuario.UsuarioExiste('admin') then
      oUsuario.Inserir;
  finally
    if Assigned(oUsuario) then
      FreeAndNil(oUsuario);
  end;
end;

procedure TAtualizacaoTabelasMySQL.AcaoAcesso;
begin
  if not TabelaExiste('acaoacesso') then
  begin
    ExecutaDiretoBancoDeDados('CREATE TABLE `acaoacesso` ' +
    '(`acaoAcessoId` int NOT NULL AUTO_INCREMENT, ' +
    'descricao varchar(100) NOT NULL, ' +
    'chave varchar(60) NOT NULL, ' +
    'PRIMARY KEY (`acaoAcessoId`)) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT ' +
    'CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci');
  end;
end;

procedure TAtualizacaoTabelasMySQL.UsuariosAcaoAcesso;
begin
  if not TabelaExiste('usuarioacaoacesso') then
  begin
    ExecutaDiretoBancoDeDados('CREATE TABLE usuarioacaoacesso ' +
    '(usuarioId int NOT NULL, ' +
    'acaoAcessoId int NOT NULL, ' +
    'ativo bit NOT NULL DEFAULT 1, PRIMARY KEY(usuarioId, acaoAcessoId), ' +
    'CONSTRAINT fk_usuarioAcaoAcessoUsuario FOREIGN KEY (usuarioId) ' +
    'REFERENCES usuarios(usuarioId), ' +
    'CONSTRAINT fk_usuarioAcaoAcessoAcaoAcesso FOREIGN KEY (acaoAcessoId) ' +
    'REFERENCES acaoacesso(acaoAcessoId))');
  end;
end;

{$ENDREGION}

end.
