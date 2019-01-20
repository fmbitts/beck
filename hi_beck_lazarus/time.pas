unit Time;
interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, ExtCtrls;

type
  Ttela_time = class(TForm)
    Edit1: TEdit;
    Button1: TButton;
    Edit2: TEdit;
    Edit3: TEdit;
    Shape1: TShape;
    Edit4: TEdit;
    Edit5: TEdit;
    procedure FormActivate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  tela_time: Ttela_time;
  ty,sum :real;
  entra : textfile;
  p:array[0..4]of integer;
  code, cte_hi: integer;
  time_exp,temp_exp1,temp_exp2:integer;
  primeira: boolean;



implementation

uses entrada,abrir;
{$R *.DFM}

procedure RunError(J : byte);
begin
   OK := false ;
end {RunError} ;

type Xtype = extended ; Float = single ;

function ExpFixed(const X : Xtype ; const Y : longint) : Xtype ;
   function ExpNum(const A : Xtype ; const B : longint) : Xtype ;
   begin
      if B=0 then ExpNum := 1.0 else
      if Odd(B) then ExpNum := ExpNum(A, B-1) * A
                else ExpNum := Sqr(ExpNum(A, B div 2)) ;
   end {ExpNum} ;

 begin
  case X=0.0 of
    true : if Y>0 then ExpFixed := 0.0
           else
              if Y=0 then ExpFixed := 1.0
                     else
                        begin
                           ExpFixed := 0.0 ;
                           RunError(200)
                        end ;
    false : if Y<0 then ExpFixed := ExpNum(1.0/X, -Y)
                   else ExpFixed := ExpNum(    X, +Y) ;
    end {case} ;
 end {ExpFixed} ;

function ExpFloat(const X, Y : Float) : Float { X^Y } ;
begin
  if X>0.0 then begin ExpFloat := Exp(Y*Ln(X)) ; EXIT end ;
  if X<0.0 then begin ExpFloat := 0.0 ;
    RunError(234) { or whatever } ; EXIT end ;
  if Y>0.0 then ExpFloat := 0.0
    else if Y=0.0 then ExpFloat := 1.0
    else begin ExpFloat := 0.0 ; RunError(200) { (1/X)^Y } end ;
  end {ExpFloat} ;

function pow(A, B : extended):real;
var J : longint ;
   begin
      J := Round(B) ;
      OK := true ;
      pow:=(ExpFloat(A, B)) ;
   end;

procedure Ttela_time.FormActivate(Sender: TObject);

procedure propriedades;
{Setar as propriedades em função das temperaturas}
var
  i,k :integer;
  fs, dfs: real;
  solido:boolean;

