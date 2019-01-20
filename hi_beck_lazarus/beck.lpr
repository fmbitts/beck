program Beck;

{$MODE Delphi}

uses
  Forms, Interfaces,
  Tel_ab in 'TEL_AB.PAS' {Tela_abertura},
  Senha in 'SENHA.PAS' {Tela_senha},
  Princip in 'PRINCIP.PAS' {Tela_Principal},
  Abrir in 'ABRIR.PAS' {Tela_abrir},
  Dbmolde in 'DBMOLDE.PAS' {tela_molde},
  Dbmetal in 'DBMETAL.PAS' {tela_metal},
  Simula in 'SIMULA.PAS' {tela_simula},
  Entrada in 'ENTRADA.PAS' {tela_entrada},
  Grupo in 'GRUPO.PAS' {tela_grupo},
  Time in 'TIME.PAS' {tela_time};

{.$R *.RES}

begin
  Application.Title := 'Wingote - Lingotamento Contínuo';
  Application.CreateForm(TTela_abertura, Tela_abertura);
  Application.CreateForm(Ttela_entrada, tela_entrada);
  Application.CreateForm(Ttela_metal, tela_metal);
  Application.CreateForm(Ttela_molde, tela_molde);
  Application.CreateForm(TTela_senha, Tela_senha);
  Application.CreateForm(TTela_Principal, Tela_Principal);
  Application.CreateForm(TTela_abrir, Tela_abrir);
  Application.CreateForm(Ttela_simula, tela_simula);
  Application.CreateForm(Ttela_grupo, tela_grupo);
  Application.CreateForm(Ttela_time, tela_time);
  Application.Run;
end.
