unit Senha;

interface

uses
     //WinTypes,
     //WinProcs,
     Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons;

type
  TTela_senha = class(TForm)
    Label1: TLabel;
    Password: TEdit;
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    procedure OKBtnClick(Sender: TObject);
    procedure CancelBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Tela_senha: TTela_senha;

implementation
uses
     princip, tel_ab;
{$R *.DFM}

procedure TTela_senha.OKBtnClick(Sender: TObject);
begin
    if password.text = 'teste' then
        begin
          tela_principal.show;
          tela_abertura.destroy;
          tela_senha.close;
        end;
end;

procedure TTela_senha.CancelBtnClick(Sender: TObject);
begin
  halt;
end;

end.
 
