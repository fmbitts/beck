{************************************************}

{                                                }

{   Turbo Pascal                                 }

{   Programme IVEC                               }

{   Unit_ CMath                                  }

{   Sources r_cup_r_s dans une librairie         }

{   math_mathique en libre service aux _tats-unis}

{   Copyright (c) 1992 Odent Jean Philippe       }

{                                                }

{************************************************}

Unit  CMath;

{ The setting of the N compiler directive within this include file will }
{ determine whether your toolbox programs will use the standard Turbo   }
{ Pascal 6 byte real number or the Turbo Pascal double precision real   }
{ number. In order to use the double precision real number type, you    }
{ must have an 8087 math coprocessor installed in your computer.        }


{$N-} { Change to $N+ if you want to use the 8 byte double precision real }
      { Change to $N- if you want to use the 6 byte non-8087 real number  }

interface

uses Wintypes, WinProcs;   { TPoint et MessageBeep }

const

  PiRad  = 180;
  PI     =  3.14159265358979323846;       {  pi          }
  PI2    = PI*2;


{$IFOPT N+}

type

  Float = Double; { 8 byte real, requires 8087 math chip }



const

  Epsilon2          = 1e-6;
  Tolerance         = 1E-4;
  Epsilon           = 1E-015;
  Mant              = 25;
  Deci              = 25;


{$ELSE}

type

  Float   = Real;   { 6 byte real, no math chip required }


const

  Tolerance         = 1E-6;
  Epsilon2          = 1e-9;
  Epsilon           = 1E-07;
  Mant              = 15;
  Deci              = 14;

{$ENDIF}


const

  DimenMat            = 3;              { Calcul sur des matrices 3*3 }
  TNArraySize         = 4;                { Size of the matrix }
  LimitTabVal         = 4100;
  LimitCalculTabVal   = 4003;
  MaxLongInt          = 655350000;
  PartPi              = 90;             { Pas de rotation }
  Plus                = 1;
  Moins               = -1;
  Modul3              = 1.73205080757; { racine de 3 }
  DeciSurface         = 3;
  CoefSurface         = 5*5*0.000001;
  PasScrollHorizontal =  8;
  PasScrollVertical   = 16;  { 15 laisse une moirure }
  FlechePleine        = 1;
  FlecheVide          = 2;
  RAnatomique         = 0;
  RAxesPropres        = 1;
  RObservateur        = 2;

type

  TNvector = array[1..TNArraySize] of Float;
  TNmatrix = array[1..TNArraySize] of TNvector;
  TParamV  = array[1..6] of real;

  P_TabVal      = ^_TabVal;
  _TabVal       = array[0..LimitTabVal] of Integer;

  P_TabFloat = ^_TabFloat;
  _TabFloat = array[0..LimitTabVal] of Float;

  P_TabPoints = ^_TabPoints;
  _TabPoints  = array[0..LimitTabVal] of TPoint;

  P_TabPVal = ^_TabPVal;
  _TabPVal  = array[1..3] of P_TabVal;


  TRectReel = record

                Left, Top, Bottom, Right : Float;

              end;



  RepereVector = record

                   V      : TNVector;

                   Indice : Integer;

                   Nom    : pChar;

                 end;



  TEchelle = record

    X, Y, Z : Real;

  end;



function MathError:Integer;

Function HexaSt(W:LongInt;n:byte):String;

Function StHexa(St:String):LongInt;

function ASin(x:Float):Float;

function ACos(x:Float):Float;

function Rad(x:Float):Float;

function Deg(x:Float):Float;

function Sgn(x:Float):Integer;

function Sign(var N:Real):Integer;

function DivNonZ(a,b : Float):Float;

function Limite(N:Real):Real;

function MaxI(A,B : LongInt):LongInt;

function MinI(A,B : LongInt):LongInt;

function MaxR(A,B : Float):Float;

function MinR(A,B : Float):Float;

function Atan2( y, x: Float):Float;

function fabs(x: Float):Float;

function floor(x:Float):Float;

function powi(x : Float; nn:Integer):Float;

function pow(x, y : Float):Float;

function RoundR(x:Float):Float;

function Sin(x:Float):Float;

function Cos(x:Float):Float;

function Exp(x:Float):Float;

function Log(x:Float):Float;

function Log10(x:Float):Float;

function Exp10(x:Float):Float;

function Cosh(x:Float):Float;

function ACosh(x:Float):Float;

function Sinh(x:Float):Float;

function ASinh(x:Float):Float;

function Cot(x:Float):Float;

function Tan(x:Float):Float;

function Atan(x:Float):Float;

function Tanh(x:Float):Float;

function ATanh(x:Float):Float;

function sqrt(x:Float):Float;

function cbrt(x:Float):Float;



function NonZ(x:Float):Float;

function Encadre(a, b, c: LongInt):LongInt;

function Sqr3(a,b,c:Float):Float;

function Module(var V:TNVector):Float;

function Longitude(var V:TNVector):Float;

function Latitude(var V:TNVector):Float;

function Site(var V:TNVector):Float;

function Elevation(var V:TNVector):Float;

function Azimut(var V:TNVector):Float;

procedure MesureVecteur(var Vecteur:TNVector; var Param:TParamV);

procedure CoordonneeMatrice(var Mat:TNMatrix; var V:TNVector; IsRepereObj:Boolean);

procedure OptimiseRotation(var Vn:TNVector);

function VerifAngle(var V:TNVector; var Mat:TNMatrix):Boolean;

procedure Ajuste(var V:TNVector; var Mat:TNMatrix);

procedure Initial(Dimen : Integer; var Data: TNmatrix);

procedure DivMatFloat(Dimen : integer; var Data  : TNmatrix; Divisor : Float);

procedure ClearVect(var Data  : TNVector);

procedure AddVecteur(Dimen:Integer; var A, B, C : TNVector);

procedure SubVecteur(Dimen:Integer; var A, B, C : TNVector);

procedure ClearMat(var Data  : TNmatrix);

procedure MultMat(Dimen : Integer; MatA, MatB:TNMatrix; var MatC:TNMatrix);

procedure MultMatVect(Dimen : Integer; var Mat:TNMatrix; var V:TNVector);

procedure TransposeMat(Dimen : Integer; var Data:TNMatrix);

procedure InverseMatRot(DimenMat: Integer; var MatI:TNMatrix);

procedure AffecteMat(p:Integer; Phi:Float; var Mat:TNMatrix);

procedure InitialiseXmat;

procedure RotationMatrice(var PhiRot:TNvector; var MatRot:TNMatrix; Repere:Byte);

procedure IncrementeMatrice(NoAxe, Sens : Integer; var MatRot, MatVP:TNMatrix; Rotation:Boolean);

procedure CSpline(var AA : _TabVal; N : integer; X1, Xm, Echelle : Float; var BB : _TabPoints; M, Offsx, Offsy : integer);

procedure Bezier(var A : _TabVal; MaxContrPoints : integer; var B : _TabPoints; MaxIntPoints : integer);

procedure CalculVecteurPropre(var EigenVectors : TNMatrix; var PVecteur : _TabPVal; Taille : Word);

procedure Jacobi(Dimen        : integer;

                 Mat          : TNmatrix;

                 MaxIter      : integer;

                 Tolerance    : Float;

             var Eigenvalues  : TNvector;

             var Eigenvectors : TNmatrix;

             var Iter         : integer;

             var Error        : byte);

function SurfaceOmbre(var Mat:TNMatrix; var Points:_TabPVal; Modulo, OffsetS, Count:Integer):float;

{ Les proc_dures de validation des r_sultats }





type StErr20 = String[20];

var  MathStrErreur  : StErr20;

     XMat           : array[1..6] of TNMatrix;

     RotationPropre : Boolean;

     RepereActuel    : Byte;





implementation



uses Verif;



procedure Jacobi;                        external 'IVECdll' index 3;

procedure CalculVecteurPropre;           external 'IVECdll' index 4;



const  CarHexa    : set of char =['0'..'9','a'..'f','A'..'F'];

       BaseHexa   = 16;

       AlphabHexa : array[0..15] of char = '0123456789ABCDEF';



const



      PIO2   =  1.57079632679489661923;       {  pi/2        }

      PIO4   =  7.85398163397448309616E-1;    {  pi/4        }

      SQRT2  =  1.41421356237309504880;       {  sqrt(2)     }

      SQRTH  =  7.07106781186547524401E-1;    {  sqrt(2)/2   }

      LOG2E  =  1.4426950408889634073599;     {  1/log(2)    }

      SQ2OPI =  7.9788456080286535587989E-1;  {  sqrt( 2/pi )}

      LOGE2  =  6.93147180559945309417E-1;    {  log(2)      }

      LOGSQ2 =  3.46573590279972654709E-1;    {  log(2)/2    }

      THPIO4 =  2.35619449019234492885;       {  3*pi/4      }

      TWOOPI =  6.36619772367581343075535E-1; {  2/pi        }

      lossth =  1.073741824e9;



{  This routine may be called to report one of the following

   error conditions (in the include file mconf.h).



      Mnemonic        Value          Significance

}

       DOMAIN       =    1;  {   argument domain error      }

       SING         =    2;  {   function singularity       }

       OVERFLOW     =    3;  {   overflow range error       }

       UNDERFLOW    =    4;  {   underflow range error      }

       TLOSS        =    5;  {   total loss of precision    }

       PLOSS        =    6;  {   partial loss of precision  }

       EDOM         =   33;  {   Unix domain error code     }

       ERANGE       =   34;  {   Unix range error code      }



       MACHEP =  1.38777878078144567553E-17;    { 2**-56       }

       MAXLOG =  8.8029691931113054295988E1;    { log(2**127)  }

       MINLOG = -8.872283911167299960540E1;     { log(2**-128) }

       MAXNUM =  1.7e38;

