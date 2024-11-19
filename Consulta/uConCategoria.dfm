inherited frmConCategoria: TfrmConCategoria
  Caption = 'Consulta de categorias'
  StyleElements = [seFont, seClient, seBorder]
  TextHeight = 15
  inherited Panel1: TPanel
    StyleElements = [seFont, seClient, seBorder]
    ExplicitWidth = 699
    inherited lblIndice: TLabel
      StyleElements = [seFont, seClient, seBorder]
    end
    inherited mskPesquisa: TMaskEdit
      StyleElements = [seFont, seClient, seBorder]
    end
  end
  inherited Panel2: TPanel
    StyleElements = [seFont, seClient, seBorder]
    ExplicitLeft = 0
    ExplicitTop = 453
    ExplicitWidth = 699
    inherited btnFechar: TBitBtn
      ExplicitLeft = 601
    end
  end
  inherited Panel3: TPanel
    StyleElements = [seFont, seClient, seBorder]
    ExplicitLeft = 0
    ExplicitTop = 57
    ExplicitWidth = 699
    ExplicitHeight = 396
    inherited grdPesquisa: TDBGrid
      Columns = <
        item
          Expanded = False
          FieldName = 'categoriaId'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'descricao'
          Visible = True
        end>
    end
  end
  inherited qryListagem: TFDQuery
    SQL.Strings = (
      'select categoriaId, descricao'
      'from categorias')
    object qryListagemcategoriaId: TFDAutoIncField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'categoriaId'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = False
    end
    object qryListagemdescricao: TStringField
      DisplayLabel = 'Descricao'
      FieldName = 'descricao'
      Required = True
      Size = 100
    end
  end
end