{tela_entrada.Table2Lambida}
begin
 for i := (trunc(tela_entrada.Table1Numero_divisoes_molde.value)+ 1 ) to
  (trunc(tela_entrada.Table1Numero_divisoes_molde.value + tela_entrada.Table1Numero_divisoes_metal.value))
  do
  begin
    if (temp_calc[i] > tela_entrada.Table2Temperatura_liquidus.value) then
      begin
        condutividade[i]:=tela_entrada.Table2Condutividade_liquido.value;
        calor_especifico[i]:=tela_entrada.Table2Calor_especifico_liquido.value;
        densidade[i]:=tela_entrada.Table2Densidade_liquido.value;
      end
   else
      begin
         {Case(0) - Regra da Alavanca}
         if tela_entrada.Table2Formulacao_fs.value = 'Regra da Alavanca' then
            if (temp_calc[i] < tela_entrada.Table2Temperatura_liquidus.value) and
               (temp_calc[i] > tela_entrada.Table2Temperatura_solidus.value) then
                  begin
                     tela_entrada.label26.caption:= '-> Alavanca';
                     tela_entrada.label26.update;

                     fs:= 1.20482 *(
                    (tela_entrada.Table2Temperatura_liquidus.value - temp_calc[i])
                    /(tela_entrada.Table2Temperatura_fusao.value - temp_calc[i]));

                     dfs:= 1.20482 *(
                     (tela_entrada.Table2Temperatura_liquidus.value -
                     tela_entrada.Table2Temperatura_fusao.value)
                     /sqr(tela_entrada.Table2Temperatura_fusao.value - temp_calc[i]));

                    condutividade[i]:=
                        (tela_entrada.Table2Condutividade_solido.value -
                         tela_entrada.Table2Condutividade_liquido.value)* fs +
                         tela_entrada.Table2Condutividade_liquido.value;

                    calor_especifico[i]:=
                         (tela_entrada.Table2Calor_especifico_solido.value -
                          tela_entrada.Table2Calor_especifico_liquido.value)*fs
                          + tela_entrada.Table2Calor_especifico_liquido.value
                          - (tela_entrada.Table2Calor_latente_fusao.value*dfs);

                    densidade[i]:=
                         (tela_entrada.Table2Densidade_solido.value -
                          tela_entrada.Table2Densidade_liquido.value)*fs
                          + tela_entrada.Table2Densidade_liquido.value;
                  end
                  else
                     solido:=true;

                {Case(1) - Equação de Scheil}
                if tela_entrada.Table2Formulacao_fs.value = 'Equação de Scheil' then
                   if (temp_calc[i] < tela_entrada.Table2Temperatura_liquidus.value) and
                   (temp_calc[i] > tela_entrada.Table2Temperatura_solidus.value) then
                  begin
                     tela_entrada.label26.caption:= '-> Scheil';
                     tela_entrada.label26.update;

                    fs:= 1 - pow((
                    (tela_entrada.Table2Temperatura_fusao.value - temp_calc[i])
                    /(tela_entrada.Table2Temperatura_fusao.value -
                      tela_entrada.Table2Temperatura_liquidus.value)),(1 /
                      (tela_entrada.Table2Ko_coeficiente_particao.value - 1)));

                     dfs:= ((-1 /
                      (tela_entrada.Table2Ko_coeficiente_particao.value - 1))*
                        pow((tela_entrada.Table2Temperatura_fusao.value - temp_calc[i])
                        /(tela_entrada.Table2Temperatura_fusao.value -
                        tela_entrada.Table2Temperatura_liquidus.value),
                       (1 /(tela_entrada.Table2Ko_coeficiente_particao.value - 1)) - 1))
                      * (-1 /(tela_entrada.Table2Temperatura_fusao.value -
                      tela_entrada.Table2Temperatura_liquidus.value));

                      condutividade[i]:=
                        (tela_entrada.Table2Condutividade_solido.value -
                         tela_entrada.Table2Condutividade_liquido.value)* fs +
                         tela_entrada.Table2Condutividade_liquido.value;

                      calor_especifico[i]:=
                         (tela_entrada.Table2Calor_especifico_solido.value -
                          tela_entrada.Table2Calor_especifico_liquido.value)*fs
                          + tela_entrada.Table2Calor_especifico_liquido.value
                          - (tela_entrada.Table2Calor_latente_fusao.value*dfs);

                     densidade[i]:=
                         (tela_entrada.Table2Densidade_solido.value -
                          tela_entrada.Table2Densidade_liquido.value)*fs
                          + tela_entrada.Table2Densidade_liquido.value;

               end
               else
                     solido:=true;
            {Case(2) - Scheil+Eutético}
             if tela_entrada.Table2Formulacao_fs.value = 'Scheil + Eutético' then
               if (temp_calc[i] < tela_entrada.Table2Temperatura_liquidus.value) and
                (temp_calc[i] > tela_entrada.Table2Temperatura_solidus.value) then
                 begin
                     tela_entrada.label26.caption:= '-> Sch + Eut';
                     tela_entrada.label26.update;

                fs:= 1 - pow((
                    (tela_entrada.Table2Temperatura_fusao.value - temp_calc[i])
                    /(tela_entrada.Table2Temperatura_fusao.value -
                      tela_entrada.Table2Temperatura_liquidus.value)),(1 /
                      (tela_entrada.Table2Ko_coeficiente_particao.value - 1)));

                dfs:= ((-1 /
                      (tela_entrada.Table2Ko_coeficiente_particao.value - 1))*
                        pow((tela_entrada.Table2Temperatura_fusao.value - temp_calc[i])
                        /(tela_entrada.Table2Temperatura_fusao.value -
                        tela_entrada.Table2Temperatura_liquidus.value),
                       (1 /
                      (tela_entrada.Table2Ko_coeficiente_particao.value - 1)) - 1))
                      * (-1 /(tela_entrada.Table2Temperatura_fusao.value -
                      tela_entrada.Table2Temperatura_liquidus.value));

                condutividade[i]:=
                        (tela_entrada.Table2Condutividade_solido.value -
                         tela_entrada.Table2Condutividade_liquido.value)* fs +
                         tela_entrada.Table2Condutividade_liquido.value;

                calor_especifico[i]:=
                         (tela_entrada.Table2Calor_especifico_solido.value -
                          tela_entrada.Table2Calor_especifico_liquido.value)*fs
                          + tela_entrada.Table2Calor_especifico_liquido.value
                          - (tela_entrada.Table2Calor_latente_fusao.value*dfs);

                densidade[i]:=
                         (tela_entrada.Table2Densidade_solido.value -
                          tela_entrada.Table2Densidade_liquido.value)*fs
                          + tela_entrada.Table2Densidade_liquido.value;
              end
              else
               begin
                if (temp_acum[i] < tela_entrada.Table2Lambida.value) then
                    begin
                       temp_acum[i] := temp_acum[i] +
                       (tela_entrada.Table2Temperatura_solidus.value - temp_calc[i]);

                       temp_calc[i] := tela_entrada.Table2Temperatura_solidus.value;

                     condutividade[i]:=tela_entrada.Table2Condutividade_eutetico.value;
                     calor_especifico[i]:=tela_entrada.Table2Calor_especifico_eutetico.value;
                     densidade[i]:=tela_entrada.Table2Densidade_eutetico.value;
                    end
                else
                  begin
                   if not(flag) then
                        begin
                         temp_calc[i]:=temp_calc[i]+(temp_calc[i]-
                         tela_entrada.Table2lambida.value);
                         flag:=true;
                        end;
                   solido:=true;
                  end;
             end;
            {Case(3) - Metal Puro}
             if tela_entrada.Table2Formulacao_fs.value = 'Metal Puro'then
                begin
                  tela_entrada.label26.caption:= '-> Metal Puro';
                     tela_entrada.label26.update;

                   if temp_acum[i] < tela_entrada.Table2Lambida.value then
                    begin
                       temp_acum[i] := temp_acum[i] +
                       (tela_entrada.Table2Temperatura_solidus.value - temp_calc[i]);

                       temp_calc[i] := tela_entrada.Table2Temperatura_solidus.value;

                     condutividade[i]:=tela_entrada.Table2Condutividade_eutetico.value;
                     calor_especifico[i]:=tela_entrada.Table2Calor_especifico_eutetico.value;
                     densidade[i]:=tela_entrada.Table2Densidade_eutetico.value;
                    end
                  else
                     begin
                       if not(flag) then
                          begin
                            temp_calc[i]:=temp_calc[i]+(temp_calc[i]-
                            tela_entrada.Table2lambida.value);
                            flag:=true;
                         end;
                       solido:=true;
                     end;
                end;

               if solido then
                  begin
                    condutividade[i]:=tela_entrada.Table2Condutividade_solido.value;
                    calor_especifico[i]:=tela_entrada.Table2Calor_especifico_solido.value;
                    densidade[i]:=tela_entrada.Table2Densidade_solido.value;
                    solido:=false;
                  end;
          end;

     end;
