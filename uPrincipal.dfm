object frmPrincipal: TfrmPrincipal
  Left = 0
  Top = 0
  Caption = 'Menu principal'
  ClientHeight = 815
  ClientWidth = 1618
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Menu = mainPrincipal
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 15
  object stbPrincipal: TStatusBar
    Left = 0
    Top = 796
    Width = 1618
    Height = 19
    Panels = <
      item
        Width = 150
      end>
    ExplicitTop = 513
    ExplicitWidth = 878
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1618
    Height = 42
    Align = alTop
    Caption = 'Dashboard'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    OnClick = Panel1Click
    ExplicitWidth = 878
  end
  object GridPanel1: TGridPanel
    Left = 0
    Top = 42
    Width = 1618
    Height = 754
    Align = alClient
    ColumnCollection = <
      item
        Value = 50.000000000000000000
      end
      item
        Value = 50.000000000000000000
      end>
    ControlCollection = <
      item
        Column = 0
        Control = DBChart1
        Row = 0
      end
      item
        Column = 1
        Control = DBChart2
        Row = 0
      end
      item
        Column = 0
        Control = DBChart3
        Row = 1
      end
      item
        Column = 1
        Control = DBChart4
        Row = 1
      end>
    RowCollection = <
      item
        Value = 50.000000000000000000
      end
      item
        Value = 50.000000000000000000
      end
      item
        SizeStyle = ssAuto
      end>
    TabOrder = 2
    ExplicitWidth = 878
    ExplicitHeight = 471
    object DBChart1: TDBChart
      Left = 1
      Top = 1
      Width = 808
      Height = 376
      Title.Text.Strings = (
        'Produto em estoque')
      Align = alClient
      TabOrder = 0
      ExplicitWidth = 438
      ExplicitHeight = 234
      DefaultCanvas = 'TGDIPlusCanvas'
      PrintMargins = (
        15
        18
        15
        18)
      ColorPaletteIndex = 13
      object Series1: TBarSeries
        HoverElement = []
        Marks.Brush.Gradient.Colors = <
          item
            Color = clRed
          end
          item
            Color = 819443
            Offset = 0.067915690866510540
          end
          item
            Color = clYellow
            Offset = 1.000000000000000000
          end>
        Marks.Brush.Gradient.Direction = gdTopBottom
        Marks.Brush.Gradient.EndColor = clYellow
        Marks.Brush.Gradient.MidColor = 819443
        Marks.Brush.Gradient.StartColor = clRed
        Marks.Brush.Gradient.Visible = True
        Marks.Font.Color = 159
        Marks.Font.Name = 'Tahoma'
        Marks.Font.Style = [fsBold, fsItalic]
        Marks.Frame.Color = 33023
        Marks.RoundSize = 14
        Marks.Visible = False
        DataSource = dtmGrafico.qryProdutoEstoque
        Title = 'ProdutoEstoque'
        XLabelsSource = 'Label'
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Bar'
        YValues.Order = loNone
        YValues.ValueSource = 'Value'
      end
    end
    object DBChart2: TDBChart
      Left = 809
      Top = 1
      Width = 808
      Height = 376
      Title.Text.Strings = (
        'Valor de venda por cliente na ultima semana')
      Legend.TextStyle = ltsLeftPercent
      View3DOptions.Elevation = 315
      View3DOptions.Orthogonal = False
      View3DOptions.Perspective = 0
      View3DOptions.Rotation = 360
      Align = alClient
      TabOrder = 1
      ExplicitLeft = 439
      ExplicitWidth = 438
      ExplicitHeight = 234
      DefaultCanvas = 'TGDIPlusCanvas'
      ColorPaletteIndex = 13
      object Series2: TPieSeries
        HoverElement = []
        Marks.Brush.Gradient.Colors = <
          item
            Color = clRed
          end
          item
            Color = 819443
            Offset = 0.067915690866510540
          end
          item
            Color = clYellow
            Offset = 1.000000000000000000
          end>
        Marks.Brush.Gradient.Direction = gdTopBottom
        Marks.Brush.Gradient.EndColor = clYellow
        Marks.Brush.Gradient.MidColor = 819443
        Marks.Brush.Gradient.StartColor = clRed
        Marks.Brush.Gradient.Visible = True
        Marks.Font.Color = 159
        Marks.Font.Name = 'Tahoma'
        Marks.Font.Style = [fsBold, fsItalic]
        Marks.Frame.Color = 33023
        Marks.RoundSize = 14
        Marks.Visible = False
        Marks.Style = smsLabelPercent
        Marks.Callout.Length = 20
        Marks.Tail.Margin = 2
        DataSource = dtmGrafico.qryVendaValorPorCliente
        Title = 'ValorDeVendaPorClienteNaUltimaSemana'
        XLabelsSource = 'Label'
        XValues.Order = loAscending
        YValues.Name = 'Pie'
        YValues.Order = loNone
        YValues.ValueSource = 'value'
        Frame.InnerBrush.BackColor = clRed
        Frame.InnerBrush.Gradient.EndColor = clGray
        Frame.InnerBrush.Gradient.MidColor = clWhite
        Frame.InnerBrush.Gradient.StartColor = 4210752
        Frame.InnerBrush.Gradient.Visible = True
        Frame.MiddleBrush.BackColor = clYellow
        Frame.MiddleBrush.Gradient.EndColor = 8553090
        Frame.MiddleBrush.Gradient.MidColor = clWhite
        Frame.MiddleBrush.Gradient.StartColor = clGray
        Frame.MiddleBrush.Gradient.Visible = True
        Frame.OuterBrush.BackColor = clGreen
        Frame.OuterBrush.Gradient.EndColor = 4210752
        Frame.OuterBrush.Gradient.MidColor = clWhite
        Frame.OuterBrush.Gradient.StartColor = clSilver
        Frame.OuterBrush.Gradient.Visible = True
        Frame.Width = 4
        OtherSlice.Legend.Visible = False
      end
    end
    object DBChart3: TDBChart
      Left = 1
      Top = 377
      Width = 808
      Height = 376
      Title.Text.Strings = (
        ' Os 10 produtos mais vendidos')
      Legend.TextStyle = ltsLeftPercent
      View3DOptions.Elevation = 315
      View3DOptions.Orthogonal = False
      View3DOptions.Perspective = 0
      View3DOptions.Rotation = 360
      Align = alClient
      TabOrder = 2
      ExplicitTop = 235
      ExplicitWidth = 438
      ExplicitHeight = 235
      DefaultCanvas = 'TGDIPlusCanvas'
      ColorPaletteIndex = 13
      object Series3: TPieSeries
        HoverElement = []
        Marks.Brush.Gradient.Colors = <
          item
            Color = clRed
          end
          item
            Color = 819443
            Offset = 0.067915690866510540
          end
          item
            Color = clYellow
            Offset = 1.000000000000000000
          end>
        Marks.Brush.Gradient.Direction = gdTopBottom
        Marks.Brush.Gradient.EndColor = clYellow
        Marks.Brush.Gradient.MidColor = 819443
        Marks.Brush.Gradient.StartColor = clRed
        Marks.Brush.Gradient.Visible = True
        Marks.Font.Color = 159
        Marks.Font.Name = 'Tahoma'
        Marks.Font.Style = [fsBold, fsItalic]
        Marks.Frame.Color = 33023
        Marks.RoundSize = 14
        Marks.Style = smsLabelPercent
        Marks.Callout.Length = 20
        Marks.Tail.Margin = 2
        DataSource = dtmGrafico.qry10ProdutosMaisVendidos
        Title = '10ProdutosMaisVendidos'
        XLabelsSource = 'Label'
        XValues.Order = loAscending
        YValues.Name = 'Pie'
        YValues.Order = loNone
        YValues.ValueSource = 'Value'
        Frame.InnerBrush.BackColor = clRed
        Frame.InnerBrush.Gradient.EndColor = clGray
        Frame.InnerBrush.Gradient.MidColor = clWhite
        Frame.InnerBrush.Gradient.StartColor = 4210752
        Frame.InnerBrush.Gradient.Visible = True
        Frame.MiddleBrush.BackColor = clYellow
        Frame.MiddleBrush.Gradient.EndColor = 8553090
        Frame.MiddleBrush.Gradient.MidColor = clWhite
        Frame.MiddleBrush.Gradient.StartColor = clGray
        Frame.MiddleBrush.Gradient.Visible = True
        Frame.OuterBrush.BackColor = clGreen
        Frame.OuterBrush.Gradient.EndColor = 4210752
        Frame.OuterBrush.Gradient.MidColor = clWhite
        Frame.OuterBrush.Gradient.StartColor = clSilver
        Frame.OuterBrush.Gradient.Visible = True
        Frame.Width = 4
        OtherSlice.Legend.Visible = False
      end
    end
    object DBChart4: TDBChart
      Left = 809
      Top = 377
      Width = 808
      Height = 376
      Title.Text.Strings = (
        'Vendas da ultima semana')
      Align = alClient
      TabOrder = 3
      ExplicitLeft = 439
      ExplicitTop = 235
      ExplicitWidth = 438
      ExplicitHeight = 235
      DefaultCanvas = 'TGDIPlusCanvas'
      ColorPaletteIndex = 13
      object Series4: TFastLineSeries
        HoverElement = []
        DataSource = dtmGrafico.qryVendasUltimaSemana
        Title = 'VendasDaUltimaSemana'
        XLabelsSource = 'Label'
        LinePen.Color = 10708548
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Y'
        YValues.Order = loNone
        YValues.ValueSource = 'Value'
      end
    end
  end
  object mainPrincipal: TMainMenu
    Left = 536
    Top = 65528
    object Cadastro1: TMenuItem
      Caption = 'Cadastro'
      object Cliente1: TMenuItem
        Caption = 'Cliente'
        OnClick = Cliente1Click
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Categoria1: TMenuItem
        Caption = 'Categoria'
        OnClick = Categoria1Click
      end
      object Produto1: TMenuItem
        Caption = 'Produto'
        OnClick = Produto1Click
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object Usuario1: TMenuItem
        Caption = 'Usu'#225'rio'
        OnClick = Usuario1Click
      end
      object AcaoAcesso1: TMenuItem
        Caption = 'A'#231#227'o Acesso'
        OnClick = AcaoAcesso1Click
      end
      object N5: TMenuItem
        Caption = '-'
      end
      object Aesporusurio1: TMenuItem
        Caption = 'A'#231#245'es por usu'#225'rio'
        OnClick = Aesporusurio1Click
      end
      object N4: TMenuItem
        Caption = '-'
      end
      object Alterarsenha1: TMenuItem
        Caption = 'Alterar senha'
        OnClick = Alterarsenha1Click
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object mnuFechar: TMenuItem
        Caption = 'Fechar'
        OnClick = mnuFecharClick
      end
    end
    object Movimentao1: TMenuItem
      Caption = 'Movimenta'#231#227'o'
      object Vendas1: TMenuItem
        Caption = 'Vendas'
        OnClick = Vendas1Click
      end
    end
    object Relatrios1: TMenuItem
      Caption = 'Relat'#243'rios'
      object Categoria2: TMenuItem
        Caption = 'Categorias'
        OnClick = CategoriaRel1Click
      end
      object Cliente2: TMenuItem
        Caption = 'Cliente'
        OnClick = ClienteRel1Click
      end
      object Fichadecliente1: TMenuItem
        Caption = 'Ficha de cliente'
        OnClick = Fichadecliente1Click
      end
      object Cliente3: TMenuItem
        Caption = '-'
      end
      object Produto2: TMenuItem
        Caption = 'Produto'
        OnClick = ProdutoRel1Click
      end
      object Produtosporcategoria1: TMenuItem
        Caption = 'Produtos por categoria'
        OnClick = Produtosporcategoria1Click
      end
      object Produto3: TMenuItem
        Caption = '-'
      end
      object Vendapordata1: TMenuItem
        Caption = 'Venda por data'
        OnClick = Vendapordata1Click
      end
    end
  end
  object tmrAtualizacaoDashboard: TTimer
    Interval = 60000
    OnTimer = tmrAtualizacaoDashboardTimer
    Left = 816
  end
end
