�
 TTELA_METAL 0�  TPF0Ttela_metal
tela_metalLeft� Top� WidthHeight�ActiveControlPanel1Caption
tela_metalFont.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameMS Sans Serif
Font.Style PositionpoScreenCenterOnClose	FormCloseOnCreate
FormCreateOnShow
FormCreatePixelsPerInch`
TextHeight TPanelPanel1Left Top Width�Height)AlignalTopTabOrder  TDBNavigatorDBNavigatorLeftTopWidth� Height
DataSourceDataSource1Ctl3DParentCtl3DTabOrder OnClickDBNavigatorClick   TPanelPanel2Left Top)Width�HeightPAlignalClient
BevelInner	bvLoweredBorderWidthCaptionPanel2TabOrder 
TScrollBox	ScrollBoxLeftTopWidth�HeightDHorzScrollBar.MarginHorzScrollBar.RangeVertScrollBar.MarginVertScrollBar.Range� AlignalClient
AutoScrollBorderStylebsNoneTabOrder  TLabelLabel1LeftTopWidthDHeightCaptionMaterial_metalFocusControlEditMaterial_metal  TLabelLabel2LeftTop4Width� HeightCaptionCondutividade_solido [W/m.K]FocusControlEditCondutividade_solido  TLabelLabel3LeftTop4Width� HeightCaptionCondutividade_liquido [W/m.K]FocusControlEditCondutividade_liquido  TLabelLabel4LeftTopNWidth|HeightCaptionDensidade_solido [kg/m3]FocusControlEditDensidade_solido  TLabelLabel5LeftTopNWidthHeightCaptionDensidade_liquido [kg/m3]FocusControlEditDensidade_liquido  TLabelLabel6LeftTopgWidth� HeightCaption Calor_especifico_solido [J/kg.K]FocusControlEditCalor_especifico_solido  TLabelLabel7Left� TopgWidth� HeightCaption!Calor_especifico_liquido [J/kg.K]FocusControlEditCalor_especifico_liquido  TLabelLabel8Left(Top� WidthsHeightCaptionKo_coeficiente_particaoFocusControlEditKo_coeficiente_particao  TLabelLabel9LeftTop� Width|HeightCaptionDifusividade_solido [m2/s]FocusControlEditDifusividade_solido  TLabelLabel10LeftTop� WidthHeightCaptionDifusividade_liquido [m2/s]FocusControlEditDifusividade_liquido  TLabelLabel11LeftsTop� Width(HeightCaptionLambida  TLabelLabel12LefttTop
Width$HeightCaption------------Font.CharsetDEFAULT_CHARSET
Font.ColorclNavyFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFont  TLabelLabel13LeftTopWidthTHeightCaptionFormula��o de fs:  TLabelEditCalor_latente_fusaoLeftTop� Width}HeightCaptionCalor_latente_fusao [J/kg]  TLabelLabel14Left)Top� WidthlHeightCaptionTemperatura_fus�o [C]  TLabelLabel15Left#Top� WidthrHeightCaptionTemperatura_solidus [C]  TLabelLabel16Left Top� WidthuHeightCaptionTemperatura_liquidus [C]  TLabelLabel17Left� Top� Width� HeightCaptionCondutividade_eut�tico [W/m.K]  TLabelLabel18Left� TopWidth� HeightCaption"Calor_espec�fico_eut�tico [J/kg.K]  TLabelLabel19LeftTop(Width� HeightCaptionDensidade_eut�tico [kg/m3]  TDBEditEditMaterial_metalLeft
TopWidth}Height	DataFieldMaterial_metal
DataSourceDataSource1	MaxLengthTabOrder   TDBEditEditCondutividade_solidoLeft� Top4Width2Height	DataFieldCondutividade_solido
DataSourceDataSource1TabOrder  TDBEditEditCondutividade_liquidoLeft�Top4Width2Height	DataFieldCondutividade_liquido
DataSourceDataSource1TabOrder  TDBEditEditDensidade_solidoLeft� TopNWidth2Height	DataFieldDensidade_solido
DataSourceDataSource1TabOrder  TDBEditEditDensidade_liquidoLeft�TopNWidth2Height	DataFieldDensidade_liquido
DataSourceDataSource1TabOrder  TDBEditEditCalor_especifico_solidoLeft� TopgWidth2Height	DataFieldCalor_especifico_solido
DataSourceDataSource1TabOrderOnExitEditCalor_especifico_solidoExit  TDBEditEditCalor_especifico_liquidoLeft�TopgWidth2Height	DataFieldCalor_especifico_liquido
DataSourceDataSource1TabOrderOnExit EditCalor_especifico_liquidoExit  TDBEditEditKo_coeficiente_particaoLeft� Top� Width2Height	DataFieldKo_coeficiente_particao
DataSourceDataSource1TabOrder	  TDBEditEditDifusividade_solidoLeft� Top� Width2HeightTabStopCtl3D		DataFieldDifusividade_solido
DataSourceDataSource1EnabledFont.CharsetDEFAULT_CHARSET
Font.ColorclBlueFont.Height�	Font.NameMS Sans Serif
Font.StylefsBold ParentCtl3D
ParentFontReadOnly	TabOrder  TDBEditEditDifusividade_liquidoLeft�Top� Width2HeightTabStopCtl3D		DataFieldDifusividade_liquido
DataSourceDataSource1EnabledFont.CharsetDEFAULT_CHARSET
Font.ColorclBlueFont.Height�	Font.NameMS Sans Serif
Font.StylefsBold ParentCtl3D
ParentFontReadOnly	TabOrder  TDBEditEditlambidaLeft� Top� Width2HeightTabStopCtl3D		DataFieldLambida
DataSourceDataSource1EnabledFont.CharsetDEFAULT_CHARSET
Font.ColorclBlueFont.Height�	Font.NameMS Sans Serif
Font.StylefsBold ParentCtl3D
ParentFontReadOnly	TabOrder  TDBEditDBEdit1Left� Top� Width2Height	DataFieldCalor_latente_fusao
DataSourceDataSource1TabOrder
OnExitDBEdit1Exit  TDBEditEditTemperatura_fusaoLeft�Top� Width2Height	DataFieldTemperatura_fusao
DataSourceDataSource1TabOrder  TDBEditEditTemperatura_solidusLeft�Top� Width2Height	DataFieldTemperatura_solidus
DataSourceDataSource1TabOrder  TDBEditEditTemperatura_liquidusLeft�Top� Width2Height	DataFieldTemperatura_liquidus
DataSourceDataSource1TabOrder  TDBEditDBEdit2Left�Top� Width3Height	DataFieldCondutividade_eutetico
DataSourceDataSource1TabOrder  TDBEditDBEdit3Left�TopWidth3Height	DataFieldCalor_especifico_eutetico
DataSourceDataSource1TabOrder  TDBEditDBEdit4Left�Top&Width3Height	DataFieldDensidade_eutetico
DataSourceDataSource1TabOrder  TDBComboBoxDBComboBox1LeftTopWidth� Height	DataFieldFormulacao_fs
DataSourceDataSource1
ItemHeightItems.StringsRegra da AlavancaEqua��o de ScheilScheil + Eut�tico
Metal Puro TabOrderOnChangeDBComboBox1Change    TDataSourceDataSource1DataSetTable1Left%Top  TTableTable1DatabaseNamepropriedades	TableNamemetal.dbLeft
Top TStringFieldTable1Material_metal	FieldNameMaterial_metalSize  TFloatFieldTable1Condutividade_solido	FieldNameCondutividade_solido  TFloatFieldTable1Condutividade_liquido	FieldNameCondutividade_liquido  TFloatFieldTable1Densidade_solido	FieldNameDensidade_solido  TFloatFieldTable1Densidade_liquido	FieldNameDensidade_liquido  TFloatFieldTable1Calor_especifico_solido	FieldNameCalor_especifico_solido  TFloatFieldTable1Calor_especifico_liquido	FieldNameCalor_especifico_liquido  TFloatFieldTable1Ko_coeficiente_particao	FieldNameKo_coeficiente_particao  TFloatFieldTable1Difusividade_solido	FieldNameDifusividade_solido  TFloatFieldTable1Difusividade_liquido	FieldNameDifusividade_liquido  TFloatFieldTable1Lambida	FieldNameLambida  TFloatFieldTable1Calor_latente_fusao	FieldNameCalor_latente_fusao  TFloatFieldTable1Temperatura_fusao	FieldNameTemperatura_fusao  TFloatFieldTable1Temperatura_solidus	FieldNameTemperatura_solidus  TFloatFieldTable1Temperatura_liquidus	FieldNameTemperatura_liquidus  TFloatFieldTable1Condutividade_eutetico	FieldNameCondutividade_eutetico  TFloatFieldTable1Calor_especifico_eutetico	FieldNameCalor_especifico_eutetico  TFloatFieldTable1Densidade_eutetico	FieldNameDensidade_eutetico  TStringFieldTable1Formulacao_fs	FieldNameFormulacao_fs    