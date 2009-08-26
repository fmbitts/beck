unit Tel_ab;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls;

type
  TTela_abertura = class(TForm)
    Image1: TImage;
    Timer1: TTimer;
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Tela_abertura: TTela_abertura;

implementation
uses
     senha;


{$R *.DFM}

procedure TTela_abertura.Timer1Timer(Sender: TObject);
begin
   Tela_senha.show;
   timer1.enabled := false;
end;

end.