end;


 {Função para cálculo das resistencias normais}
function res(i,i1:integer;s:char):real;
var
  d, Ka: real;

begin
  if (s = '2') then
   begin
     if (i = trunc(tela_entrada.Table1Numero_divisoes_molde.value)) and
        (i1 > trunc(tela_entrada.Table1Numero_divisoes_molde.value))
        then d:=(tela_entrada.Table1DX_metal.value/2)
     else
         if (i < trunc(tela_entrada.Table1Numero_divisoes_molde.value))
            then d:=(tela_entrada.Table1DX_molde.value/2)
         else
            if (i = trunc(tela_entrada.Table1Numero_divisoes_metal.value)) and
            (i1 < trunc(tela_entrada.Table1Numero_divisoes_metal.value))
            then d:=(tela_entrada.Table1DX_molde.value/2)
            else d:=(tela_entrada.Table1DX_metal.value/2);


        Ka := condutividade[i1];
        res:=(d/(Ka * tela_entrada.Table1Area_total.value));
     end
     else
       begin
        if (i <= trunc(tela_entrada.Table1Numero_divisoes_molde.value))
           then d:=(tela_entrada.Table1DX_molde.value/2)
        else
           d:=(tela_entrada.Table1DX_metal.value/2);
           Ka := condutividade[i];
           res:=(d/(Ka * tela_entrada.Table1Area_total.value));
       end;
