object frmRelProcessoDeVenda: TfrmRelProcessoDeVenda
  Left = 0
  Top = 0
  Caption = 'Relat'#243'rio de vendas'
  ClientHeight = 793
  ClientWidth = 769
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnDestroy = FormDestroy
  TextHeight = 15
  object relatorio: TRLReport
    Left = -8
    Top = 0
    Width = 794
    Height = 1123
    DataSource = dtsVenda
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    object cabecalho: TRLBand
      Left = 38
      Top = 38
      Width = 718
      Height = 58
      BandType = btHeader
      object RLLabel1: TRLLabel
        Left = 16
        Top = 16
        Width = 69
        Height = 24
        Caption = 'Venda'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -21
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLDraw1: TRLDraw
        Left = 0
        Top = 40
        Width = 718
        Height = 18
        Align = faClientBottom
        DrawKind = dkLine
        Pen.Width = 2
      end
    end
    object rodape: TRLBand
      Left = 38
      Top = 313
      Width = 718
      Height = 55
      BandType = btFooter
      object RLDraw2: TRLDraw
        Left = 0
        Top = 0
        Width = 718
        Height = 18
        Align = faClientTop
        DrawKind = dkLine
        Pen.Width = 2
      end
      object RLSystemInfo1: TRLSystemInfo
        Left = 16
        Top = 24
        Width = 60
        Height = 16
        Info = itFullDate
        Text = ''
      end
      object RLSystemInfo2: TRLSystemInfo
        Left = 622
        Top = 24
        Width = 30
        Height = 16
        Alignment = taRightJustify
        Info = itPageNumber
        Text = ''
      end
      object RLSystemInfo3: TRLSystemInfo
        Left = 671
        Top = 24
        Width = 30
        Height = 16
        Alignment = taRightJustify
        Info = itLastPageNumber
        Text = ''
      end
      object RLLabel2: TRLLabel
        Left = 665
        Top = 24
        Width = 11
        Height = 16
        Caption = '/'
      end
    end
    object bandaDoGrupo: TRLGroup
      Left = 38
      Top = 96
      Width = 718
      Height = 161
      DataFields = 'vendaId'
      object RLBand3: TRLBand
        Left = 0
        Top = 0
        Width = 718
        Height = 29
        BandType = btHeader
        Color = clSilver
        ParentColor = False
        Transparent = False
        object lblVenda: TRLLabel
          Left = 16
          Top = 7
          Width = 49
          Height = 16
          Caption = 'Venda:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object RLDBText5: TRLDBText
          Left = 92
          Top = 7
          Width = 47
          Height = 16
          DataField = 'vendaId'
          DataSource = dtsVenda
          Text = ''
        end
      end
      object RLBand1: TRLBand
        Left = 0
        Top = 29
        Width = 718
        Height = 44
        object RLDBText1: TRLDBText
          Left = 78
          Top = 14
          Width = 52
          Height = 16
          Alignment = taRightJustify
          DataField = 'clienteId'
          DataSource = dtsVenda
          Text = ''
        end
        object RLDBText2: TRLDBText
          Left = 142
          Top = 14
          Width = 36
          Height = 16
          DataField = 'nome'
          DataSource = dtsVenda
          Text = ''
        end
        object RLDBText4: TRLDBText
          Left = 636
          Top = 14
          Width = 66
          Height = 16
          Alignment = taRightJustify
          DataField = 'dataVenda'
          DataSource = dtsVenda
          Text = ''
        end
        object RLLabel7: TRLLabel
          Left = 16
          Top = 14
          Width = 53
          Height = 16
          Caption = 'Cliente:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = False
        end
        object RLLabel3: TRLLabel
          Left = 130
          Top = 14
          Width = 8
          Height = 16
          Caption = '-'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = False
        end
        object RLLabel4: TRLLabel
          Left = 577
          Top = 14
          Width = 37
          Height = 16
          Caption = 'Data:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = False
        end
      end
      object RLSubDetail1: TRLSubDetail
        Left = 0
        Top = 73
        Width = 718
        Height = 82
        DataSource = dtsVendaItens
        object RLBand2: TRLBand
          Left = 0
          Top = 0
          Width = 718
          Height = 17
          BandType = btHeader
          Color = clInfoBk
          ParentColor = False
          Transparent = False
          object lblProdutos: TRLLabel
            Left = 16
            Top = 1
            Width = 60
            Height = 16
            Caption = 'Produtos'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = False
          end
          object RLLabel8: TRLLabel
            Left = 321
            Top = 0
            Width = 78
            Height = 16
            Caption = 'Quantidade'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = False
          end
          object RLLabel9: TRLLabel
            Left = 457
            Top = -1
            Width = 91
            Height = 16
            Caption = 'Valor unitario'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = False
          end
          object RLLabel10: TRLLabel
            Left = 666
            Top = -1
            Width = 36
            Height = 16
            Caption = 'Total'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = False
          end
        end
        object RLBand4: TRLBand
          Left = 0
          Top = 17
          Width = 718
          Height = 29
          object RLDBText3: TRLDBText
            Left = 8
            Top = 6
            Width = 57
            Height = 16
            Alignment = taRightJustify
            DataField = 'produtoId'
            DataSource = dtsVendaItens
            Text = ''
          end
          object RLDBText6: TRLDBText
            Left = 79
            Top = 6
            Width = 36
            Height = 16
            DataField = 'nome'
            DataSource = dtsVendaItens
            Text = ''
          end
          object RLLabel6: TRLLabel
            Left = 65
            Top = 7
            Width = 8
            Height = 16
            Caption = '-'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = False
          end
          object RLDBText7: TRLDBText
            Left = 332
            Top = 6
            Width = 67
            Height = 16
            Alignment = taRightJustify
            DataField = 'quantidade'
            DataSource = dtsVendaItens
            Text = ''
          end
          object RLDBText8: TRLDBText
            Left = 474
            Top = 6
            Width = 74
            Height = 16
            Alignment = taRightJustify
            DataField = 'valorUnitario'
            DataSource = dtsVendaItens
            Text = ''
          end
          object RLDBText9: TRLDBText
            Left = 628
            Top = 6
            Width = 74
            Height = 16
            Alignment = taRightJustify
            DataField = 'totalProduto'
            DataSource = dtsVendaItens
            Text = ''
          end
        end
      end
    end
    object RLBand5: TRLBand
      Left = 38
      Top = 257
      Width = 718
      Height = 56
      BandType = btSummary
      object RLDBResult2: TRLDBResult
        Left = 597
        Top = 17
        Width = 105
        Height = 16
        Alignment = taRightJustify
        DataField = 'totalVenda'
        DataSource = dtsVenda
        Info = riSum
        Text = ''
      end
      object RLDraw4: TRLDraw
        Left = 418
        Top = 3
        Width = 300
        Height = 15
        DrawKind = dkLine
      end
      object RLLabel5: TRLLabel
        Left = 531
        Top = 17
        Width = 36
        Height = 16
        Alignment = taRightJustify
        Caption = 'Total'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
    end
  end
  object qryVenda: TFDQuery
    Active = True
    Connection = dtmPrincipal.ConexaoDB
    SQL.Strings = (
      'select v.vendaId,'
      '       v.clienteId,'
      '       c.nome,'
      '       v.dataVenda,'
      '       v.totalVenda'
      'from vendas v inner join clientes c'
      'on c.clienteId = v.clienteId where'
      'v.vendaId = :vendaId order by'
      'v.dataVenda, v.clienteId')
    Left = 152
    Top = 720
    ParamData = <
      item
        Name = 'VENDAID'
        DataType = ftInteger
        ParamType = ptInput
        Value = '2'
      end>
    object qryVendavendaId: TFDAutoIncField
      FieldName = 'vendaId'
      Origin = 'vendaId'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = False
    end
    object qryVendaclienteId: TIntegerField
      FieldName = 'clienteId'
      Origin = 'clienteId'
      Required = True
    end
    object qryVendanome: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'nome'
      Origin = 'nome'
      ProviderFlags = []
      ReadOnly = True
      Size = 60
    end
    object qryVendadataVenda: TDateTimeField
      AutoGenerateValue = arDefault
      FieldName = 'dataVenda'
      Origin = 'dataVenda'
      DisplayFormat = 'dd/mm/yyyy'
    end
    object qryVendatotalVenda: TFMTBCDField
      AutoGenerateValue = arDefault
      FieldName = 'totalVenda'
      Origin = 'totalVenda'
      DisplayFormat = '#0.00'
      Precision = 18
      Size = 5
    end
  end
  object dtsVenda: TDataSource
    DataSet = qryVenda
    Left = 64
    Top = 720
  end
  object RLPDFFilter1: TRLPDFFilter
    DocumentInfo.Creator = 
      'FortesReport Community Edition v4.0.1.2 \251 Copyright '#169' 1999-20' +
      '21 Fortes Inform'#225'tica'
    DisplayName = 'Documento PDF'
    Left = 680
    Top = 640
  end
  object RLXLSFilter1: TRLXLSFilter
    DisplayName = 'Planilha Excel 97-2013'
    Left = 680
    Top = 688
  end
  object RLXLSXFilter1: TRLXLSXFilter
    DisplayName = 'Planilha Excel'
    Left = 680
    Top = 736
  end
  object qryVendaItens: TFDQuery
    Active = True
    Connection = dtmPrincipal.ConexaoDB
    SQL.Strings = (
      'select vi.vendaId,'
      '       vi.produtoId,'
      '       p.nome,'
      '       vi.quantidade,'
      '       vi.valorUnitario,'
      '       vi.totalProduto'
      'from vendasitens vi inner join produtos p'
      'on p.produtoId = vi.produtoId where'
      'vi.vendaId = :vendaId order by'
      'vi.produtoId')
    Left = 320
    Top = 720
    ParamData = <
      item
        Name = 'VENDAID'
        DataType = ftInteger
        ParamType = ptInput
        Value = '2'
      end>
    object qryVendaItensvendaId: TIntegerField
      FieldName = 'vendaId'
      Origin = 'vendaId'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryVendaItensprodutoId: TIntegerField
      FieldName = 'produtoId'
      Origin = 'produtoId'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryVendaItensnome: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'nome'
      Origin = 'nome'
      ProviderFlags = []
      ReadOnly = True
      Size = 60
    end
    object qryVendaItensquantidade: TFMTBCDField
      AutoGenerateValue = arDefault
      FieldName = 'quantidade'
      Origin = 'quantidade'
      DisplayFormat = '#0.00'
      Precision = 18
      Size = 5
    end
    object qryVendaItensvalorUnitario: TFMTBCDField
      AutoGenerateValue = arDefault
      FieldName = 'valorUnitario'
      Origin = 'valorUnitario'
      DisplayFormat = '#0.00'
      Precision = 18
      Size = 5
    end
    object qryVendaItenstotalProduto: TFMTBCDField
      AutoGenerateValue = arDefault
      FieldName = 'totalProduto'
      Origin = 'totalProduto'
      DisplayFormat = '#0.00'
      Precision = 18
      Size = 5
    end
  end
  object dtsVendaItens: TDataSource
    DataSet = qryVendaItens
    Left = 232
    Top = 720
  end
end
