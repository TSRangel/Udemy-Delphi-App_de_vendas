object dtmGrafico: TdtmGrafico
  Height = 480
  Width = 640
  object qryProdutoEstoque: TFDQuery
    Connection = dtmPrincipal.ConexaoDB
    SQL.Strings = (
      'SELECT'
      'CONCAT(CAST(produtoId AS CHAR), '#39' - '#39', nome) AS Label,'
      'quantidade AS Value'
      'FROM delphi.produtos;')
    Left = 80
    Top = 50
    object qryProdutoEstoqueLabel: TStringField
      FieldName = 'Label'
      ReadOnly = True
      Size = 74
    end
    object qryProdutoEstoqueValue: TFMTBCDField
      FieldName = 'Value'
      Precision = 18
      Size = 5
    end
  end
  object qryVendaValorPorCliente: TFDQuery
    Connection = dtmPrincipal.ConexaoDB
    SQL.Strings = (
      
        'select concat(cast(v.clienteId as char), '#39' - '#39', c.nome) as Label' +
        ','
      '       sum(v.totalVenda) as value'
      'from delphi.vendas v'
      'inner join delphi.clientes c on c.clienteId = v.clienteId'
      'where v.dataVenda between'
      
        'date_sub(curdate(), interval 7 day) and curdate() group by v.cli' +
        'enteId, c.nome;')
    Left = 248
    Top = 48
    object qryVendaValorPorClienteLabel: TStringField
      FieldName = 'Label'
      ReadOnly = True
      Size = 74
    end
    object qryVendaValorPorClientevalue: TFMTBCDField
      FieldName = 'value'
      ReadOnly = True
      Precision = 40
      Size = 5
    end
  end
  object qry10ProdutosMaisVendidos: TFDQuery
    Connection = dtmPrincipal.ConexaoDB
    SQL.Strings = (
      
        'select concat(cast(vi.produtoId as char), '#39' - '#39', p.nome) as Labe' +
        'l,'
      #9'   sum(vi.totalProduto) as Value'
      'from vendasItens vi inner join produtos p'
      'on p.produtoId = vi.produtoId'
      'group by vi.produtoId, p.nome order by Value desc')
    Left = 432
    Top = 48
    object qry10ProdutosMaisVendidosLabel: TStringField
      FieldName = 'Label'
      ReadOnly = True
      Size = 74
    end
    object qry10ProdutosMaisVendidosValue: TFMTBCDField
      FieldName = 'Value'
      ReadOnly = True
      Precision = 40
      Size = 5
    end
  end
  object qryVendasUltimaSemana: TFDQuery
    Connection = dtmPrincipal.ConexaoDB
    SQL.Strings = (
      'select v.dataVenda as Label,'
      #9'   sum(v.totalVenda) as Value'
      'from vendas v where v.dataVenda'
      'between date_sub(curdate(), interval 7 day) and curdate()'
      'group by v.dataVenda')
    Left = 200
    Top = 304
    object qryVendasUltimaSemanaLabel: TDateTimeField
      FieldName = 'Label'
    end
    object qryVendasUltimaSemanaValue: TFMTBCDField
      FieldName = 'Value'
      ReadOnly = True
      Precision = 40
      Size = 5
    end
  end
end