{       MAXNUM =  1.701411834604692317316873e38; { 2**127       }





type TabCoef = array[0..6] of Float;





var MathErreur    : Integer;





function MathError:Integer;

begin

  MathError := MathErreur;

  MathErreur   := 0;

end;





procedure mtherr(St: StErr20; Error:Integer);

begin

  if MathErreur = 0 then

  begin

   MathErreur    := Error;

   case Error of

     DOMAIN       : MathStrErreur := 'argument domain error';

     SING         : MathStrErreur := 'function singularity';

     OVERFLOW     : MathStrErreur := 'overflow range error';

     UNDERFLOW    : MathStrErreur := 'underflow range error';

     TLOSS        : MathStrErreur := 'total loss of precision';

     PLOSS        : MathStrErreur := 'partial loss of precision';

     EDOM         : MathStrErreur := 'Unix domain error code';

     ERANGE       : MathStrErreur := 'Unix range error code';

   end;

   MathStrErreur  := ST + MathStrErreur;

  end;

end;





Function HexaSt(W:LongInt;n:byte):String;

var St    : String;

    Tc    : Byte;

begin

  St := ''; Tc:=N;

  Repeat

    St    := AlphabHexa[W mod BaseHexa] + St;

    W     := W div BaseHexa;

    Dec(Tc);

  until Tc=0;

  St:='0000'+St;

  HexaSt := Copy(St, length(St)-n+1, n);

end;



Function StHexa(St:String):LongInt;

var Tot   : LongInt;

    i     : byte;

begin

  Tot := 0;

  for i:=1 to length(St) do Tot := Tot*BaseHexa  + Pos(St[i],AlphabHexa)-1;

  StHexa := Tot;

end;





function MinI(A,B : LongInt):LongInt;

begin

  if A>B then

    MinI:=B

  else

    MinI:=A;

end;



function MaxI(A,B : LongInt):LongInt;

begin

  if A>B then

    MaxI:=A

  else

    MaxI:=B;

end;





function MaxR(A,B : Float):Float;

begin

  if A>B then

    MaxR:=A

  else

    MaxR:=B;

end;



function MinR(A,B : Float):Float;

begin

  if A>B then

    MinR:=B

  else

    MinR:=A;

end;







function fabs(x:Float):Float;

begin

  if( x < 0.0 ) then

    fabs := -x

  else

   fabs := x ;

end;





function floor(x:Float):Float;

begin

  Floor:=Trunc(x);

end;





function ldexp( x: Float; N: Integer):Float;

{ ldexp() multiplies x by 2**n. }

var r : Float;

begin

  R := 1;

  if N>0 then

    while N>0 do begin

      R:=R*2;

      Dec(N);

    end

  else

    while N<0 do begin

      R:=R/2;

      Inc(N);

    end;

  ldexp := x * R;

end;





function frexp(x:Float; var e:Integer ):Float;

{  frexp() extracts the exponent from x.  It returns an integer

   power of two to expnt and the significand between 0.5 and 1

   to y.  Thus  x = y * 2**expn.  }

begin

  e :=0;

  if (fabs(x)<0.5) then

  While (fabs(x)<0.5) do

  begin

    x := x*2;

    Dec(e);

  end

  else

  While (fabs(x)>1) do

  begin

    x := x/2;

    Inc(e);

  end;

  frexp := x;

end;





function polevl(var x:Float; var Coef:TabCoef; N:Integer):Float;

{

        Evaluate polynomial







    SYNOPSIS:



    int N;

    double x, y, coef[N+1], polevl[];



    y = polevl( x, coef, N );







    DESCRIPTION:



    Evaluates polynomial of degree N:



                        2          N

    y  =  C  + C x + C x  +...+ C x

           0    1     2          N



    Coefficients are stored in reverse order:



    coef[0] = C  , ..., coef[N] = C  .

               N                   0



     The function p1evl() assumes that coef[N] = 1.0 and is

    omitted from the array.  Its calling arguments are

    otherwise the same as polevl().





    SPEED:



    In the interest of speed, there are no checks for out

    of bounds arithmetic.  This routine is used by most of

    the functions in the library.  Depending on available

    equipment features, the user may wish to rewrite the

    program in microcode or assembly language.

}

var ans : Float;

    i   : Integer;



begin

  ans := Coef[0];

  for i:=1 to N do

    ans := ans * x + Coef[i];

  polevl:=ans;

end;





function p1evl(var x:Float; var Coef:TabCoef; N:Integer):Float;

{

    Evaluate polynomial when coefficient of x  is 1.0.

    Otherwise same as polevl.

}

var ans : Float;

    i   : Integer;

begin

  ans := x + Coef[0];

  for i:=1 to N-1 do

    ans := ans * x + Coef[i];

  p1evl := ans;

end;





function powi(x : Float; nn:Integer):Float;

{

    Real raised to integer power







    SYNOPSIS:



    double x, y, powi();

    int n;



    y = powi( x, n );







    DESCRIPTION:



    Returns argument x raised to the nth power.

    The routine efficiently decomposes n as a sum of powers of

    two. The desired power is a product of two-to-the-kth

    powers of x.  Thus to compute the 32767 power of x requires

    28 multiplications instead of 32767 multiplications.

}

var  n, e, sign, asign, lx : Integer;

     p : byte;

     w, s, y : Real;



Label done;



begin

  if( x = 0.0 ) then

    if( nn = 0 ) then

     begin

      powi := 1.0 ;

      exit;

     end

    else

     if( nn < 0 ) then

      begin

        powi := MAXNUM ;

        exit;

      end

     else

      begin

       powi := 0.0 ;

       exit;

      end;



  if( nn = 0 ) then

     begin

      powi := 1.0 ;

      exit;

     end;



  if( x < 0.0 ) then

   begin

     asign := -1;

     x := -x;

   end

  else

   asign := 0;



  if( nn < 0 ) then

   begin

    sign := -1;

    n := -nn;

   end

  else

   begin

    sign := 1;

    n := nn;

   end;



{ Overflow detection }



{ Calculate approximate logarithm of answer }

  s := frexp( x, lx );

  e := (lx - 1)*n;

  if( (e = 0) or (e > 64) or (e < -64) ) then

   begin

    s := (s - 7.0710678118654752e-1) / (s +  7.0710678118654752e-1);

    s := (2.9142135623730950 * s - 0.5 + lx) * nn * LOGE2;

   end

  else

    s := LOGE2 * e;



  if( s > MAXLOG ) then

   begin

    mtherr( 'powi', OVERFLOW );

    y := MAXNUM;

    goto done;

   end;



   if( s < MINLOG ) then

    begin

      powi := 0.0;

      exit;

    end;



{ Handle tiny denormal answer, but with less accuracy

 since roundoff error in 1.0/x will be amplified.

 The precise demarcation should be the gradual underflow threshold. }



  if( (s < (-MAXLOG+2.0)) and (sign < 0) ) then

   begin

     x := 1.0/x;

     sign := -sign;

   end;



{ First bit of the power  }

  if odd( n ) then

        y := x

  else

   begin

     y := 1.0;

     asign := 0;

   end;



  w := x;

  n := n shr 1;

  while( n<>0 ) do

   begin

     w := w * w;         { arg to the 2-to-the-kth power }

     if odd( n ) then { if that bit is set, then include in product }

       y := y*w;

     n := n shr 1;

   end;



  done:



  if( asign<>0 ) then

     y := -y; { odd power of negative number }

  if( sign < 0 ) then

     y := 1.0/y;

  powi := y;

end;





function reduc(x: Float):Float;

{ Find a multiple of 1/16 that is within 1/16 of x. }

var t:Float;

begin

  t := ldexp( x, 4 );

  t := floor( t );

  t := ldexp( t, -4 );

  reduc := t;

end;





function pow(x, y : Float):Float;

{

    Power function







    SYNOPSIS:



    double x, y, z, pow();



    z = pow( x, y );







    DESCRIPTION:



    Computes x raised to the yth power.  Analytically,



         x**y  =  exp( y log(x) ).



    Following Cody and Waite, this program uses a lookup table

    of 2**-i/16 and pseudo extended precision arithmetic to

    obtain an extra three bits of accuracy in both the logarithm

    and the exponential.

}

type Tab17Coef = array[0..16] of Float;



const P : TabCoef = (

          4.97778295871696322025E-1,

          3.73336776063286838734E0,

          7.69994162726912503298E0,

          4.66651806774358464979E0, 0, 0, 0);

      Q : TabCoef = (

          9.33340916416696166113E0,

          2.79999886606328401649E1,

          3.35994905342304405431E1,

          1.39995542032307539578E1, 0, 0, 0);



      A : Tab17Coef = (

          1.00000000000000000000E0,

          9.57603280698573700036E-1,

          9.17004043204671215328E-1,

          8.78126080186649726755E-1,

          8.40896415253714502036E-1,

          8.05245165974627141736E-1,

          7.71105412703970372057E-1,

          7.38413072969749673113E-1,

          7.07106781186547572737E-1,

          6.77127773468446325644E-1,

          6.48419777325504820276E-1,

          6.20928906036742001007E-1,

          5.94603557501360513449E-1,

          5.69394317378345782288E-1,

          5.45253866332628844837E-1,

          5.22136891213706877402E-1,

          5.00000000000000000000E-1);

      B : Tab17Coef = (

           0.00000000000000000000E0,

           1.64155361212281360176E-17,

           4.09950501029074826006E-17,

           3.97491740484881042808E-17,

          -4.83364665672645672553E-17,

           1.26912513974441574796E-17,

           1.99100761573282305549E-17,

          -1.52339103990623557348E-17,

           0.00000000000000000000E0, 0, 0, 0, 0, 0, 0, 0, 0);

      R : TabCoef = (

          1.49664108433729301083E-5,

          1.54010762792771901396E-4,

          1.33335476964097721140E-3,

          9.61812908476554225149E-3,

          5.55041086645832347466E-2,

          2.40226506959099779976E-1,

          6.93147180559945308821E-1);



{ log2(e) - 1 }



       LOG2EA = 0.44269504088896340736;

       MEXP = 16383.0;

       MNEXP = -16383.0;

{

-#define MEXP 16383.0

-#if DENORMAL

-#define MNEXP -17183.0

-#else

-#define MNEXP -16383.0

-#endif

-#endif

}

var w, z, Wa, Wb, ya, yb, u : Float;

    F, Fa, Fb, G, Ga, Gb, H, Ha, Hb  : Float;

    e, i : Integer;

    nflg : Boolean;

begin

  nflg := False;        { flag = 1 if x<0 raised to integer power }

  w := floor(y);

  if( (w = y) and (fabs(w) < 32768.0) ) then

   begin

    i := Trunc(w);

    w := powi( x, i );

    pow := w ;

    Exit;

   end;

   if( x <= 0.0 ) then

     if( x = 0.0 ) then

       if( y = 0.0 ) then

        begin

         pow := 1.0;   {   0**0   }

         Exit;

        end

       else

        begin

         pow := 0.0;   {  0**y   }

         Exit;

        end

     else  { x<0.0 }

      begin

       if( w <> y ) then

        begin

          {  noninteger power of negative number }

          mtherr( 'pow', DOMAIN );

          pow := 0.0;

          Exit;

        end;

       nflg := True;

       x := fabs(x);

      end;



{ separate significand from exponent }

  x := frexp( x, e );



{ find significand in antilog table A[] }

  i := 1;

  if( x <= A[9] ) then

        i := 9;

  if( x <= A[i+4] ) then

        inc(i, 4);

  if( x <= A[i+2] ) then

        inc(i, 2);

  if( x >= A[1] ) then

        i := -1;

  inc(i);



{ Find (x - A[i])/A[i]

 in order to compute log(x/A[i]):



 log(x) = log( a x/a ) = log(a) + log(x/a)



 log(x/a) = log(1+v),  v = x/a - 1 = (x-a)/a  }

  x := x - A[i];

  x := x - B[i div 2];

  x := x / A[i];



{ rational approximation for log(1+v):



  log(1+v)  =  v  -  v**2/2  +  v**3 P(v) / Q(v) }

  z := x*x;

  w := x * ( z * polevl( x, P, 3 ) / p1evl( x, Q, 4 ) );

  w := w - ldexp( z, -1 );   {  w - 0.5 * z  }



{ Convert to base 2 logarithm:

  multiply by log2(e)  }



  w := w + LOG2EA * w;

{ Note x was not yet added in

  to above rational approximation,

  so do it now, while multiplying

  by log2(e).  }



  z := w + LOG2EA * x;

  z := z + x;



{ Compute exponent term of the base 2 logarithm. }

  w := -i;

  w := ldexp( w, -4 );  { divide by 16 }

  w := w + e;

{ Now base 2 log of x is w + z. }



{ Multiply base 2 log by y, in extended precision.



  separate y into large part ya

  and small part yb less than 1/16 }



  ya := reduc(y);

  yb := y - ya;



  F := z * y  +  w * yb;

  Fa := reduc(F);

  Fb := F - Fa;



  G := Fa + w * ya;

  Ga := reduc(G);

  Gb := G - Ga;



  H := Fb + Gb;

  Ha := reduc(H);

  w := ldexp( Ga+Ha, 4 );



{ Test the power of 2 for overflow }

  if( w > MEXP ) then

   begin

     mtherr( 'pow', OVERFLOW );

     Pow := MAXNUM ;

     Exit;

   end;



  if( w < MNEXP ) then

   begin

     mtherr( 'pow', UNDERFLOW );

     pow := 0.0;

     Exit;

   end;



  e := trunc(w);

  Hb := H - Ha;



  if( Hb > 0.0 ) then

   begin

     inc(e);

     Hb := Hb - 0.0625;

   end;



{ Now the product y * log2(x)  =  Hb + e/16.0.



  Compute base 2 exponential of Hb,

  where -0.0625 <= Hb <= 0.  }



  z := Hb * polevl( Hb, R, 6 );  {   z  =  2**Hb - 1    }



{  Express e/16 as an integer plus a negative number of 16ths.

   Find lookup table entry for the fractional power of 2.    }



  if( e < 0 ) then

        i := 0

  else

        i := 1;

  inc(i, e div 16);

  e := 16*i - e;

  w := A[e];

  z := w + w * z;      {  2**-e * ( 1 + (2**Hb-1) )   }

  z := ldexp( z, i );  {  multiply by integer power of 2 }



  if( nflg ) then

   begin

{  For negative x,

   find out if the integer exponent

   is odd or even.  }



        w := ldexp( y, -1 );

        w := floor(w);

        w := ldexp( w, 1 );

        if( w <> y ) then

                z := -z; { odd exponent }

   end;

  pow :=  z ;

end;





function RoundR(x:Float):Float;

{

    Round double to nearest or even integer valued double







    SYNOPSIS:



    double x, y, round();



    y = round(x);







    DESCRIPTION:



    Returns the nearest integer to x as a double precision

    floating point result.  If x ends in 0.5 exactly, the

    nearest even integer is chosen.







    ACCURACY:



    If x is greater than 1/(2*MACHEP), its closest machine

    representation is already an integer, so rounding does

    not change it.

}



var y, r : Float;



label rndup ;



begin

{ Largest integer <= x }

  y := floor(x);



{ Fractional part }

  r := x - y;



{ Round up to nearest. }

  if( r > 0.5 ) then

        goto rndup;



{ Round to even }

  if( r = 0.5 ) then

   begin

     r := y - 2.0 * floor( 0.5 * y );

      if( r = 1.0 ) then

   rndup:

        y := y + 1.0;

   end;



{  Else round down. }

  roundR := y;

end;





function Rad(x:Float):Float;

begin

  Rad:= (x*Pi)/PiRad;

end;





function Sgn(x:Float):Integer;

begin

  if x<0 then Sgn:=-1 else Sgn:=1;

end;



function Deg(x:Float):Float;

begin

  x := (x*PiRad)/Pi;

  While fabs(x)>PiRad do

    x := x - Sgn(x)*PiRad;

  Deg := x;

end;



function DivNonZ(a,b : Float):Float;

var Test : Byte;

begin

  Test := 0;

  if abs(a)<Epsilon then Test := 1;

  if abs(b)<Epsilon then Inc(Test,2);

  Case Test of

    0,1 : DivNonZ:=a/b;

    2 : DivNonZ := 1e35 * Sgn(a)*Sgn(b);

    3 : DivNonZ:=1;  { 0/0 }

  end;

{

  if abs(a)<Epsilon then a:=Epsilon*Sgn(a);

  if abs(b)<Epsilon then b:=Epsilon*Sgn(b);

  DivNonZ:=a/b;

  }

end;



function Limite(N:Real):Real;

begin

  if abs(N)>1 then

    Limite := Sgn(N)

  else

    Limite := N;

end;



function Sign(var N:Real):Integer;

begin

  if Abs(N)<Epsilon then

    Sign:=0

  else

    if N>0 then

      Sign:=1

    else

      Sign:=-1;

end;





{ PremiŠre m‚thode de calcul des arcsinus }

function ASin1(x:Float):Float;

begin

{  ASin:=Pi/2-ACos(x); }

  if fabs(x)>=1 then x:=Sin(Pi/2)*Sgn(x);

  Asin1 := ArcTan(x/sqrt(1-x*x));

end;





function ACos1(x:Float):Float;

begin

  ACos1:=PIO2-ASin1(x);

end;



function ASin3(x:Float):Float; forward;





function ACos3(x:Float):Float;

begin

  if fabs(x)<0.5 then

    ACos3:=PIO2 - ASin3(x)

  else

    ACos3:=ArcTan(sqrt(1-x*x)/x);

end;



function ASin3(x:Float):Float;

begin

  if fabs(x)>0.5 then

    ASin3 := PIO2 - ACos3(x)

  else

    ASin3:=ArcTan(x/sqrt(1-x*x));

end;





function ASin4(x:Float):Float;

{ M‚thode de la suite de taylor }

var A, C, K, R, R2 : Float;

    Count : LongInt;

begin

  Count:=0;

  A:=1; C:=x; K:=1; R := x;

  Repeat

    K := K *(A/(A+1));

    C := C*x*x; A:=A+2;

    R2 := R;

    R := R + (K*C)/A;

    Inc(Count);

  Until (Count=80000) or (fabs(R-R2)<Epsilon);

  ASin4:=R;

end;





const sincof : TabCoef = (

                1.58962301576546568060E-10,

               -2.50507477628578072866E-8,

                2.75573136213857245213E-6,

               -1.98412698295895385996E-4,

                8.33333333332211858878E-3,

               -1.66666666666666307295E-1, 0);

      coscof : TabCoef = (

               -1.13585365213876817300E-11,

                2.08757008419747316778E-9,

               -2.75573141792967388112E-7,

                2.48015872888517045348E-5,

               -1.38888888888730564116E-3,

                4.16666666666665929218E-2, 0);



      DP1 =   7.85398125648498535156E-1;

      DP2 =   3.77489470793079817668E-8;

      DP3 =   2.69515142907905952645E-15;







function Sin(x:Float):Float;

{

    Circular sine







    SYNOPSIS:



    double x, y, sin();



    y = sin( x );







    DESCRIPTION:



    Range reduction is into intervals of pi/4.  The reduction

    error is nearly eliminated by contriving an extended precision

    modular arithmetic.



    Two polynomial approximating functions are employed.

    Between 0 and pi/4 the sine is approximated by

         x  +  x**3 P(x**2).

    Between pi/4 and pi/2 the cosine is represented as

         1  -  x**2 Q(x**2).

}



var  y, z, zz : Float;

     j, sign : Integer;



begin

{ make argument positive but save the sign }

  sign := 1;

  if( x < 0 ) then

   begin

     x := -x;

     sign := -1;

   end;



  if( x > lossth ) then

   begin

    mtherr( 'sin', TLOSS );

    sin := 0.0;

    exit;

   end;



  y := floor( x/PIO4 ); { integer part of x/PIO4 }



{ strip high bits of integer part to prevent integer overflow }

  z := ldexp( y, -4 );

  z := floor(z);           { integer part of y/8 }

  z := y - ldexp( z, 4 );  { y - 16 * (y/16) }



  j := Trunc(z); { convert to integer for tests on the phase angle }

  { map zeros to origin }

  if odd( j ) then

   begin

    inc(j);

    y := y + 1.0;

   end;

  j := j and 7; { octant modulo 360 degrees }

{ reflect in x axis }

  if( j > 3) then

   begin

     sign := -sign;

     dec(j, 4);

   end;



{ Extended precision modular arithmetic }

  z := ((x - y * DP1) - y * DP2) - y * DP3;



  zz := z * z;



  if( (j=1) or (j=2) ) then

    y := 1.0 - ldexp(zz,-1) + zz * zz * polevl( zz, coscof, 5 )

  else

{       y = z  +  z * (zz * polevl( zz, sincof, 5 )); }

    y := z  +  z * z * z * polevl( zz, sincof, 5 );



  if(sign < 0) then

        y := -y;



  sin := y;

end;





function Cos(x:Float):Float;

{

    Circular cosine







    SYNOPSIS:



    double x, y, cos();



    y = cos( x );







    DESCRIPTION:




    Range reduction is into intervals of pi/4.  The reduction

    error is nearly eliminated by contriving an extended precision

    modular arithmetic.



    Two polynomial approximating functions are employed.

    Between 0 and pi/4 the cosine is approximated by

         1  -  x**2 Q(x**2).

    Between pi/4 and pi/2 the sine is represented as

         x  +  x**3 P(x**2).

}

var  y, z, zz : Float;

     j, sign : Integer;

     i : LongInt;



begin

{ make argument positive }

  sign := 1;

  if( x < 0 ) then

        x := -x;



  if( x > lossth ) then

   begin

    mtherr( 'cos', TLOSS );

    cos := 0.0;

    exit;

   end;



  y := floor( x/PIO4 );

  z := ldexp( y, -4 );

  z := floor(z);                { integer part of y/8 }

  z := y - ldexp( z, 4 );  { y - 16 * (y/16) }



{ integer and fractional part modulo one octant }

  i := Trunc(z);

  if odd( i ) then      { map zeros to origin }

   begin

    inc(i);

    y := y + 1.0;

   end;

  j := i and 07;

  if( j > 3) then

   begin

    dec(j,4);

    sign := -sign;

   end;



  if( j > 1 ) then

    sign := -sign;



{ Extended precision modular arithmetic  }

  z := ((x - y * DP1) - y * DP2) - y * DP3;



  zz := z * z;



  if( (j=1) or (j=2) ) then

{       y = z  +  z * (zz * polevl( zz, sincof, 5 )); }

    y := z  +  z * z * z * polevl( zz, sincof, 5 )

  else

    y := 1.0 - ldexp(zz,-1) + zz * zz * polevl( zz, coscof, 5 );



  if(sign < 0) then

        y := -y;



  cos := y ;

end;





function ASin(x:Float):Float;

const P : TabCoef = (

          -6.96822599948686174217E-1,

           1.01598286089872099722E1,

          -3.97340771391578757294E1,

           5.72912144709846496134E1,

          -2.74148200465925708020E1, 0,0);

      Q :  TabCoef = (

           -2.38368245005177488242E1,

            1.51095072703128995631E2,

           -3.82340216045978957023E2,

            4.17767300951716199422E2,

           -1.64488920279555473283E2,0,0);



 var Sign      : Integer;

     a,z,zz,pp : Float;

     Flag      : byte;



begin

  if x>0 then begin Sign:=1; a:=x; end

  else begin Sign:=-1; a:=-x; end;



  if (a>1.0) then

  begin

    mtherr( 'ASin', OVERFLOW );

    ASin :=0.0;

  end

  else

   begin

   if (a<Epsilon) then

     z:=a

   else

    begin



     if (a>0.5) then

     begin

       zz:=(0.5-a+0.5)/2.0; z:=sqrt(zz); flag:=1;

     end

     else

     begin

       z:=a; zz:=z*z; flag:=0;

     end;



     z := z * zz * polevl( zz, P, 4)/p1evl( zz, Q, 5) + z;



     if( flag<>0 ) then begin z := z + z; z := PIO2 - z; end;

    end;



   if (sign < 0 ) then  z := -z;

   ASin:=z;

  end;

end;





function ACos(x:Float):Float;

{

        Inverse circular cosine







    SYNOPSIS:



    double x, y, acos();



    y = acos( x );







    DESCRIPTION:



    Returns radian angle between -pi/2 and +pi/2 whose cosine

    is x.



    Analytically, acos(x) = pi/2 - asin(x).  However if |x| is

    near 1, there is cancellation error in subtracting asin(x)

    from pi/2.  Hence if x < -0.5,



       acos(x) =         pi - 2.0 * asin( sqrt((1+x)/2) );



    or if x > +0.5,



       acos(x) =         2.0 * asin(  sqrt((1-x)/2) ).



}

label domerr;

begin

  if fabs(x)>1 then

  begin

    mtherr( 'Acos', OVERFLOW );

    ACos := x;

  end

  else 

  if (x<-0.5) then

    ACos := pi - 2.0 * Asin( sqrt((1+x)*0.5) )

  else if (x > 0.5) then

    ACos := 2.0 * Asin(  sqrt((1-x)*0.5) )

  else

    ACos := PIO2 - Asin(x)

end;





function Exp(x:Float):Float;

{

    Exponential function







    SYNOPSIS:



    double x, y, exp();



    y = exp( x );







    DESCRIPTION:



    Returns e (2.71828...) raised to the x power.



    Range reduction is accomplished by separating the argument

    into an integer k and fraction f such that



        x    k  f

       e  = 2  e.



    A Pade' form of degree 2/3 is used to approximate exp(f) - 1

    in the basic range [-0.5 ln 2, 0.5 ln 2].

}

const  P : TabCoef = (

           1.26183092834458542160E-4,

           3.02996887658430129200E-2,

           1.00000000000000000000E0, 0, 0, 0, 0);

       Q : TabCoef = (

           3.00227947279887615146E-6,

           2.52453653553222894311E-3,

           2.27266044198352679519E-1,

           2.00000000000000000005E0, 0 ,0 ,0);



         C1 = 6.9335937500000000000E-1;

         C2 = 2.1219444005469058277E-4;

var n : Integer;

    px, qx, xx : Float;

begin

  if( x > MAXLOG) then

   begin

        mtherr( 'Exp', OVERFLOW );

        Exp := MAXNUM ;

   end

  else

   if( x < MINLOG ) then

    begin

        mtherr('Exp', UNDERFLOW );

        Exp := 0.0;

    end

   else

    begin



{ Express e**x = e**g 2**n }

{   = e**g e**( n loge(2) ) }

{   = e**( g + n loge(2) )  }



     px := x * LOG2E;

     qx := floor( px + 0.5 ); { floor() truncates toward -infinity. }

     n  := Trunc(qx);

     x  := x - qx * C1;

     x  := x + qx * C2;



{ rational approximation for exponential  }

{ of the fractional part: }

{ e**x - 1  =  2x P(x**2)/( Q(x**2) - P(x**2) )  }

     xx := x * x;

     px := x * polevl( xx, P, 2 );

     x  :=  px/( polevl( xx, Q, 3 ) - px );

     x  := ldexp( x, 1 );

     x  :=  x + 1.0;

     x  := ldexp( x, n );

    Exp := x;

  end;

end;





function Log(x:Float):Float;

{

        Natural logarithm





    SYNOPSIS:



    double x, y, log();



    y = log( x );







    DESCRIPTION:



    Returns the base e (2.718...) logarithm of x.



    The argument is separated into its exponent and fractional

    parts.  If the exponent is between -1 and +1, the logarithm

    of the fraction is approximated by



        log(1+x) = x - 0.5 x**2 + x**3 P(x)/Q(x).



    Otherwise, setting  z = 2(x-1)/x+1),



        log(x) = z + z**3 P(z)/Q(z).

}

