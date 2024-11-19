object frmRelVendaPorData: TfrmRelVendaPorData
  Left = 0
  Top = 0
  Caption = 'Relat'#243'rio de vendas por data'
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
        Width = 289
        Height = 24
        Caption = 'Listagem de venda por data'
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
      Top = 305
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
      DataFields = 'dataVenda'
      object RLBand3: TRLBand
        Left = 0
        Top = 0
        Width = 718
        Height = 29
        BandType = btHeader
        Color = clSilver
        ParentColor = False
        Transparent = False
        object RLLabel7: TRLLabel
          Left = 16
          Top = 7
          Width = 37
          Height = 16
          Caption = 'Data:'
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
          Width = 66
          Height = 16
          DataField = 'dataVenda'
          DataSource = dtsVenda
          Text = ''
        end
      end
      object RLBand2: TRLBand
        Left = 0
        Top = 29
        Width = 718
        Height = 29
        BandType = btColumnHeader
        Color = clInfoBk
        ParentColor = False
        Transparent = False
        object RLLabel4: TRLLabel
          Left = 21
          Top = 7
          Width = 49
          Height = 16
          Caption = 'C'#243'digo'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = False
        end
        object RLLabel3: TRLLabel
          Left = 109
          Top = 7
          Width = 108
          Height = 16
          Caption = 'Nome do cliente'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = False
        end
        object RLLabel6: TRLLabel
          Left = 601
          Top = 7
          Width = 101
          Height = 16
          Alignment = taRightJustify
          Caption = 'Valor da venda'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = False
        end
      end
      object RLBand1: TRLBand
        Left = 0
        Top = 58
        Width = 718
        Height = 34
        object RLDBText1: TRLDBText
          Left = 21
          Top = 9
          Width = 52
          Height = 16
          DataField = 'clienteId'
          DataSource = dtsVenda
          Text = ''
        end
        object RLDBText2: TRLDBText
          Left = 109
          Top = 9
          Width = 36
          Height = 16
          DataField = 'nome'
          DataSource = dtsVenda
          Text = ''
        end
        object RLDBText4: TRLDBText
          Left = 636
          Top = 9
          Width = 66
          Height = 16
          Alignment = taRightJustify
          DataField = 'totalVenda'
          DataSource = dtsVenda
          Text = ''
        end
      end
      object RLBand4: TRLBand
        Left = 0
        Top = 92
        Width = 718
        Height = 61
        BandType = btSummary
        object RLDBResult1: TRLDBResult
          Left = 597
          Top = 14
          Width = 105
          Height = 16
          Alignment = taRightJustify
          DataField = 'totalVenda'
          DataSource = dtsVenda
          Info = riSum
          Text = ''
        end
        object RLDraw3: TRLDraw
          Left = 416
          Top = 0
          Width = 300
          Height = 15
          DrawKind = dkLine
        end
        object lblTotaVendaPorData: TRLLabel
          Left = 425
          Top = 14
          Width = 134
          Height = 16
          Alignment = taRightJustify
          Caption = 'Venda total por data'
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
    object RLBand5: TRLBand
      Left = 38
      Top = 257
      Width = 718
      Height = 48
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
  object qryVendas: TFDQuery
    Connection = dtmPrincipal.ConexaoDB
    SQL.Strings = (
      'select v.vendaId,'
      '       v.clienteId,'
      '       c.nome,'
      '       v.dataVenda,'
      '       v.totalVenda'
      'from vendas v inner join clientes c'
      'on c.clienteId = v.clienteId where'
      'v.dataVenda between :dataInicio and '
      ':dataFinal order by v.dataVenda,'
      'v.clienteId')
    Left = 152
    Top = 720
    ParamData = <
      item
        Name = 'DATAINICIO'
        DataType = ftDate
        FDDataType = dtDate
        ParamType = ptInput
        Value = 45597d
      end
      item
        Name = 'DATAFINAL'
        DataType = ftDate
        ParamType = ptInput
        Value = '30/11/2024'
      end>
    object qryVendasvendaId: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'vendaId'
      Origin = 'vendaId'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object qryVendasclienteId: TIntegerField
      FieldName = 'clienteId'
      Origin = 'clienteId'
      Required = True
    end
    object qryVendasnome: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'nome'
      Origin = 'nome'
      ProviderFlags = []
      ReadOnly = True
      Size = 60
    end
    object qryVendasdataVenda: TDateTimeField
      AutoGenerateValue = arDefault
      FieldName = 'dataVenda'
      Origin = 'dataVenda'
      DisplayFormat = 'dd/mm/yyyy'
    end
    object qryVendastotalVenda: TFMTBCDField
      AutoGenerateValue = arDefault
      FieldName = 'totalVenda'
      Origin = 'totalVenda'
      DisplayFormat = '#0.00'
      Precision = 18
      Size = 5
    end
  end
  object dtsVenda: TDataSource
    DataSet = qryVendas
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
end