end;

{Função para cálculo da resistencia molde ambiente}
function R_hamb(hamb:real):real;
var cdy:real;
begin
   cdy := (1 / (hamb * tela_entrada.Table1Area_total.value));
   R_hamb := cdy;
end;

{Função para cálculo da resistencia metal_molde}
function R_hi(hi:real):real;
var cdx:real;
begin
   cdx := (1 / (hi * tela_entrada.Table1Area_total.value));
   R_hi:=cdx;
end;

{Função para cálculo do capacitor[i]}
function Capac(i:integer): real;
begin
   capac := tela_entrada.Table1Volume.value * calor_especifico[i] * densidade[i];
end;

{Função para o cálculo dos tals=C * (R1 + R2)}
function tal(i,i1:integer):real;
var
   R1, R2, C, sx:real;


 begin
    C := capac(i);
    R1:=res(i, i1, '1');
    if (i = 1) and (i1 = 0) then R2 := R_hamb(hamb)
     else
       begin
         if (i =  trunc(tela_entrada.Table1Numero_divisoes_molde.value)) and
        (i1 > i) then R2:=(R_hi(hi) + res(i, i1, '2'))
         else
            if (i =  trunc(tela_entrada.Table1Numero_divisoes_molde.value)+ 1) and
            (i1 < i) then R2:=(R_hi(hi) + res(i, i1, '2'))
            else
               if (i=trunc(tela_entrada.Table1Numero_divisoes_molde.value +
               tela_entrada.Table1Numero_divisoes_metal.value)) and (i1=i + 1)then
               R2:=R1
               else R2 := res(i, i1, '2');
       end;
    if i = i1 then tal:= (1/((1/tal_vet[-1])+ (1/tal_vet[1])))
    else
      begin
       sx := (C * (R1 + R2));
       tal:=sx;
      end;
 end;


{Função para cálculo do produto dt/tal * T}
function fator(i,i1 : integer):real;
 var
   T,K, aux : real;

 begin
    if i=i1 then
      begin
         tal_vet[0] := tal(i,i1);
         K:=(1 - (tela_entrada.Table1Incremento_tempo_dt.value /tal_vet[0]));
      end
    else
      begin
        tal_vet[(i1-i)] := tal(i,i1);
        K:= (tela_entrada.Table1Incremento_tempo_dt.value /tal_vet[(i1-i)]);
      end;

    if  (i=1) and (i1=0) then
    T := tela_entrada.Table1Temperatura_ambiente.value
    else
      if ( i = trunc(tela_entrada.Table1Numero_divisoes_molde.value +
      tela_entrada.Table1Numero_divisoes_metal.value)) and (i1>i)then
      T := temp_atual[i]
      else
      T := temp_atual[i1];

      fator := K * T;
 end;


