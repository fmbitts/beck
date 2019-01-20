unit Princip;

interface

uses
     //Delphi
  SysUtils,
  //WinTypes,
  //WinProcs,
  Messages, Classes, Graphics, Controls,
  Forms, Dialogs, Menus, ExtCtrls, StdCtrls, Buttons,
  //MPlayer,
  //VBXCtrl,
  //Chart2fx
  PrintersDlgs;// Added for Lazarus Compatibility

  //Lazzarus
  (*
  Classes, SysUtils, FileUtil, PrintersDlgs, Forms, Controls, Graphics, Dialogs,
   StdCtrls;
    *)

type
  TTela_Principal = class(TForm)
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    Novo1: TMenuItem;
    Abrir1: TMenuItem;
    Simulao1: TMenuItem;
    TeladeEsboo1: TMenuItem;
    ExecutarNovaSimulao1: TMenuItem;
    Tabelas1: TMenuItem;
    ConstantesFsicas1: TMenuItem;
    Informaes1: TMenuItem;
    Ajuda1: TMenuItem;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Configuraes1: TMenuItem;
    Sair2: TMenuItem;
    Impressora1: TMenuItem;
    PrinterSetupDialog1: TPrinterSetupDialog;
    BitBtn3: TBitBtn;
    Memo1: TMemo;
    Molde1: TMenuItem;
    Metal1: TMenuItem;
    Metal2: TMenuItem;
    N2: TMenuItem;
    BarradeFerramentas1: TMenuItem;
    BitBtn4: TBitBtn;
    Help1: TMenuItem;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    BitBtn7: TBitBtn;
    Image1: TImage;
    procedure Sair1Click(Sender: TObject);
    procedure Abrir1Click(Sender: TObject);
    procedure Impressora1Click(Sender: TObject);
    procedure ExecutarNovaSimulao1Click(Sender: TObject);
    procedure Molde1Click(Sender: TObject);
    procedure Metal1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn4Click(Sender: TObject);
    procedure Novo1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Tela_Principal: TTela_Principal;

implementation
 uses
      senha, abrir, entrada, dbmolde,
      dbmetal, simula, grupo;
{$R *.DFM}

procedure TTela_Principal.Sair1Click(Sender: TObject);
begin
  Halt;
end;

procedure TTela_Principal.Abrir1Click(Sender: TObject);
begin
tela_abrir.show;
end;

procedure TTela_Principal.Impressora1Click(Sender: TObject);
begin
   PrinterSetupDialog1.Execute;
end;

procedure TTela_Principal.ExecutarNovaSimulao1Click(Sender: TObject);
begin
 tela_entrada.show;
end;

procedure TTela_Principal.Molde1Click(Sender: TObject);
begin
   tela_molde.show;
end;

procedure TTela_Principal.Metal1Click(Sender: TObject);
begin
  tela_metal.show;
end;

procedure TTela_Principal.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  halt;
end;

procedure TTela_Principal.BitBtn4Click(Sender: TObject);
begin
    tela_simula.show;
end;

procedure TTela_Principal.Novo1Click(Sender: TObject);
begin
  tela_grupo.show;
end;


end.
