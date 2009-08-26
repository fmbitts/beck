unit Dbmolde;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  StdCtrls, Forms, DBCtrls, DB, DBTables, Mask, ExtCtrls;

type
  Ttela_molde = class(TForm)
    ScrollBox: TScrollBox;
    Label1: TLabel;
    EditMaterial_Molde: TDBEdit;
    Label2: TLabel;
    EditCondutividade_Molde: TDBEdit;
    Label3: TLabel;
    EditDensidade_Molde: TDBEdit;
    Label4: TLabel;
    EditCalor_Especifico_Molde: TDBEdit;
    DBNavigator: TDBNavigator;
    Panel1: TPanel;
    DataSource1: TDataSource;
    Panel2: TPanel;
    Table1: TTable;
    Table1Material_Molde: TStringField;
    Table1Condutividade_Molde: TFloatField;
    Table1Densidade_Molde: TFloatField;
    Table1Calor_Especifico_Molde: TFloatField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  tela_molde: Ttela_molde;

implementation

uses entrada;
{$R *.DFM}

procedure Ttela_molde.FormCreate(Sender: TObject);
begin
  Table1.Open;
end;

procedure Ttela_molde.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    table1.close;
end;

end.