{Função para a soma das parcelas envolvidas com as temperaturas nodais}
 function explicito(var i:integer):real;
 var
    soma,f1,f2,f3:real;

 begin
    f1:=0.0;
    f2:=0.0;
    f3:=0.0;
    f1:=fator(i,i-1);  {produto dt/tal * T[i-1]}
    f2:=fator(i,i+1);  {produto dt/tal * T[i+1]}
    f3:=fator(i,i);    {produto dt/tal * T[i]}

    soma:=f1 + f2 + f3;
    explicito:= soma;
 end;


procedure procura_tempo;
var achei: boolean;
    cadeia: string[255];
    aux:real;
    time_col,temp_col1,temp_col2:string[7];
    code, tempo_int : integer;

begin
   achei := false;
   cadeia    := ' ';
   time_col  := ' ';
   temp_col1 := ' ';
   temp_col2 := ' ';

 shape1.brush.color := clred;

  while not eof(entra) and not achei and (tempo > time_exp) do
    begin
       application.processmessages;
       readln(entra, cadeia);

       edit2.text:=cadeia;
       edit2.update;

       time_col := cadeia[1]+cadeia[2]+cadeia[3]+
       cadeia[4]+cadeia[5]+cadeia[6];

       temp_col1 := cadeia[7]+cadeia[8]+cadeia[9]+
       cadeia[10]+cadeia[11]+cadeia[12]+cadeia[13];

       temp_col2 := cadeia[14]+cadeia[15]+cadeia[16]+
       cadeia[17]+cadeia[18]+cadeia[19]+cadeia[20];

       Val(time_col, time_exp, Code);

       tempo_int := round(tempo);

       if tempo_int = round(time_exp) then
         begin
            {while Pos(' ', temp_col1) > 0 do
               temp_col1[Pos(' ', temp_col1)] := '0';}

            val(temp_col1,aux,code);
            temp_exp1 := round(aux);
            achei := true;
            shape1.brush.color := clyellow;

         end;

       {if tempo_int < time_exp then achei:= true;}

       edit3.text := time_col;
       edit3.update;

       edit4.text := temp_col1;
       edit4.update;

       edit5.text := temp_col2;
       edit5.update;

    end;

   shape1.brush.color := clgreen;

end;


procedure grava;
var x:string;
begin
   str(tempo:8:4,x);
   edit1.text:=x;
   edit1.update;
   writeln(fp1,tempo:6:2,' ',temp_calc[p[0]]:6:2,
                         ' ',temp_calc[p[1]]:6:2,
                         ' ',temp_calc[p[2]]:6:2,
                         ' ',temp_calc[p[3]]:6:2,
                         ' ',temp_calc[p[4]]:6:2);
   sum :=sum + ty;
end;

{Rotina para cálculos do MDF - Método de Diferenças Finitas}
procedure mdf;
var
   i:integer;

begin
  for i := 1 to
  (trunc(tela_entrada.Table1Numero_divisoes_molde.value + tela_entrada.Table1Numero_divisoes_metal.value))
   do
      temp_calc[i]:=explicito(i);
end;

{Rotina de determinação de hi}
procedure beck_hi;
begin
  {if (tempo = tela_entrada.Table1Incremento_tempo_dt.value) then}

  if primeira then
    begin
       primeira := false;
       hi := 10000;
       cte_hi := 20;
    end
 else
    begin
       procura_tempo;
       if tempo = (2 * tela_entrada.Table1Incremento_tempo_dt.value) then
         begin
           if temp_calc[i] > temp_exp1 then {para posições específicas}
              begin
                 repeat
                    hi := hi * 1.005;{aumentar de 50 em 50}
                    mdf;
                 until (temp_calc[i]/temp_exp1) < 1.01;
              end
           else
              begin
                 repeat
                    hi := hi * 0.995;{Diminui de 50 e 50}
                    mdf;
                 until (temp_calc[i]/temp_exp1) > 0.99;
              end;
         end
         else
            begin
               if tempo =
              ((cte_hi - 9) * tela_entrada.Table1Incremento_tempo_dt.value) then
                begin
                   if temp_calc[i] > temp_exp1 then {para posições específicas}
                     begin
                        repeat
                           hi := hi * 1.005;{aumentar de 50 em 50}
                           mdf;
                        until (temp_calc[i]/temp_exp1) < 1.01;
                     end
                   else
                     begin
                        repeat
                           hi := hi * 0.995;{Diminui de 50 e 50}
                           mdf;
                        until (temp_calc[i]/temp_exp1) > 0.99;
                     end;
                cte_hi := cte_hi + 10;
                end;
           end;
      end;
