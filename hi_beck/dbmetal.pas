unit Dbmetal;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  StdCtrls, Forms, DBCtrls, DB, DBTables, Mask, ExtCtrls;

type
  Ttela_metal = class(TForm)
    ScrollBox: TScrollBox;
    Label1: TLabel;
    EditMaterial_metal: TDBEdit;
    Label2: TLabel;
    EditCondutividade_solido: TDBEdit;
    Label3: TLabel;
    EditCondutividade_liquido: TDBEdit;
    Label4: TLabel;
    EditDensidade_solido: TDBEdit;
    Label5: TLabel;
    EditDensidade_liquido: TDBEdit;
    Label6: TLabel;
    EditCalor_especifico_solido: TDBEdit;
    Label7: TLabel;
    EditCalor_especifico_liquido: TDBEdit;
    Label8: TLabel;
    EditKo_coeficiente_particao: TDBEdit;
    Label9: TLabel;
    EditDifusividade_solido: TDBEdit;
    Label10: TLabel;
    EditDifusividade_liquido: TDBEdit;
    DBNavigator: TDBNavigator;
    Panel1: TPanel;
    DataSource1: TDataSource;
    Panel2: TPanel;
    Table1: TTable;
    Table1Material_metal: TStringField;
    Table1Condutividade_solido: TFloatField;
    Table1Condutividade_liquido: TFloatField;
    Table1Densidade_solido: TFloatField;
    Table1Densidade_liquido: TFloatField;
    Table1Calor_especifico_solido: TFloatField;
    Table1Calor_especifico_liquido: TFloatField;
    Table1Ko_coeficiente_particao: TFloatField;
    Table1Difusividade_solido: TFloatField;
    Table1Difusividade_liquido: TFloatField;
    Table1Lambida: TFloatField;
    Label11: TLabel;
    Editlambida: TDBEdit;
    Label12: TLabel;
    Label13: TLabel;
    EditCalor_latente_fusao: TLabel;
    Table1Calor_latente_fusao: TFloatField;
    DBEdit1: TDBEdit;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    EditTemperatura_fusao: TDBEdit;
    EditTemperatura_solidus: TDBEdit;
    EditTemperatura_liquidus: TDBEdit;
    Table1Temperatura_fusao: TFloatField;
    Table1Temperatura_solidus: TFloatField;
    Table1Temperatura_liquidus: TFloatField;
    Table1Condutividade_eutetico: TFloatField;
    Table1Calor_especifico_eutetico: TFloatField;
    Table1Densidade_eutetico: TFloatField;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    DBComboBox1: TDBComboBox;
    Table1Formulacao_fs: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure EditCalor_especifico_solidoExit(Sender: TObject);
    procedure EditCalor_especifico_liquidoExit(Sender: TObject);
    procedure DBEdit1Exit(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DBComboBox1Change(Sender: TObject);
    procedure DBNavigatorClick(Sender: TObject; Button: TNavigateBtn);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  tela_metal: Ttela_metal;

implementation

{$R *.DFM}

procedure Ttela_metal.FormCreate(Sender: TObject);
begin
  Table1.Open;
  label12.caption:=DBCombobox1.text;
end;

procedure Ttela_metal.EditCalor_especifico_solidoExit(Sender: TObject);
var alfas,ks,ds,cs: real;
     cod:integer;
begin
  Table1difusividade_solido.value:=(Table1Condutividade_solido.value/
  (Table1Densidade_solido.value * Table1Calor_especifico_solido.value));
end;

procedure Ttela_metal.EditCalor_especifico_liquidoExit(Sender: TObject);
begin
Table1difusividade_liquido.value:=(Table1Condutividade_liquido.value/
 (Table1Densidade_liquido.value * Table1Calor_especifico_liquido.value));
end;

procedure Ttela_metal.DBEdit1Exit(Sender: TObject);
begin
  Table1lambida.value:=
  (Table1Calor_latente_fusao.value / Table1Calor_especifico_liquido.value);
end;

procedure Ttela_metal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   table1.close;
end;

procedure Ttela_metal.DBComboBox1Change(Sender: TObject);
begin
  label12.caption:=DBCombobox1.text;
   Table1Formulacao_fs.value:=dbComboBox1.text;
end;

procedure Ttela_metal.DBNavigatorClick(Sender: TObject;
  Button: TNavigateBtn);
begin
    label12.caption:=DBCombobox1.text;
end;

end.