const  P : TabCoef = (

{  Coefficients for log(1+x) = x - x**2/2 + x**3 P(x)/Q(x)

   1/sqrt(2) <= x < sqrt(2) }



           4.58482948458143443514E-5,

           4.98531067254050724270E-1,

           6.56312093769992875930E0,

           2.97877425097986925891E1,

           6.06127134467767258030E1,

           5.67349287391754285487E1,

           1.98892446572874072159E1);

       Q : TabCoef = (

           1.50314182634250003249E1,

           8.27410449222435217021E1,

           2.20664384982121929218E2,

           3.07254189979530058263E2,

           2.14955586696422947765E2,

           5.96677339718622216300E1, 0);



{ Coefficients for log(x) = z + z**3 P(z)/Q(z),

  where z = 2(x-1)/(x+1)

  1/sqrt(2) <= x < sqrt(2)  }



       R : TabCoef = (

           -7.89580278884799154124E-1,

            1.63866645699558079767E1,

           -6.41409952958715622951E1, 0, 0, 0, 0);

       S : TabCoef = (

           -3.56722798256324312549E1,

            3.12093766372244180303E2,

           -7.69691943550460008604E2, 0, 0, 0, 0);



var e : Integer;

    z, y : Float;



Label Ldone;

{

    All four routines return a double precision floating point

    result.



    floor() returns the largest integer less than or equal to x.

    It truncates toward minus infinity.



    ceil() returns the smallest integer greater than or equal

    to x.  It truncates toward plus infinity.



    frexp() extracts the exponent from x.  It returns an integer

    power of two to expnt and the significand between 0.5 and 1

    to y.  Thus  x = y * 2**expn.



    ldexp() multiplies x by 2**n.



    These functions are part of the standard C run time library

    for many but not all C compilers.  The ones supplied are

    written in C for either DEC or IEEE arithmetic.  They should

    be used only if your compiler library does not already have

    them.



    The IEEE versions assume that denormal numbers are implemented

    in the arithmetic.  Some modifications will be required if

    the arithmetic has abrupt rather than gradual underflow.

}