end;

{Programa Principal}
begin
   tela_time.refresh;
   sum := 0.0;
   ty := (tela_entrada.Table1Tempo_maximo_processo.value /
     (tela_entrada.Table1Incremento_tempo_dt.value * 800));
   temp_calc[0] := 0;

   with tela_entrada.stringGrid1 do
      for i := 0 to 4 do
          if (cells[0,i] <> '') then val(cells[0,i],p[i],code);

  {Criação dos arquivos de resultados}
  assignfile(fp1,'c:\windows\temp\evoluc.dat');
  assignfile(fp2,'c:\windows\temp\perfis.dat');
  rewrite(fp1);
  rewrite(fp2);

  assignfile(entra,tela_abrir.edit1.text);
  reset(entra);

  for i := 1 to (trunc(tela_entrada.Table1Numero_divisoes_molde.value +
  tela_entrada.Table1Numero_divisoes_metal.value)) do
    begin
        {Referencia de temperatura e propriedades para o molde tempo=0}
         if  i <= trunc(tela_entrada.Table1Numero_divisoes_molde.value) then
           begin
             temp_atual[i]:=tela_entrada.Table1Temperatura_ambiente.value;
             temp_calc[i]:=tela_entrada.Table1Temperatura_ambiente.value;
             condutividade[i]:=tela_entrada.Table3Condutividade_molde.value;
             calor_especifico[i]:=tela_entrada.Table3Calor_especifico_molde.value;
             densidade[i]:=tela_entrada.Table3Densidade_molde.value;
           end
           else
            {Referencia de temperatura e propriedades para o metal tempo=0}
              begin
                temp_atual[i]:=tela_entrada.Table1Temperatura_vazamento.value;
                temp_calc[i]:=tela_entrada.Table1Temperatura_vazamento.value;
              end;
     end;
for i := (trunc(tela_entrada.Table1Numero_divisoes_metal.value)+ 1) to
(trunc(tela_entrada.Table1Numero_divisoes_molde.value + tela_entrada.Table1Numero_divisoes_metal.value))
do
  {Referencia de temperatura e propriedades para o metal puro tempo=0}
  begin
     temp_acum[i]:=0.0;
     flag:=false;
  end;

   tempo := tela_entrada.Table1Incremento_tempo_dt.value;


   propriedades;


   primeira := true;

   repeat

     {hi := tela_entrada.Table1Coef_metal_molde_c.value *
           pow(tempo,tela_entrada.Table1Coef_metal_molde_n.value);}


      hamb := tela_entrada.Table1Coef_molde_ambient_d.value *
           pow(tempo,tela_entrada.Table1Coef_molde_ambient_m.value);


      {Só entra neste procedimento a primeira vez direto e
      depois de intervalo em intervalo - 10 dt (cte_hi)}
      beck_hi;

      mdf;
      propriedades;
      tempo := tempo + tela_entrada.Table1Incremento_tempo_dt.value;

      if (tempo >= (sum * tela_entrada.Table1Incremento_tempo_dt.value))
      then grava;

for i := 1 to (trunc(tela_entrada.Table1Numero_divisoes_molde.value +
tela_entrada.Table1Numero_divisoes_metal.value)) do temp_atual[i]:=temp_calc[i];

   until (tela_entrada.Table1Tempo_maximo_processo.value < tempo);

   {write(fp1,'teste');
   write(fp2,'teste2');}

    closefile(fp1);
    closefile(fp2);
    closefile(entra);


end;

procedure Ttela_time.Button1Click(Sender: TObject);
begin
  tela_time.close;
end;

end.
