object frmRelProdutosComGrupoCategoria: TfrmRelProdutosComGrupoCategoria
  Left = 0
  Top = 0
  Caption = 'Relat'#243'rio de produtos por categoria'
  ClientHeight = 793
  ClientWidth = 769
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  TextHeight = 15
  object relatorio: TRLReport
    Left = -8
    Top = 0
    Width = 794
    Height = 1123
    DataSource = dtsProdutos
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
        Width = 368
        Height = 24
        Caption = 'Listagem de produtos por categoria'
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
      Top = 257
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
      DataFields = 'categoriaId'
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
          Width = 70
          Height = 16
          Caption = 'Categoria:'
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
          Width = 43
          Height = 16
          DataField = 'categoriaId'
          DataSource = dtsProdutos
          Text = ''
        end
        object RLDBText6: TRLDBText
          Left = 166
          Top = 7
          Width = 115
          Height = 16
          DataField = 'descricaoCategoria'
          DataSource = dtsProdutos
          Text = ''
        end
        object RLLabel8: TRLLabel
          Left = 139
          Top = 7
          Width = 8
          Height = 16
          Alignment = taCenter
          Caption = '-'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
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
          Width = 41
          Height = 16
          Caption = 'Nome'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = False
        end
        object RLLabel5: TRLLabel
          Left = 445
          Top = 7
          Width = 54
          Height = 16
          Alignment = taRightJustify
          Caption = 'Estoque'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = False
        end
        object RLLabel6: TRLLabel
          Left = 648
          Top = 7
          Width = 38
          Height = 16
          Alignment = taRightJustify
          Caption = 'Valor'
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
          Left = 16
          Top = 9
          Width = 57
          Height = 16
          DataField = 'produtoId'
          DataSource = dtsProdutos
          Text = ''
        end
        object RLDBText2: TRLDBText
          Left = 104
          Top = 9
          Width = 36
          Height = 16
          DataField = 'nome'
          DataSource = dtsProdutos
          Text = ''
        end
        object RLDBText3: TRLDBText
          Left = 440
          Top = 9
          Width = 67
          Height = 16
          Alignment = taRightJustify
          DataField = 'quantidade'
          DataSource = dtsProdutos
          Text = ''
        end
        object RLDBText4: TRLDBText
          Left = 648
          Top = 9
          Width = 30
          Height = 16
          Alignment = taRightJustify
          DataField = 'valor'
          DataSource = dtsProdutos
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
          Left = 572
          Top = 14
          Width = 106
          Height = 16
          Alignment = taRightJustify
          DataField = 'quantidade'
          DataSource = dtsProdutos
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
        object RLLabel9: TRLLabel
          Left = 416
          Top = 14
          Width = 143
          Height = 16
          Alignment = taRightJustify
          Caption = 'Estoque por categoria'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = False
        end
        object RLLabel10: TRLLabel
          Left = 416
          Top = 34
          Width = 99
          Height = 16
          Alignment = taRightJustify
          Caption = 'M'#233'dia do valor'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = False
        end
        object RLDBResult2: TRLDBResult
          Left = 590
          Top = 34
          Width = 88
          Height = 16
          Alignment = taRightJustify
          DataField = 'valor'
          DataSource = dtsProdutos
          Info = riAverage
          Text = ''
        end
      end
    end
  end
  object qryProdutos: TFDQuery
    Connection = dtmPrincipal.ConexaoDB
    SQL.Strings = (
      'select p.produtoId,'
      '       p.nome,'
      '       p.descricao,'
      '       p.valor,'
      '       p.quantidade,'
      '       p.categoriaId,'
      '       c.descricao as descricaoCategoria'
      'from produtos p left join'
      'categorias c on c.categoriaId = p.categoriaId'
      'order by p.categoriaId, p.produtoId  ')
    Left = 152
    Top = 720
    object qryProdutosprodutoId: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'produtoId'
      Origin = 'produtoId'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object qryProdutosnome: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'nome'
      Origin = 'nome'
      Size = 60
    end
    object qryProdutosdescricao: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'descricao'
      Origin = 'descricao'
      Size = 255
    end
    object qryProdutosvalor: TFMTBCDField
      AutoGenerateValue = arDefault
      FieldName = 'valor'
      Origin = 'valor'
      DisplayFormat = '#0.00'
      Precision = 18
      Size = 5
    end
    object qryProdutosquantidade: TFMTBCDField
      AutoGenerateValue = arDefault
      FieldName = 'quantidade'
      Origin = 'quantidade'
      DisplayFormat = '#0.00'
      Precision = 18
      Size = 5
    end
    object qryProdutoscategoriaId: TIntegerField
      FieldName = 'categoriaId'
      Origin = 'categoriaId'
      Required = True
    end
    object qryProdutosdescricaoCategoria: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'descricaoCategoria'
      Origin = 'descricao'
      ProviderFlags = []
      ReadOnly = True
      Size = 100
    end
  end
  object dtsProdutos: TDataSource
    DataSet = qryProdutos
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