begin

  if( x <= 0.0 ) then

  begin

    if( x = 0.0 ) then

      mtherr( 'Log', SING )

    else

      mtherr( 'Log', DOMAIN );

    Log :=  MINLOG;

  end;

  x := frexp( x, e );



  { logarithm using log(x) = z + z**3 P(z)/Q(z),

    where z = 2(x-1)/x+1) }



  if( (e > 2) or (e < -2) ) then

  begin

    if( x < SQRTH ) then

     begin

        {  2( 2x-1 )/( 2x+1 ) }

        Dec(e, 1);

        z := x - 0.5;

        y := 0.5 * z + 0.5;

     end

    else

     begin

        {   2 (x-1)/(x+1)   }

        z := x - 0.5;

        z := z - 0.5;

        y := 0.5 * x  + 0.5;

     end;



    x := z / y;





    { /* rational form */ }

    z := x*x;

    z := x + x * ( z * polevl( z, R, 2 ) / p1evl( z, S, 3 ) );



    goto ldone;

  end;



  { logarithm using log(1+x) = x - .5x**2 + x**3 P(x)/Q(x) }



  if( x < SQRTH ) then

   begin

     Dec(e, 1);

     x := ldexp( x, 1 ) - 1.0; {  2x - 1  }

   end

  else

    x := x - 1.0;



  { rational form  }

  z := x*x;

  y := x * ( z * polevl( x, P, 6 ) / p1evl( x, Q, 6 ) );

  y := y - ldexp( z, -1 );   {  y - 0.5 * z  }

  z := x + y;



ldone:



  { recombine with exponent term }

  if( e <> 0 ) then

   begin

     y := e;

     z := z - y * 2.121944400546905827679e-4;

     z := z + y * 0.693359375;

   end;



  Log:= z;

end;







function Log10(x:Float):Float;

{

    Common logarithm







    SYNOPSIS:



    double x, y, log10();



    y = log10( x );







    DESCRIPTION:



    Returns logarithm to the base 10 of x.



    The argument is separated into its exponent and fractional

    parts.  The logarithm of the fraction is approximated by



        log(1+x) = x - 0.5 x**2 + x**3 P(x)/Q(x).

}







{ Coefficients for log(1+x) = x - x**2/2 + x**3 P(x)/Q(x)  }

{  1/sqrt(2) <= x < sqrt(2)  }

const  P : TabCoef = (

           4.58482948458143443514E-5,

           4.98531067254050724270E-1,

           6.56312093769992875930E0,

           2.97877425097986925891E1,

           6.06127134467767258030E1,

           5.67349287391754285487E1,

           1.98892446572874072159E1);

       Q : TabCoef = (

           1.50314182634250003249E1,

           8.27410449222435217021E1,

           2.20664384982121929218E2,

           3.07254189979530058263E2,

           2.14955586696422947765E2,

           5.96677339718622216300E1, 0);



       SQRTH = 0.70710678118654752440;

       L102A = 3.0078125E-1;

       L102B = 2.48745663981195213739E-4;

       L10EA = 4.3359375E-1;

       L10EB = 7.00731903251827651129E-4;



var e : Integer;

    w, y, z : Float;

begin

  if( x <= 0.0 ) then

   begin

        if( x = 0.0 ) then

                mtherr( 'Log10', SING )

        else

                mtherr( 'Log10', DOMAIN );

        Log10 := MINLOG;

   end

  else

   begin



{ separate mantissa from exponent  }

    x := frexp( x, e );



{ logarithm using log(1+x) = x - .5x**2 + x**3 P(x)/Q(x)  }

    if( x < SQRTH ) then

     begin

        dec(e);

        x := ldexp( x, 1 ) - 1.0; {  2x - 1  }

     end

    else

        x := x - 1.0;



{ rational form }

    z := x*x;

    y := x * ( z * polevl( x, P, 6 ) / p1evl( x, Q, 6 ) );

    y := y - ldexp( z, -1 );   {  y - 0.5 * x**2  }



{ multiply log of fraction by log10(e) }

{ and base 2 exponent by log10(2)  }

    z := (x + y) * L10EB;  { accumulate terms in order of size }

    z := z + y * L10EA;

    z := z + x * L10EA;

    w := e;

    z := z + w * L102B;

    z := z + w * L102A;

    Log10 := z ;

   end;

end;







function Exp10(x:Float):Float;

{

    Base 10 exponential function

         (Common antilogarithm)







    SYNOPSIS:



    double x, y, exp10();



    y = exp10( x );







    DESCRIPTION:



    Returns 10 raised to the x power.



    Range reduction is accomplished by expressing the argument

    as 10**x = 2**n 10**f, with |f| < 0.5 log10(2).

    The Pade' form



       1 + 2x P(x**2)/( Q(x**2) - P(x**2) )



    is used to approximate 10**f.

}

const  P : TabCoef = (

           4.09962519798587023075E-2,

           1.17452732554344059015E1,

           4.06717289936872725516E2,

           2.39423741207388267439E3, 0, 0 ,0);

       Q : TabCoef = (

           8.50936160849306532625E1,

           1.27209271178345121210E3,

           2.07960819286001865907E3, 0, 0, 0, 0);



           LOG210 = 3.32192809488736234787e0;

           LG102A = 3.01025390625000000000E-1;

           LG102B = 4.60503898119521373889E-6;

           MAXL10 = 38.230809449325611792;



var px, xx : Float;

    n : Integer;

