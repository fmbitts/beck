unit Simula;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, MPlayer, ExtCtrls;

type
  Ttela_simula = class(TForm)
    Panel2: TPanel;
    MediaPlayer1: TMediaPlayer;
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  tela_simula: Ttela_simula;

implementation

{$R *.DFM}

procedure Ttela_simula.FormActivate(Sender: TObject);
begin
 mediaplayer1.open;
  mediaplayer1.play;
end;

end.
