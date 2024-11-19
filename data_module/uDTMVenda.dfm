object dtmVendas: TdtmVendas
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 480
  Width = 640
  object qryClientes: TFDQuery
    Connection = dtmPrincipal.ConexaoDB
    SQL.Strings = (
      'select clienteId, nome from clientes')
    Left = 304
    Top = 280
    object qryClientesclienteId: TFDAutoIncField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'clienteId'
      Origin = 'clienteId'
      ReadOnly = False
    end
    object qryClientesnome: TStringField
      DisplayLabel = 'Nome'
      FieldName = 'nome'
      Origin = 'nome'
      Size = 60
    end
  end
  object qryProdutos: TFDQuery
    Connection = dtmPrincipal.ConexaoDB
    SQL.Strings = (
      'select produtoId, nome, valor, quantidade from produtos')
    Left = 480
    Top = 280
    object qryProdutosprodutoId: TFDAutoIncField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'produtoId'
      Origin = 'produtoId'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = False
    end
    object qryProdutosnome: TStringField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Nome'
      FieldName = 'nome'
      Origin = 'nome'
      Size = 60
    end
    object qryProdutosvalor: TFMTBCDField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Valor'
      FieldName = 'valor'
      Origin = 'valor'
      Precision = 18
      Size = 5
    end
    object qryProdutosquantidade: TFMTBCDField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Quantidade'
      FieldName = 'quantidade'
      Origin = 'quantidade'
      Precision = 18
      Size = 5
    end
  end
  object dtsItensVenda: TDataSource
    DataSet = cdsItensVenda
    Left = 152
    Top = 120
  end
  object dtsClientes: TDataSource
    DataSet = qryClientes
    Left = 304
    Top = 120
  end
  object dtsProdutos: TDataSource
    DataSet = qryProdutos
    Left = 480
    Top = 120
  end
  object cdsItensVenda: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 152
    Top = 280
    object cdsItensVendaprodutoId: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'produtoId'
    end
    object cdsItensVendaNomeProduto: TStringField
      DisplayLabel = 'Nome do produto'
      FieldName = 'NomeProduto'
    end
    object cdsItensVendaQuantidade: TFloatField
      FieldName = 'Quantidade'
    end
    object cdsItensVendaValorUnitario: TFloatField
      DisplayLabel = 'Valor unit'#225'rio'
      FieldName = 'Valorunitario'
    end
    object cdsItensVendatotalProduto: TFloatField
      DisplayLabel = 'Total do produto'
      FieldName = 'totalProduto'
    end
  end
end
