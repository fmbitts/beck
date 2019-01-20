unit Abrir;

interface

uses
  SysUtils,
  //WinTypes,
  //WinProcs,
  Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Buttons, FileCtrl;

type
  TTela_abrir = class(TForm)
    //DriveComboBox1: TDriveComboBox;
    FilterComboBox1: TFilterComboBox;
    //DirectoryListBox1: TDirectoryListBox;
    FileListBox1: TFileListBox;
    Edit1: TEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label1: TLabel;
    Edit2: TEdit;
    Edit3: TEdit;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    //procedure FileListBox1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Tela_abrir: TTela_abrir;

implementation
 uses princip;
{$R *.DFM}

procedure TTela_abrir.BitBtn1Click(Sender: TObject);
begin

{   Tela_principal.Memo1.Lines.LoadFromFile(edit1.text);}
   close;
end;

procedure TTela_abrir.BitBtn2Click(Sender: TObject);
begin
 close;
end;

(*
procedure TTela_abrir.FileListBox1Click(Sender: TObject);
begin
edit1.text:=filelistbox1.filename;
end;
*)
end.