begin

  if( x > MAXL10 ) then

   begin

        mtherr( 'exp10', OVERFLOW );

        Exp10 :=  MAXNUM;

   end

  else

   if( x < -MAXL10 ) then       { Would like to use MINLOG but can't }

    begin

        mtherr( 'exp10', UNDERFLOW );

        Exp10 := 0.0;

    end

   else

    begin

{ Express 10**x = 10**g 2**n  }

{   = 10**g 10**( n log10(2) ) }

{   = 10**( g + n log10(2) )  }



     px := floor( LOG210 * x + 0.5 );

     n  := Trunc(px);

     x  := x - px * LG102A;

     x  := x - px * LG102B;



{ rational approximation for exponential  }

{ of the fractional part:  }

{ 10**x = 1 + 2x P(x**2)/( Q(x**2) - P(x**2) ) }



     xx  := x * x;

     px  := x * polevl( xx, P, 3 );

     x   :=  px/( p1evl( xx, Q, 3 ) - px );

     x   := 1.0 + ldexp( x, 1 );



{ multiply by power of 2 }



     x   := ldexp( x, n );



     Exp10 := x;

    end

end;







function Cosh(x:Float):Float;

{

        Hyperbolic cosine







    SYNOPSIS:



    double x, y, cosh();



    y = cosh( x );







    DESCRIPTION:



    Returns hyperbolic cosine of argument in the range MINLOG to

    MAXLOG.



    cosh(x)  =  ( exp(x) + exp(-x) )/2. }



var y : Float;

begin

  if( x < 0 ) then

        x := -x;

  if( x > MAXLOG ) then

   begin

     mtherr( 'cosh', OVERFLOW );

     Cosh := MAXNUM ;

   end

  else

   begin

     y := exp(x);

     y := y + 1.0/y;

     y := ldexp( y, -1 );

     Cosh :=  y ;

  end;

end;







function ACosh(x:Float):Float;

{  Inverse hyperbolic cosine



   SYNOPSIS:



   double x, y, acosh();



   y = acosh( x );





   Returns inverse hyperbolic cosine of argument.



   If 1 <= x < 1.5, a rational approximation



        sqrt(z) * P(z)/Q(z)



   where z = x-1, is used.  Otherwise,



   acosh(x)  =  log( x + sqrt( (x-1)(x+1) ).

}

const P : TabCoef = (

           1.18801130533544501356E2,

           3.94726656571334401102E3,

           3.43989375926195455866E4,

           1.08102874834699867335E5,

           1.10855947270161294369E5, 0, 0);

      Q : TabCoef = (

           1.86145380837903397292E2,

           4.15352677227719831579E3,

           2.97683430363289370382E4,

           8.29725251988426222434E4,

           7.83869920495893927727E4, 0, 0);



var z,a : Float;

begin

{ acosh(z) = sqrt(x) * R(x), z = x + 1, interval 0 < x < 0.5  }

  if( x < 1.0 ) then

  begin

    mtherr( 'acosh', DOMAIN );

    ACosh :=0.0;

  end

  else

  if( x > 1.0e8 ) then

    ACosh :=( log(x) + LOGE2 )

  else

   begin

     z := x - 1.0;

     if( z < 0.5 ) then

     begin

       a := sqrt(z) * (polevl(z, P, 4) / p1evl(z, Q, 5) );

       ACosh := a;

     end

     else

     begin

       a := sqrt( z*(x+1.0) );

       ACosh :=( log(x + a) );

     end;

  end;

end;





function Sinh(x:Float):Float;

{

        Hyperbolic sine







    SYNOPSIS:



    double x, y, sinh();



    y = sinh( x );







    DESCRIPTION:



    Returns hyperbolic sine of argument in the range MINLOG to

    MAXLOG.



    The range is partitioned into two segments.  If |x| <= 1, a

    rational function of the form x + x**3 P(x)/Q(x) is employed.

    Otherwise the calculation is sinh(x) = ( exp(x) - exp(-x) )/2.

}

const P : TabCoef = (

          -7.89474443963537015605E-1,

          -1.63725857525983828727E2,

          -1.15614435765005216044E4,

          -3.51754964808151394800E5, 0, 0, 0);

      Q : TabCoef = (

          -2.77711081420602794433E2,

           3.61578279834431989373E4,

          -2.11052978884890840399E6, 0, 0, 0, 0);

var a : Float;

begin

  a := fabs(x);

  if( (a > MAXLOG) or (a > -MINLOG) ) then

   begin

     mtherr( 'sinh', DOMAIN );

     if( x > 0 ) then

      Sinh := MAXNUM

     else

      Sinh := -MAXNUM;

   end

  else

   if( a > 1.0 ) then

    begin

      a := exp(a);

      a := 0.5*a - (0.5/a);

      if( x < 0 ) then

        a := -a;

      Sinh := a;

    end

   else

    begin

      a := a*a;

      Sinh :=  x + x * a * (polevl(a,P,3)/p1evl(a,Q,3)) ;

    end;

end;





function ASinh(x:Float):Float;

{

        Inverse hyperbolic sine





    SYNOPSIS:



    double x, y, asinh();



    y = asinh( x );





    DESCRIPTION:



    Returns inverse hyperbolic sine of argument.



    If |x| < 0.5, the function is approximated by a rational

    form  x + x**3 P(x)/Q(x).  Otherwise,



        asinh(x) = log( x + sqrt(1 + x*x) ).



}

const P : TabCoef = (

          -4.33231683752342103572E-3,

          -5.91750212056387121207E-1,

          -4.37390226194356683570E0,

          -9.09030533308377316566E0,

          -5.56682227230859640450E0, 0, 0);

      Q : TabCoef = (

           1.28757002067426453537E1,

           4.86042483805291788324E1,

           6.95722521337257608734E1,

           3.34009336338516356383E1, 0, 0, 0);



 var Sign      : Integer;

     a,z,zz,pp : Float;

     Flag      : byte;

begin

  if( x < 0.0 ) then begin sign := -1; x := -x end

  else  sign := 1;

  if( x > 1.0e8 ) then

    ASinh := sign * (log(x) + LOGE2)

  else

   begin

     z := x * x;

     if( x < 0.5 ) then

     begin

        a := ( polevl(z, P, 4)/p1evl(z, Q, 4) ) * z;

        a := a * x  +  x;

        if( sign < 0 ) then a := -a;

        ASinh := a;

     end

    else

     begin

      a := sqrt( z + 1.0 );

      ASinh :=( sign * log(x + a) );

     end;

  end;

end;







function TanCot(xx:Float; cotflg:Boolean):Float;

const P : TabCoef = (

          -1.30936939181383777646E4,

           1.15351664838587416140E6,

           -1.79565251976484877988E7, 0, 0, 0, 0);

      Q : TabCoef = (

           1.36812963470692954678E4,

          -1.32089234440210967447E6,

           2.50083801823357915839E7,

          -5.38695755929454629881E7, 0, 0, 0);



    DP1    = 7.853981554508209228515625E-1;

    DP2    = 7.94662735614792836714E-9;

    DP3    = 3.06161699786838294307E-17;



var x,y,z,zz : Float;

    Sign,j   : Integer;

begin

{ make argument positive but save the sign }

  if( xx < 0 ) then

   begin

        x := -xx;

        sign := -1;

   end

  else

   begin

        x := xx;

        sign := 1;

   end;



   if( x > lossth ) then

    begin

        if( cotflg ) then

                mtherr( 'cot', TLOSS )

        else

                mtherr( 'tan', TLOSS );

        TanCot := 0.0;

   end;



{ compute x mod PIO4 }

   y := floor( x/PIO4 );



{ strip high bits of integer part }

   z := ldexp( y, -3 );

   z := floor(z);               { integer part of y/8 }

   z := y - ldexp( z, 3 );      { y - 16 * (y/16) }



{ integer and fractional part modulo one octant }

   j := Trunc(z);



{ map zeros and singularities to origin }

   if odd(j) then

    begin

        inc(j);

        y := y+1.0;

    end;



    z := ((x - y * DP1) - y * DP2) - y * DP3;



    zz := z * z;



    if( zz > 1.0e-14 ) then

        y := z  +  z * (zz * polevl( zz, P, 2 )/p1evl(zz, Q, 4))

    else

        y := z;



    if( j and 2 )>0 then

     begin

        if( cotflg ) then

                y := -y

        else

                y := -1.0/y;

     end

    else

        if( cotflg ) then

                y := 1.0/y;



    if( sign < 0 ) then

        y := -y;



    Tancot := y ;

end;







function Cot(x:Float):Float;

{

    Circular cotangent







    SYNOPSIS:



    double x, y, cot();



    y = cot( x );







    DESCRIPTION:



    Returns the circular cotangent of the radian argument x.



    Range reduction is modulo pi/4.  A rational function

          x + x**3 P(x**2)/Q(x**2)

    is employed in the basic interval [0, pi/4].

}

begin

  if( x = 0.0 ) then

   begin

     mtherr( 'cot', SING );

     Cot := MAXNUM;

   end

  else

  Cot := tancot(x, True);

end;





function Tan(x:Float):Float;

{

    Circular tangent







    SYNOPSIS:



    double x, y, tan();



    y = tan( x );







    DESCRIPTION:



    Returns the circular tangent of the radian argument x.



    Range reduction is modulo pi/4.  A rational function

          x + x**3 P(x**2)/Q(x**2)

    is employed in the basic interval [0, pi/4].

}

begin

  Tan := tancot(x, False);

end;





function Atan(x:Float):Float;

{

    Inverse circular tangent

         (arctangent)







    SYNOPSIS:



    double x, y, atan();



    y = atan( x );







    DESCRIPTION:



    Returns radian angle between -pi/2 and +pi/2 whose tangent

    is x.



    Range reduction is from four intervals into the interval

    from zero to  tan( pi/8 ).  The approximant uses a rational

    function of degree 3/4 of the form x + x**3 P(x)/Q(x).

}

const P : TabCoef = (

          -8.40980878064499716001E-1,

          -8.83860837023772394279E0,

          -2.18476213081316705724E1,

          -1.48307050340438946993E1, 0, 0, 0);

      Q : TabCoef = (

          1.54974124675307267552E1,

          6.27906555762653017263E1,

          9.22381329856214406485E1,

          4.44921151021319438465E1, 0, 0, 0);



{ tan( 3*pi/8 ) }

   T3P8 = 2.41421356237309504880;

{ tan( pi/8 )   }

    TP8 = 0.41421356237309504880;



var y,z  : Float;

    Sign : Integer;



begin

{ make argument positive and save the sign }

  sign := 1;

  if( x < 0.0 ) then

   begin

     sign := -1;

     x := -x;

   end;



{ range reduction }

  if( x > T3P8 ) then

   begin

     y := PIO2;

     x := -( 1.0/x );

   end

  else if( x > TP8 ) then

   begin

     y := PIO4;

     x := (x-1.0)/(x+1.0);

   end

  else

    y := 0.0;



{ rational form in x**2 }



  z := x * x;

  y := y + ( polevl( z, P, 3 ) / p1evl( z, Q, 4 ) ) * z * x + x;



  if( sign < 0 ) then

        y := -y;



  Atan := y;

end;







function Atan2( y, x: Float):Float;

{

    Quadrant correct inverse circular tangent







    SYNOPSIS:



    double x, y, z, atan2();



    z = atan2( y, x );







    DESCRIPTION:



    Returns radian angle whose tangent is y/x.

    Define compile time symbol ANSIC = 1 for ANSI standard,

    range -PI < z <= +PI, args (y,x); else ANSIC = 0 for range

    0 to 2PI, args (x,y).

}

var z, w : Float;

    code : Integer;

begin

  code := 0;

  if ( x < 0.0 ) then

        code := 2;

  if ( y < 0.0 ) then

        code := code or 1;

  if ( x = 0.0 ) then

   begin

     if ( code and 1 )>0 then

       Atan2 := -PIO2

     else

      if ( y = 0.0 ) then

        Atan2 := 0.0

      else

        Atan2 := PIO2;

     Exit;

   end;



  if ( y = 0.0 ) then

   begin

    if ( code and 2 )>0 then

      Atan2 := PI

    else

      Atan2 := 0.0;

    Exit;

   end;



   case code of

     0,

     1: w := 0.0;

     2: w := PI; 

     3: w := -PI;

   end;



   Atan2 := w + Arctan( y/x ) ;   { Utilise le Arctan r_sident, prend moins de place  }

end;







function Tanh(x:Float):Float;

{

    Hyperbolic tangent







    SYNOPSIS:



    double x, y, tanh();



    y = tanh( x );







    DESCRIPTION:



    Returns hyperbolic tangent of argument in the range MINLOG to

    MAXLOG.



    A rational function is used for |x| < 0.625.  The form

    x + x**3 P(x)/Q(x) of Cody _& Waite is employed.

    Otherwise,

       tanh(x) = sinh(x)/cosh(x) = 1  -  2/(exp(2x) + 1).

}

const P : TabCoef = (

          -9.64399179425052238628E-1,

          -9.92877231001918586564E1,

          -1.61468768441708447952E3, 0 ,0, 0, 0);

      Q : TabCoef = (

          1.12811678491632931402E2,

          2.23548839060100448583E3,

          4.84406305325125486048E3, 0 ,0, 0, 0);

var z, s : Float;

begin

  z := fabs(x);

  if( z > 0.5 * MAXLOG ) then

   begin

        if( x > 0 ) then

                Tanh := 1.0

        else

                Tanh := -1.0 ;

   end

  else

   if( z >= 0.625 ) then

    begin

        s := exp(2.0*z);

        z :=  1.0  - 2.0/(s + 1.0);

        if( x < 0 ) then

                z := -z;

    end

   else

    begin

        s := x * x;

        z := polevl( s, P, 2 )/p1evl(s, Q, 3);

        z := x * s * z;

        z := x + z;

    end;

  Tanh :=  z ;

end;







function ATanh(x:Float):Float;

{

    Inverse hyperbolic tangent







    SYNOPSIS:



    double x, y, atanh();



    y = atanh( x );







    DESCRIPTION:



    Returns inverse hyperbolic tangent of argument in the range

    MINLOG to MAXLOG.



    If |x| < 0.5, the rational form x + x**3 P(x)/Q(x) is

    employed.  Otherwise,

           atanh(x) = 0.5 * log( (1+x)/(1-x) ).

}

const P : TabCoef = (

          -8.54074331929669305196E-1,

           1.20426861384072379242E1,

          -4.61252884198732692637E1,

           6.54566728676544377376E1,

          -3.09092539379866942570E1, 0, 0);

      Q : TabCoef = (

          -1.95638849376911654834E1,

           1.08938092147140262656E2,

          -2.49839401325893582852E2,

           2.52006675691344555838E2,

          -9.27277618139601130017E1, 0, 0);

var z, s : Float;

begin

  z := fabs(x);

  if( z >= 1.0 ) then

   begin

        if( x = 1.0 ) then

                Atanh :=  MAXNUM

        else

         if( x = -1.0 ) then

                Atanh := -MAXNUM

         else  { |x| > 1.0 }

          begin

           mtherr( 'atanh', DOMAIN );

           Atanh :=  MAXNUM ;

          end

   end

  else

   if( z < 1.0e-7 ) then

        Atanh := x

   else

    if( z < 0.5 ) then

     begin

        z := x * x;

        s := x   +  x * z * (polevl(z, P, 4) / p1evl(z, Q, 5));

        Atanh := s;

     end

    else

     Atanh :=  0.5 * log((1.0+x)/(1.0-x)) ;

end;







function sqrt(x:Float):Float;

{

        Square root







    SYNOPSIS:



    double x, y, sqrt();



    y = sqrt( x );







    DESCRIPTION:



    Returns the square root of x.



    Range reduction involves isolating the power of two of the

    argument and using a polynomial approximation to obtain

    a rough value for the square root.  Then Heron's iteration

    is used three times to converge to an accurate value.

}

var e   : Integer;

    w,z : Float;

begin

  if( x <= 0.0 ) then

   begin

     if( x < 0.0 ) then

       mtherr( 'sqrt', DOMAIN );

     sqrt := 0.0;

   end

  else

   begin

     w := x;

     { separate exponent and significand }

     z := frexp( x, e );



     {  approximate square root of number between 0.5 and 1  }

     {  relative error of approximation = 7.47e-3            }

     x := 4.173075996388649989089E-1 + 5.9016206709064458299663E-1 * z;



     { adjust for odd powers of 2 }

     if odd(e) then

       x := x*SQRT2;



     { re-insert exponent }

     x := ldexp( x, (e div 2) );



     { Newton iterations: }

     x := 0.5*(x + w/x);

     x := 0.5*(x + w/x);

     x := 0.5*(x + w/x);

     x := 0.5*(x + w/x);

     x := 0.5*(x + w/x);

     x := 0.5*(x + w/x);



     sqrt := x;

   end;

end;





function cbrt(x:Float):Float;

{

    Cube root







    SYNOPSIS:



    double x, y, cbrt();



    y = cbrt( x );







    DESCRIPTION:



    Returns the cube root of the argument, which may be negative.



    Range reduction involves determining the power of 2 of

    the argument.  A polynomial of degree 2 applied to the

    mantissa, and multiplication by the cube root of 1, 2, or 4

    approximates the root to within about 0.1%.  Then Newton's

    iteration is used three times to converge to an accurate

    result.

}

const

     CBRT2 = 1.25992104989487316477;

     CBRT4 = 1.58740105196819947475;

var e, rem, Sign : Integer;

    z : Float;

begin

  if( x = 0 ) then

        cbrt :=  0.0

  else

   if( x > 0 ) then

        sign := 1

   else

    begin

        sign := -1;

        x := -x;

    end;



  z := x;



{ extract power of 2, leaving }

{ mantissa between 0.5 and 1  }

  x := frexp( x, e );



{ Approximate cube root of number between .5 and 1, }

{ peak relative error = 6.36e-4  }

  x := (-1.9150215751434832257e-1  * x

     + 6.9757045195246484393e-1) * x

     + 4.9329566506409572486e-1;



{ exponent divided by 3 }

  if( e >= 0 ) then

   begin

        rem := e;

        e := e div 3;

        rem := rem - 3*e;

        if( rem = 1 ) then

                x := x*CBRT2

        else if( rem = 2 ) then

                x := x*CBRT4;

   end



{ argument less than 1 }



  else

   begin

        e := -e;

        rem := e;

        e := e div 3;

        rem := rem - 3*e;

        if( rem = 1 ) then

                x := x/CBRT2

        else if( rem = 2 ) then

                x := x/CBRT4;

        e := -e;

    end;



{ multiply by power of 2 }

  x := ldexp( x, e );



{ Newton iteration }

  x := x - ( x - (z/(x*x)) )/3.0;

  x := x - ( x - (z/(x*x)) )/3.0;

  x := x - ( x - (z/(x*x)) )/3.0;



  if( sign < 0 ) then

        x := -x;

  cbrt := x;

end;





{ Imp_ratif pour _liminer les divisions par 0 ! }

function NonZ(x:Float):Float;

begin

  if Abs(x)<Epsilon then NonZ:=Epsilon*Sgn(x)*0.01 else NonZ:=x;

end;



function Encadre(a, b, c: LongInt):LongInt;

begin

  Encadre := MinI(MaxI(a,b),c);

end;



function Sqr3(a,b,c:Float):Float;

begin

  sqr3:=sqr(a)+sqr(b)+sqr(c);

end;



function Module(var V:TNVector):Float;

begin

  Module := Sqrt(Sqr(V[1]) + Sqr(V[2]) + Sqr(V[3]));

end;



function Longitude(var V:TNVector):Float;

begin

{

  Hypo := sqrt(sqr(V[1]) + sqr(V[3]));

  Longitude := ACos(DivNonZ(V[3], Hypo)) * Sgn(V[1]);

  }

  Longitude := -ATan2(V[1], V[3]);

end;



function Latitude(var V:TNVector):Float;

begin

  Latitude := -ASin(DivNonZ(V[2], Module(V)));  { La projection du module sur y }

end;



function Site(var V:TNVector):Float;

begin

{

  Hypo := sqrt(sqr(V[1]) + sqr(V[2]));

  Site := ACos(DivNonZ(V[1], Hypo)) * Sgn(V[2]);

  }

  Site := ATan2(V[2], V[1]);

end;



function Elevation(var V:TNVector):Float;

begin

{

  Hypo := sqrt(sqr(V[2]) + sqr(V[3]));

  Elevation := ACos(DivNonZ(V[3], Hypo)) * Sgn(V[2]);

  }

  Elevation :=  ATan2(V[2], V[3]);

end;



function Azimut(var V:TNVector):Float;

begin

  Azimut := ATan2(V[3], V[1]);

end;



procedure MesureVecteur(var Vecteur:TNVector; var Param:TParamV);

begin

  Param[3] := Module(Vecteur);

  Param[1] := Deg(Latitude(Vecteur));

  Param[2] := Deg(Longitude(Vecteur));

  Param[4] := Deg(Site(Vecteur));

  Param[5] := Deg(Elevation(Vecteur));

  Param[6] := Deg(Azimut(Vecteur));

end;



{ Proc_dure classique }

procedure CoordonneeMatrice(var Mat:TNMatrix; var V:TNVector; IsRepereObj:Boolean);

var Mat1 : TNMatrix;

begin

 if IsRepereObj then  { X0, Y1, Z2 }

  begin

{ Etape 4 }

{

x""=  x(cos(2)cos(3)) + y(cos(1)sin(3)-sin(1)sin(2)cos(3)) + z(cos(1)sin(2)cos(3) + sin(1)sin(3))

y""=  x(-cos(2)sin(3))+ y(cos(1)cos(3)-sin(1)sin(2)sin(3)) + z(cos(1)sin(2)sin(3) + sin(1)cos(3))

z""=  x(-sin(2))      + y(-sin(1)cos(2))                   + zcos(1)cos(2)

}

  V[2]   := -ASin(Limite(Mat[1,3]));           { C'est  bien la m_me formule que la Latitude }



  V[1]   := Acos(Limite(DivNonZ(Mat[3,3], Cos(V[2]))));     { La longitude n'est pas la rotation autour de Y }

  if Abs(-Sin(V[1])*Cos(V[2])-Mat[2,3])>0.01 then

   begin

    V[2]   := PI-V[2];

    V[1]   := PI-V[1];

   end;



  V[3]   := Acos(Limite(DivNonZ(Mat[1,1], Cos(V[2]))));

  

  if Abs(Cos(V[1])*Sin(V[3])+Sin(V[1])*Mat[1,3]*Cos(V[3])-Mat[2,1])>0.01 then

   begin

    V[1] := V[1]-PI;

    V[2] := PI-V[2];

    V[3] := PI-V[3];

   end;





{  !!! Attention ceci marche tr_s bien pour Z !!! }

  if (Abs(Mat[2,3])<0.001) then      { Z est sur le plan horizontal }

   if (Abs(Mat[3,3])<0.001) then     { Z est sur l'axe horizontal }

    begin

     V[3]   := Atan2(Mat[2,1], Mat[2,2]);      { Bon pour horizontal }

     V[1]   := 0;

    end;

  

   OptimiseRotation(V);



{  VerifAngle(V, Mat);  }



  (*

  if MathError>0 then

    Averti(MathStrErreur);

    *)

  end

 else     { Rep_re observateur = Latitude, Longitude, Rotation propre }

  begin

    { premi_re rotation autour de X0 }

    Mat1:=Mat;

    TransposeMat(DimenMat, Mat1); { pour avoir les axes de l'observateur }



    V[1] := Latitude(Mat1[3]);

    V[2] := Longitude(Mat1[3]);

    V[3] := 0;



    Initial(DimenMat, Mat1);

    RotationMatrice(V, Mat1, RObservateur);   { Construction d'une base observateur }

    MultMat(DimenMat, Mat, Mat1, Mat1);

    V[3] := ACos(Limite(Mat1[2,2]))*Sgn(Mat1[1,2]);

  end;

end;





function Egal(A, B:Float):boolean;

begin

  if abs(A-B)<=Epsilon then

    Egal := True

  else

    Egal := False;

end;



procedure OptimiseRotation(var Vn:TNVector);

const Epsi = PI-100000*Epsilon2;

var No, i, j, k:Byte;

    Max        : Float;

begin

     for No:=1 to DimenMat do

       if abs(Vn[No])>=PI2 then

         Vn[No]:=Vn[No]-PI2*Sgn(Vn[No]);

     for No:=1 to DimenMat do

      begin

       for i:=1 to DimenMat do

         if i<>No then

         begin

           k:=j; j:=i;

         end;

       if (abs(Vn[k])>=Epsi) and (Abs(Vn[j])>=Epsi) then

         for i:=1 to DimenMat do

            Vn[i] := Vn[i]-PI*Sgn(Vn[i]);

      end;

end;





function VerifAngle(var V:TNVector; var Mat:TNMatrix):Boolean;

var C,S    : TNVector;

    i      : Byte;

    A, B, D: Real;

    Erreur : Boolean;

begin

  for i:=1 to 3 do

   begin

     C[i] := Cos(V[i]);

     S[i] := Sin(V[i]);

   end;

{ Etape 4 }

{

x""=  x(cos(2)cos(3)) + y(cos(1)sin(3)-sin(1)sin(2)cos(3)) + z(cos(1)sin(2)cos(3) + sin(1)sin(3))

y""=  x(-cos(2)sin(3))+ y(cos(1)cos(3)-sin(1)sin(2)sin(3)) + z(cos(1)sin(2)sin(3) + sin(1)cos(3))

z""=  x(-sin(2))      + y(-sin(1)cos(2))                   + zcos(1)cos(2)

}

  A := C[2]*C[3]                - Mat[1,1]

     + C[1]*S[3]-S[1]*S[2]*C[3] - Mat[2,1]

     - S[1]*C[2]                - Mat[2,3]

{     + C[1]*S[2]*C[3]-S[1]*S[3] - Mat[3,1] }

     + C[1]*S[2]*S[3]-S[1]*C[3] - Mat[3,2]

{     - S[2]                     - Mat[1,3] }

{    + C[1]*C[3]-S[1]*S[2]*S[3] - Mat[2,2] }

     + C[1]*C[2]                - Mat[3,3];

  Erreur := (abs(A)<0.01) ;

  VerifAngle := Erreur;

end;





procedure Ajuste(var V:TNVector; var Mat:TNMatrix);

var W      : TNVector;

    i      : Byte;

    StTest : array[0..80] of char;

begin

  i := 0;

  Repeat

    Case (i and 3) of

      0 : W[1] := V[1];

      1 : W[1] := -V[1];

      2 : W[1] := PI-V[1];

      3 : W[1] := -PI-V[1];

    end;

    Case ((i and 12) shr 2) of

      0 : W[2] := V[2];

      1 : W[2] := -V[2];

      2 : W[2] := PI-V[2];

      3 : W[2] := -PI-V[2];

    end;

    Case ((i and 48) shr 4) of

      0 : W[3] := V[3];

      1 : W[3] := -V[3];

      2 : W[3] := PI-V[3];

      3 : W[3] := -PI-V[3];

    end;

    Inc(i);

  Until (i=48) or VerifAngle(W, Mat);

  if i=48 then

   begin 

    MessageBeep(0);  { Erreur }

{    W := V; }

   end;

{  Str(i, StTest); TestTexte(StTest); }

{  V := W; }

end;







{----------------------------------------------------------}

{                                                          }

{   Routines de calcul matriciel                           }

{                                                          }

{----------------------------------------------------------}

procedure ClearVect(var Data  : TNVector);

begin

  FillChar(Data, SizeOf(Data), 0);

end;



procedure AddVecteur(Dimen:Integer; var A, B, C : TNVector);

var i:Integer;

begin

  for i:=1 to Dimen do

    C[i] := A[i]+B[i];

end;



procedure SubVecteur(Dimen:Integer; var A, B, C : TNVector);

var i:Integer;

begin

  for i:=1 to Dimen do

    C[i] := A[i]-B[i];

end;



procedure ClearMat(var Data  : TNmatrix);

begin

  FillChar(Data, SizeOf(Data), 0);

end;



procedure Initial(Dimen : integer;

              var Data  : TNmatrix);

{----------------------------------------------------------}

{- Output: Data                                           -}

{-                                                        -}

{- This procedure intializes the above variables to zero. -}

{----------------------------------------------------------}



var i:Byte;

begin

  ClearMat(Data);

  for i:=1 to Dimen do

    Data[i,i]:=1;

end; { procedure Initial }



procedure MultMat(Dimen : Integer; MatA, MatB:TNMatrix; var MatC:TNMatrix);

var i,j: Integer;

begin

  for i:=1 to Dimen do

    for j:=1 to Dimen do

      MatC[i,j] := MatA[i,1]*MatB[1,j] + MatA[i,2]*MatB[2,j] + MatA[i,3]*MatB[3,j];

end;



procedure MultMatVect(Dimen : Integer; var Mat:TNMatrix; var V:TNVector);

var i,j: Integer;

    V2 : TNVector;

begin

  ClearVect(V2);

  for i:=1 to Dimen do

    for j:=1 to Dimen do

      V2[i] := V2[i] + Mat[i,j]*V[j];

  V:=V2;

end;



procedure DivMatFloat(Dimen : integer;

                  var Data  : TNmatrix;

                    Divisor : Float);

var i,j: Integer;

begin

  if abs(Divisor)<Epsilon then

    Divisor:=Epsilon;

  for i:=1 to Dimen do

     for j:=1 to Dimen do

        Data[i,j] := Data[i,j] / Divisor;

end;



procedure TransposeMat(Dimen : Integer; var Data:TNMatrix);

var i,j: Integer;

    R  : Float;

begin

  for i:=1 to Dimen do

     for j:=i+1 to Dimen do begin

        R := Data[i,j];

        Data[i,j] := Data[j,i];

        Data[j,i] := R;

     end;

end;



procedure InverseMatRot(DimenMat: Integer; var MatI:TNMatrix);

begin

  TransposeMat(DimenMat, MatI);

end;





procedure AffecteMat(p:Integer; Phi:Float; var Mat:TNMatrix);

{ Angles en radian }

var i,J,K:Integer;

    CosT,SinT: Float;

begin

  ClearMat(Mat);

  CosT:=Cos(Phi); SinT:=Sin(Phi);

  Mat[p,p] := 1;

  for i:=1 to DimenMat do

    if i<>P then

    begin

      K:=J; J:=i;

    end;

  Mat[J,J]:=  CosT; Mat[j,K]:= SinT;

  Mat[K,J]:= -SinT; Mat[K,K]:= CosT;

end;



procedure InitialiseXmat;

var i:Integer;

begin

  for i:=1 to 3 do

    AffecteMat(i, Pi/PartPi, XMat[i]);

  for i:=4 to 6 do

    AffecteMat(i-3, -Pi/PartPi, XMat[i]);

end;



procedure RotationMatrice(var PhiRot:TNvector; var MatRot:TNMatrix; Repere:Byte);

{ Angles en radian }

var MatT            : TNMatrix;

    V1,V2,V3,V4,V5,V6,V7,V8,

    V0, Phi, S0, C0, Rx, Ry, Rz : Real;

    i               : Integer;

begin

  Case Repere of

   RAnatomique :

    for i:=1 to DimenMat do   { Rotations X, Y, Z }

     if PhiRot[i]<>0.0 then

     begin   {!!! Rep_re Objet = Post-Multiplier !!!}

       AffecteMat(i, PhiRot[i], MatT);

       MultMat(DimenMat, MatRot, MatT, MatRot);

     end;



   Robservateur :

    for i:=DimenMat downto 1 do   { Rotations X, Y, Z }

     if PhiRot[i]<>0.0 then   { Evite les effacements de matrice }

     begin   {!!! Rep_re Observateur = Pr_-Multiplier !!!}

       AffecteMat(i, PhiRot[i], MatT);

       MultMat(DimenMat, MatT, MatRot, MatRot);

     end;



   RAxesPropres :

    begin

      { Pour la description de cette m_thode, consulter :

        "Rotation autour d'un vecteur arbitraire"

        ROBOTICS, Control, Sensing, Vision and Intelligence

        Edition McGraw-Hill Book Company (1987) page 20-22

      }

      Rx:= PhiRot[1]; Ry:= PhiRot[2]; Rz:= PhiRot[3]; Phi := PhiRot[4];

      C0:=Cos(Phi); S0:=Sin(Phi); V0:=1-C0;

      { M_thode l_g_re, peu rapide : 24 multiplications}

      {

      MatT[1,1] := Rx*Rx*V0+C0;     MatT[1,2] := Rx*Ry*V0-Rz*S0;   MatT[1,3] := Rx*Rz*V0+Ry*S0;

      MatT[2,1] := Rx*Ry*V0+Rz*S0;  MatT[2,2] := Ry*Ry*V0+C0;      MatT[2,3] := Ry*Rz*V0-Rx*S0;

      MatT[3,1] := Rx*Rz*V0-Ry*S0;  MatT[3,2] := Ry*Rz*V0+Rx*S0;   MatT[3,3] := Rz*Rz*V0+C0;

      }



      { M_thode plus rapide, moins l_g_re : 12 multiplications}

      V1 := Rx*V0;

      V2 := Ry*V1;

      V3 := Rz*V1;



      V4 := Rx*S0;

      V5 := Ry*S0;

      V6 := Rz*S0;



      V7 := Ry*V0;

      V8 := Rz*V7;



      MatT[1,1] := Rx*V1+C0;  MatT[1,2] := V2-V6;     MatT[1,3] := V3+V5;

      MatT[2,1] := V2+V6;     MatT[2,2] := Ry*V7+C0;  MatT[2,3] := V8-V4;

      MatT[3,1] := V3-V5;     MatT[3,2] := V8+V4;     MatT[3,3] := Rz*Rz*V0+C0;



      MultMat(DimenMat, MatRot, MatT, MatRot);    { Dans ses axes propres }

    end;

  end;

end;





procedure IncrementeMatrice(NoAxe, Sens : Integer; var MatRot, MatVP:TNMatrix; Rotation:Boolean);

begin

  if Sens=Moins then       { Change de matrice        }

    Inc(NoAxe,3);

  if RotationPropre then

    case RepereActuel of

      RAnatomique :

         {!!! Rep_re Objet = Post-Multiplier !!!}

         MultMat(DimenMat, MatRot, XMat[NoAxe], MatRot);

      RAxesPropres :

       begin

         if NoAxe>3 then Dec(NoAxe,3);

         if NoAxe=2 then Sens:=-Sens;

         MatVP[NoAxe][4]:=Pi/PartPi*Sens;

         RotationMatrice(MatVP[NoAxe], MatRot, RepereActuel);

       end;   

      Robservateur :

         {!!! Rep_re Observateur = Pr_-Multiplier !!!}

         MultMat(DimenMat, XMat[NoAxe], MatRot, MatRot);

    end

  else

    {!!! Rep_re Observateur = Pr_-Multiplier !!!}

    MultMat(DimenMat, XMat[NoAxe], MatRot, MatRot);

end;





{ Entr_e   :

    AA     : Tableau de valeurs enti_res

    N      : Taille du tableau AA

    Offsx  : Offset x _ rajouter _ toutes les valeurs de BB.x

    Offsy  : Offset y _ rajouter _ toutes les valeurs de BB.y

    X1, Xm : Indice de d_but et de fin du tableau _ agrandir



  Sortie   :

    BB     : Tableau de points sur l'_cran

    M      : Taille tu tableau BB _ remplir

}



procedure CSpline(var AA:_TabVal;

                      N : integer;

        X1, Xm, Echelle : Float;

                 var BB : _TabPoints;

        M, Offsx, Offsy : integer);



var

  I, K    : integer;

  Dx, T, P: Float;

  B, C, D : P_TabFloat;

{  AA      : _TabVal absolute AAA; }

label 1,2,3;



function SplineEval( T : Float; var I : integer) : Float;

var

  J, K : integer;

  Dx   : Float;

begin

  if I >= N then

    I := 1;

  if (T < I) or (T > (I+1)) then

  begin

    I := 1;

    J := N + 1;

    repeat

      K := (I + J) div 2;

      if T < K then

        J := K;

      if T >= K then

        I := K;

    until J <= (I + 1);

  end;

  Dx := T - I;

  SplineEval := AA[I] + Dx * (B^[I] + Dx * (C^[I] + Dx * D^[I]));

end; { SplineEval }



begin { CSpline }

  if ((N+1)*SizeOf(B^[1]))>MaxAvail then Goto 3;

  GetMem(B, (N+1)*SizeOf(B^[1]));

  if ((N+1)*SizeOf(C^[1]))>MaxAvail then Goto 2;

  GetMem(C, (N+1)*SizeOf(C^[1]));  

  if ((N+1)*SizeOf(D^[1]))>MaxAvail then Goto 1;

  GetMem(D, (N+1)*SizeOf(D^[1]));  

  if N >= 3 then

    begin

      D^[1] := 2 - 1;

      C^[2] := (AA[2] - AA[1]) / D^[1];

      for I := 2 to N-1 do

      begin

        D^[I] := I+1 - I;

        B^[I] := 2.0 * (D^[I-1] + D^[I]);

        C^[I+1] := (AA[I+1] - AA[I]) / D^[I];

        C^[I] := C^[I+1] - C^[I];

      end;

      B^[1] := -D^[1];

      B^[N] := -D^[N-1];

      C^[1] := 0.0;

      C^[N] := 0.0;

      if N > 3 then

      begin

        C^[1] := C^[3] / (4 - 2) - C^[2] / (3 - 1);

        C^[N] := C^[N-1] / (N - (N-2))

                - C^[N-2] / ((N-1) - (N-3));

        C^[1] := C^[1] * Sqr(D^[1]) / (4 - 1);

        C^[N] := -C^[N] * Sqr(D^[N-1]) / (N- (N-3));

      end;

      for I := 2 to N do

      begin

        T := D^[I-1] / B^[I-1];

        B^[I] := B^[I] - T * D^[I-1];

        C^[I] := C^[I] - T * C^[I-1];

      end;

      C^[N] := C^[N] / B^[N];

      for I := N-1 downto 1 do

        C^[I] := (C^[I] - D^[I] * C^[I+1]) / B^[I];

      B^[N] := (AA[N] - AA[N-1]) / D^[N-1] + D^[N-1] * (C^[N-1] + 2.0 * C^[N]);

      for I := 1 to N-1 do

      begin

        B^[I] := (AA[I+1] - AA[I]) / D^[I] - D^[I] * (C^[I+1] + 2.0 * C^[I]);

        D^[I] := (C^[I+1] - C^[I]) / D^[I];

        C^[I] := 3.0 * C^[I];

      end;

      C^[N] := 3.0 * C^[N];

      D^[N] := D^[N-1];

    end

  else

    if N = 2 then

    begin

      B^[1] := (AA[2] - AA[1]) / (2 - 1);

      C^[1] := 0.0;

      D^[1] := 0.0;

      B^[2] := B^[1];

      C^[2] := 0.0;

      D^[2] := 0.0;

    end;

  if (N >= 2) and (M >= 2) then

    if (X1 >= 1)  and (Xm <= N) then

      begin

        Dx := (Xm - X1) / (M - 1);

        K := 1;

        for I := 1 to M do

        begin

          P          := X1 + (I - 1) * Dx;

          BB[I].y    := -Round(SplineEval(P, K)*Echelle)+Offsy;

          BB[I].x    := I+Offsx;

        end;

      end

    else

   {   MtError(20, 7) }

  else

{    MtError(20, 4)};

  FreeMem(D, (N+1)*SizeOf(D^[1]));

  1:

  FreeMem(C, (N+1)*SizeOf(C^[1]));

  2:

  FreeMem(B, (N+1)*SizeOf(B^[1]));

  3:

end; { CSpline }







procedure Bezier(var A : _TabVal; MaxContrPoints : integer;

                 var B : _TabPoints; MaxIntPoints : integer);

const

  MaxControlPoints = 25;

type

  CombiArray = array[0..MaxControlPoints] of Float;

var

  N : integer;

  ContrPoint, IntPoint : integer;

  T, SumX, SumY, Prod, DeltaT, Quot : Float;

  Combi : CombiArray;



begin

  MaxContrPoints := MaxContrPoints - 1;

  DeltaT := 1.0 / (MaxIntPoints - 1);

  Combi[0] := 1;

  Combi[MaxContrPoints] := 1;

  for N := 0 to MaxContrPoints - 2 do

    Combi[N + 1] := Combi[N] * (MaxContrPoints - N) / (N + 1);

  for IntPoint := 1 to MaxIntPoints do

  begin

    T := (IntPoint - 1) * DeltaT;

    if T <= 0.5 then

      begin

        Prod := 1.0 - T;

        Quot := Prod;

        for N := 1 to MaxContrPoints - 1 do

          Prod := Prod * Quot;

        Quot := T / Quot;

        SumX := MaxContrPoints + 1;

        SumY := A[MaxContrPoints + 1];

        for N := MaxContrPoints downto 1 do

        begin

          SumX := Combi[N - 1] * N + Quot * SumX;

          SumY := Combi[N - 1] * A[N] + Quot * SumY;

        end;

      end

    else

      begin

        Prod := T;

        Quot := Prod;

        for N := 1 to MaxContrPoints - 1 do

          Prod := Prod * Quot;

        Quot := (1 - T) / Quot;

        SumX := 1;

        SumY := A[1];

        for N := 1 to MaxContrPoints do

        begin

          SumX := Combi[N] * (N + 1) + Quot * SumX;

          SumY := Combi[N] * A[N + 1] + Quot * SumY;

        end;

      end;

    B[IntPoint].x := Round(SumX * Prod);

    B[IntPoint].y := Round(SumY * Prod);

  end;  

end; { Bezier }





{===================================================================}

{ Procedure jacobi + ordonne d_j_ _crite le 31/8/82 1982 (voir documents) }

{===================================================================}

procedure CalculVecteurPropreB(var EigenVectors : TNmatrix;

                                  var PVecteur : _TabPVal;

                                        Taille : Word);

const

        Precis=1.6E-9;



type VCTI = array[1..DimenMat] of Integer;



var i,j         : Integer;

    SinT, CosT,

    Controle,

    Nu          : Float;

    VCI,VCIA,WCIR:TNvector;

    SI, SCI, SCRI, TSCRI,

    AMat, SMat  : TNMatrix;

    Indicat,

    QX,P,Q      : Integer;

    AXIND,

    ColInd      : VCTI;



  procedure CMATA0D;

  var i,j :Integer;

      Reduc:Float;

  begin

    ClearMat(AMat);

    for i:=0 to Taille-1 do

    begin

      Amat[1,1]:=AMat[1,1]+Int(PVecteur[1]^[i])*Int(PVecteur[1]^[i]);

      Amat[1,2]:=AMat[1,2]+Int(PVecteur[1]^[i])*Int(PVecteur[2]^[i]);

      Amat[1,3]:=AMat[1,3]-Int(PVecteur[1]^[i])*Int(PVecteur[3]^[i]);

      Amat[2,1]:=AMat[2,1]+Int(PVecteur[2]^[i])*Int(PVecteur[1]^[i]);

      Amat[2,2]:=AMat[2,2]+Int(PVecteur[2]^[i])*Int(PVecteur[2]^[i]);

      Amat[2,3]:=AMat[2,3]-Int(PVecteur[2]^[i])*Int(PVecteur[3]^[i]);

      Amat[3,1]:=AMat[3,1]-Int(PVecteur[3]^[i])*Int(PVecteur[1]^[i]);

      Amat[3,2]:=AMat[3,2]-Int(PVecteur[3]^[i])*Int(PVecteur[2]^[i]);

      Amat[3,3]:=AMat[3,3]+Int(PVecteur[3]^[i])*Int(PVecteur[3]^[i]);

    end;

    {$IFNDEF OPE }

    WriteMat('MatA=', AMat);

    {$ENDIF}

    Reduc:=0;

    for i:= 1 to DimenMat do

      for j:= 1 to DimenMat do begin

        if AMat[i,j]>Reduc then Reduc:=AMat[i,j];

      end;

    DivMatFloat(DimenMat, AMat, Reduc);

    {$IFNDEF OPE }

    WriteMat('MatA normalis_e =', AMat);

    {$ENDIF}

  end;



  procedure Trigo;

  var Omega, OmegaP, Lambda, Mu : Float;

  begin

    Lambda:=-AMat[P,Q];

    MU:=(AMat[P,P]-AMat[Q,Q])/2;

    OmegaP:=Lambda/Sqrt(sqr(Lambda)+sqr(MU));

    if MU<0 then Omega:=-OmegaP else Omega:=OmegaP;

    SinT:=Omega/Sqrt(2*(1+sqrt(1-sqr(Omega))));

    CosT:=sqrt(1-sqr(SinT));

    Controle:=sqr(SinT)+sqr(CosT);

  end;



  procedure Clcas;

  var BMat, SP : TNMatrix;

      CC,SS,SC : Float;

      I        : Integer;

  begin

    for i:=1 to DimenMat do

    begin

      BMat[i,P]:=AMat[i,P]*CosT-AMat[i,Q]*SinT;

      BMat[i,Q]:=AMat[i,P]*SinT+AMat[i,Q]*CosT;

      SP[i,P]:=SMat[i,p]*CosT-SMat[i,Q]*SinT;

      SP[i,Q]:=SMat[i,p]*SinT+SMat[i,Q]*CosT;

    end;

    CC:=sqr(CosT); SS:=sqr(SinT); SC:=SinT*CosT;

    BMat[P,P]:=AMat[P,P]*CC+AMat[Q,Q]*SS-2*AMAt[P,Q]*SC;

    BMat[Q,Q]:=AMat[P,P]*SS+AMat[Q,Q]*CC+2*AMAt[P,Q]*SC;

    BMat[P,Q]:=(AMat[P,P]-AMat[Q,Q])*SC+AMat[P,Q]*(CC-SS);

    BMat[Q,P]:=BMat[P,Q];

    for i:=1 to DimenMat do

    begin

      AMat[i,P]:=BMat[i,P];

      AMat[i,Q]:=BMat[i,Q];

      SMat[i,P]:=SP[i,P];

      SMat[i,Q]:=SP[i,Q];

    end;

    for i:=1 to DimenMat do

    begin

      AMat[P,i]:=BMat[i,P];

      AMat[Q,i]:=BMat[i,Q];

    end;

  end;



  procedure ClcNU; { Racine de la somme des termes non diagonaux }

  var S2     : Float;

      i,j    : Integer;

  begin

    S2:=0;

    for i:=1 to DimenMat-1 do

      for j:=i+1 to DimenMat do

        S2:=S2+AMat[i,j]*AMat[i,j];

    NU:=sqrt(S2*2);

    Indicat:=0;

  end;



  procedure AXI; { On passe en coordonn_es inverses sur z }

  var i,j : Integer;

  begin

    {$IFNDEF OPE }

    WriteMat('SMat =', SMat);

    {$ENDIF}

    for i:=1 to DimenMat do

      for j:=1 to DimenMat do

        SI[i,j] := SMat[i,j];

    for i:=1 to DimenMat do

      SI[DimenMat,i]:=-SMat[DimenMat,i];

    {$IFNDEF OPE }

    WriteMat('SI =', SI);

    {$ENDIF}

  end;



  procedure CLASNBD(V:TNvector; var W:TNvector; var INDCL:VCTI);

  var Max:Float;

      i,j,iMax:Integer;

  begin

    for i:=1 to DimenMat do begin

      W[i]:=V[i]; INDCL[i]:=i;

    end;

    for i:=1 to DimenMat-1 do

    begin

      Max:=W[i];

      for j:=i+1 to DimenMat do

      begin

        if W[j]>Max then

        begin

          Max:=W[j]; IMax:=INDCL[j];

          W[j]:=W[i]; INDCL[j]:=INDCL[i];

          W[i]:=MAx;  INDCL[i]:=IMax;

        end;

      end;

    end;

  end;



  procedure CLASAX; { Classe les colonnes par ordre de grandeur de AMat[i,i] }

  var V,W:TNvector;

        i,j:Integer;

  begin

    for i:=1 to DimenMat do

      V[i]:=AMat[i,i];

    {$IFNDEF OPE }

    WriteVect('EigenValues =', V);

    {$ENDIF}

    CLASNBD(V,W,Colind);

    for i:=1 to DimenMat do

      for j:=1 to DimenMat do

        SCI[i,j]:=SI[i, Colind[j]];

    {$IFNDEF OPE }

    WriteMat('SCI =', SCI);

    {$ENDIF}

  end;



  procedure NMORAXE;

  var i,j,l,p:Integer;

  begin

    for j:=1 to DimenMat do

    begin

      for i:=1 to DimenMat do

      begin

        VCI[i]:=SCI[i,j]; VCIA[i]:=Abs(VCI[i]);

      end;

      CLASNBD(VCIA, WCIR, AXIND);

      l:=AXIND[1];

      if SCI[l,j]>0 then

        for p:=1 to DimenMat do

          SCRI[p,j]:=SCI[p,j]

      else

        for p:=1 to DimenMat do

          SCRI[p,j]:=-SCI[p,j];

    end;

    {$IFNDEF OPE }

    WriteMat('SCRI =', SCRI);

    {$ENDIF}

  end;



  procedure Creat;

  begin

    TSCRI:=SCRI;

{    TransposeMat(DimenMat, TSCRI); }

    EigenVectors:=TSCRI;

    {$IFNDEF OPE }

    WriteMat('EigenVector =', TSCRI);

    {$ENDIF}

  end;



  procedure NPoint;

  begin

    AXI;

    CLASAX;

    NMORAXE;

    CREAT;

  end;



begin { Calcn }

  Initial(DimenMat, SMat);

  CMaTA0D; ClcNU; Nu:=Nu/DimenMat;

  QX:=2; P:=1; Q:=2;

  While NU>Precis do

  begin

    While P<=(DimenMat-1) do

    begin

      While QX<=DimenMat do

      begin

        Q:=QX;

        if Abs(AMat[P,Q])>=NU then

        begin

          Indicat:=1;

          Trigo; ClCas;

        end;

        QX:=QX+1;

      end;

      P:=P+1; QX:=P+1;

    end;

    NU:=NU/DimenMat; QX:=2; P:=1;

  end;

  NPoint;

end; { Calcn }





{ Calcule la surface de l'ombre d'un objet projet_ sur l'_cran }

function SurfaceOmbre(var Mat:TNMatrix; var Points:_TabPVal; Modulo, OffsetS, Count:Integer):float;

const Org = 0;

var  i,index: integer;

     VA,VB,VC      : P_TabVal;

     A11,A12,A13,

     A21,A22,A23,

     A31,A32,A33,

     x1, x2,

     y1, y2,

     A,B,C,

     Res : Float;

   { Surface du triangle }

   function S:Float;

   begin

    A  := x2*y2;

    B  := x1*y1;

    C  := (y1-y2)*(x2-x1);

    S  := (y1*x2 - (A + B + C) / 2);

   end;

begin

  Res := 0; 

  A11:=Mat[1,1]; A12:=Mat[1,2]; A13:=Mat[1,3];

  A21:=Mat[2,1]; A22:=Mat[2,2]; A23:=Mat[2,3];

  A31:=Mat[3,1]; A32:=Mat[3,2]; A33:=Mat[3,3];



    { Rep_re les 3 vecteurs _ d_placer }

  VA:=Points[1];            { x }

  VB:=Points[2];            { y }

  VC:=Points[3];            { z }



  { Change les vecteurs  }

  for index := OffsetS to (Count+OffsetS) do

   begin

      i := Index mod Modulo;

      A:= VA^[i]; B:= VB^[i]; C:=VC^[i];

      x2:=   x1;

      y2:=   y1;

      x1:=   (A*A11 + B*A12 + C*A13);

      y1:=   (A*A21 + B*A22 + C*A23);

      if index>OffsetS then

        Res := Res +  S ;

   end;

  { 5 ÝV/Bit }

  SurfaceOmbre := Abs(Res)*CoefSurface;

end;





begin

  MathError;

end.



 