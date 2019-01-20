unit Entrada;

interface

uses
  SysUtils,
  //WinTypes,
  //WinProcs,
  Messages, Classes, Graphics, Controls,
  StdCtrls, Forms, DBCtrls, DB, ExtCtrls,
  //TabNotBk,
  //DBTables,
  //Mask,
  //DBLookup,
  Grids;

type

  vetor = array[0..200]of real;


  Ttela_entrada = class(TForm)
    ScrollBox: TScrollBox;
    Label1: TLabel;
    Label2: TLabel;
    EditTemperatura_ambiente: TDBEdit;
    Label3: TLabel;
    EditTemperatura_vazamento: TDBEdit;
    Label4: TLabel;
    EditComprimento_molde: TDBEdit;
    Label5: TLabel;
    EditNumero_divisoes_molde: TDBEdit;
    Label6: TLabel;
    EditComprimento_metal: TDBEdit;
    Label7: TLabel;
    EditNumero_divisoes_metal: TDBEdit;
    Label8: TLabel;
    EditDy: TDBEdit;
    Label9: TLabel;
    EditDz: TDBEdit;
    Label10: TLabel;
    EditTempo_maximo_processo: TDBEdit;
    Label11: TLabel;
    EditIncremento_tempo_dt: TDBEdit;
    Label14: TLabel;
    EditDx_molde: TDBEdit;
    Label15: TLabel;
    EditDx_metal: TDBEdit;
    Label16: TLabel;
    EditArea_total: TDBEdit;
    Label17: TLabel;
    EditVolume: TDBEdit;
    DBNavigator: TDBNavigator;
    Panel1: TPanel;
    DataSource1: TDataSource;
    Panel2: TPanel;
    //Table1: TTable;

    {Tabela referente aos dados operacionais}
    Table1Numero_simulacao: TFloatField;
    Table1Temperatura_ambiente: TFloatField;
    Table1Temperatura_vazamento: TFloatField;
    Table1Comprimento_molde: TFloatField;
    Table1Numero_divisoes_molde: TFloatField;
    Table1Comprimento_metal: TFloatField;
    Table1Numero_divisoes_metal: TFloatField;
    Table1Dy: TFloatField;
    Table1Dz: TFloatField;
    Table1Tempo_maximo_processo: TFloatField;
    Table1Incremento_tempo_dt: TFloatField;
    Table1Dx_molde: TFloatField;
    Table1Dx_metal: TFloatField;
    Table1Area_total: TFloatField;
    Table1Volume: TFloatField;
    DataSource2: TDataSource;
    //Table2: TTable;
    //Table3: TTable;
    DataSource3: TDataSource;

    {Tabela referente ao molde}
    Table3Material_Molde: TStringField;
    Table3Condutividade_Molde: TFloatField;
    Table3Densidade_Molde: TFloatField;
    Table3Calor_Especifico_Molde: TFloatField;

    {Tabela referente ao metal}
    Table2Material_metal: TStringField;
    Table2Condutividade_solido: TFloatField;
    Table2Condutividade_liquido: TFloatField;
    Table2Densidade_solido: TFloatField;
    Table2Densidade_liquido: TFloatField;
    Table2Calor_especifico_solido: TFloatField;
    Table2Calor_especifico_liquido: TFloatField;
    Table2Ko_coeficiente_particao: TFloatField;
    Table2Difusividade_solido: TFloatField;
    Table2Difusividade_liquido: TFloatField;
    Table2Lambida: TFloatField;
    Table2Calor_latente_fusao: TFloatField;
    Table2Temperatura_fusao: TFloatField;
    Table2Temperatura_solidus: TFloatField;
    Table2Temperatura_liquidus: TFloatField;

    Label18: TLabel;
    Label19: TLabel;
    //DBLookupCombo1: TDBLookupCombo;
    //DBLookupCombo2: TDBLookupCombo;
    Button1: TButton;
    Table1Coef_metal_molde_c: TFloatField;
    Table1Coef_molde_ambient_d: TFloatField;
    Table1Coef_metal_molde_n: TFloatField;
    Table1Coef_molde_ambient_m: TFloatField;
    Label12: TLabel;
    Label13: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Coef_metal_molde_c: TDBEdit;
    Coef_metal_molde_n: TDBEdit;
    Coef_molde_ambient_d: TDBEdit;
    Coef_molde_ambient_m: TDBEdit;
    Label20: TLabel;
    Table2Condutividade_eutetico: TFloatField;
    Table2Calor_especifico_eutetico: TFloatField;
    Table2Densidade_eutetico: TFloatField;
    Table2Formulacao_fs: TStringField;
    Label26: TLabel;
    StringGrid1: TStringGrid;
    Label21: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure EditNumero_divisoes_moldeExit(Sender: TObject);
    procedure EditNumero_divisoes_metalExit(Sender: TObject);
    procedure EditDzExit(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  tela_entrada: Ttela_entrada;
  OK : boolean ;


    fp1,fp2: textfile;

   i:integer;
   tempo: real;
   flag:boolean;

   temp_atual, temp_calc, temp_acum : vetor;
   condutividade, calor_especifico, densidade: vetor;

   hi,hamb : real;

   x, kk, x1, y1, z1 :string[11];

   tal_vet:array [-1..1]of real;


implementation

   uses time;

{$R *.DFM}


procedure Ttela_entrada.FormCreate(Sender: TObject);
begin
  {Abertura de todos os arquivos assim que a tela liberar acesso}
  Table1.Open;
  Table2.Open;
  Table3.Open;
end;

procedure Ttela_entrada.EditNumero_divisoes_moldeExit(Sender: TObject);
begin
   {Cálculo para o comprimento de cada divisão no molde}
   Table1dx_molde.value:=Table1comprimento_molde.value/
   Table1numero_divisoes_molde.value;
end;

procedure Ttela_entrada.EditNumero_divisoes_metalExit(Sender: TObject);
begin
   {Cálculo para o comprimento de cada divisão no metal}
   Table1dx_metal.value:=Table1comprimento_metal.value/
   Table1numero_divisoes_metal.value;
end;

procedure Ttela_entrada.EditDzExit(Sender: TObject);
begin
 {Cálculo automático da área,volume e do incremento de tempo*}

 {*A rotina de incremento deve ser atualizada para verificar
 se o metal foi selecionado, pois a difusividade está no banco de
 dados do metal}

 table1area_total.value:=table1dy.value*table1dz.value;

 table1volume.value:=table1area_total.value*table1dx_metal.value;

 table1Incremento_tempo_dt.value := ((
   ((Table1dx_metal.value*Table1dx_metal.value) /
   (Table2Difusividade_solido.value * 2)))* 0.7);

end;

procedure Ttela_entrada.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 {Ao sair da tela de entrada, fecha os arquivos
 fazendo a gravação dos dados no HD}
  table1.close;
  table2.close;
  table3.close;
end;

procedure Ttela_entrada.Button1Click(Sender: TObject);

begin
  tela_time.show;
  tela_time.visible:=true;
end;



end.
