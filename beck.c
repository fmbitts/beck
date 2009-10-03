#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#define BECK_VERSION "0.0.1"
#define	EXIT_FAILURE  1
#define	EXIT_SUCCESS  0

struct metalProperties {
  float Ks,  // Solid thermal conductivity
        Kl,  // Liquid thermal conductivity
        Cs,  // Solid specific heat capacity
        Cl,  // Liquid specific heat capacity
        Ds,  // Solid density
        Dl,  // Liquid density
        Pc,  // Partition coefficient
        Ts,  // Solid temperature
        Tl,  // Liquid temperature
        Tm;  // Melting temperature
  };
struct moldProperties{
  int   Smc; // Staiblity modulus criteria
  float Td,  // Thermal diffusivity
        Tc,  // thermal conductivity
        Cs,  // specific heat capacity
        D;   // Density
  };

/* Porting ruby hashes to C structs
struct iron {'modulo_criterio_estabilidade' => 4,
             'difusividade_termica' => 5.87e-6,
             'condutividade_termica' => 30, 
             'calor_especifico' => 700, 
             'densidade' => 7300}			
struct aluminum {'condutividade_termica_solido' => 213.0,
                 'condutividade_termica_liquido' => 91.0, 
                 'calor_especifico_solido' => 1181.0,\
                 'calor_especifico_liquido' => 1086.0,
                 'densidade_solido' => 2550.0,
                 'densidade_liquido' => 2368.0,
                 'temperatura_solidus' => 548.0, 
                 'temperatura_liquidus' => 645.0, \
                 'coeficiente_particao' => 0.17,
                 'temperatura_fusao' => 660.0}
*/

int quiet;

void usage(void);
void printversion(void);
void flush_in();
void *mallocX (unsigned int nbytes);
void *reallocX (void *ptr, unsigned int nbytes);

void getFracPart(float *fs, float *dfs, float temp, \
                 struct metalProperties metal);
void showProperties(float temp, struct metalProperties *metal);

int main(int argc, char *argv[]){
  FILE *propsFile;
  int metalNodes = 0, moldNodes = 0, nodes = 0, i;
  float *vecTemp;
  char *filename = 0, *arg;
  struct metalProperties metal;

  // Parse Command Line
  for (i=1; i<argc; i++) {
    arg = argv[i];

    if (*arg=='-') {
      switch (arg[1]) {
      case 'm':
        if (argc > (i+1)) {
  	  metalNodes = atoi(argv[i+1]);
	  i++;
        }
      break;
      case 'M':
        if (argc > (i+1)) {
  	  moldNodes = atoi(argv[i+1]);
	  i++;
        }
      break;
      case 'f':
        if (argc > (i+1)) {
  	  filename = argv[i+1];
	  i++;
        }
      break;
      case 'h':
        usage();
	exit(EXIT_SUCCESS);
      break;
      case 'q' :
        quiet = 1;
      break;
      case 'v' :
        printversion();
	exit(EXIT_SUCCESS);
      break;
      default:
        usage();
	exit(EXIT_SUCCESS);
      break;
      }
    }
  }
/*   if (filename){ */
/*     if (!quiet) printf("\nOpening %s\n", filename); */
/*     if ( (propsFile=fopen(filename, "r")) == NULL){ */
/*       printf("Warning: Can\'t open file %s\n",filename); */
/*       printf("Waiting data from standart input.\n"); */
/*       propsFile = stdin; */
/*     } */
/*   } */
/*   else */
/*     propsFile = stdin; */
/*   if (!fscanf(propsFile, "%d\n", &moldNodes)){ */
/*     fprintf(stderr, "Error: reading data!\n"); */
/* #ifdef WIN32 */
/*     system("pause"); */
/* #endif */
/*     return EXIT_FAILURE; */
/*   } */
/*   if (!fscanf(propsFile, "%d\n", &metalNodes)){ */
/*     fprintf(stderr, "Error: reading data!\n"); */
/* #ifdef WIN32 */
/*     system("pause"); */
/* #endif */
/*     return EXIT_FAILURE; */
/*   } */

  nodes = metalNodes + moldNodes;
  vecTemp  = (float*)  mallocX(nodes * sizeof(float));

  i = 0; 
  for (i=0;i<nodes;i++){
    if (!quiet)
      printf("Temperature on node %d: %1.2f degrees\n", i, vecTemp[i]);
  }
  metal.Ks = 213;  // Solid thermal conductivity
  metal.Kl = 91;   // Liquid thermal conductivity
  metal.Cs = 1181; // Solid specific heat capacity
  metal.Cl = 1086; // Liquid specific heat capacity
  metal.Ds = 2550; // Solid density
  metal.Dl = 2368; // Liquid density
  metal.Ts = 548;  // Solid temperature
  metal.Tl = 645;  // Liquid temperature
  metal.Pc = 0.17; // Partition coefficient
  metal.Tm = 660;  // Melting temperature
  if (!quiet){
    printf("Melting temperature:  %1.4f degrees\n", metal.Tm);	
    printf("Liquid temperature:   %1.4f degrees\n", metal.Tl);
  }

  showProperties(600, &metal);
  free(vecTemp);

  if (!quiet) printf("\nBeck finished successfully!!\n");
  if (!quiet) printf("\n");

#ifdef WIN32
    system("pause");
#endif
  return EXIT_SUCCESS;
}

void getFracPart(float *fs, float *dfs,float temp, \
                 struct metalProperties metal){
  float a, b, c;
  a = ( (metal.Tm - temp) / (metal.Tm - metal.Tl) );
  if (!quiet) printf("a:  %1.4f \n", a);
  b = 1 / (metal.Pc -1);
  if (!quiet) printf("b: %1.4f \n", b);
  c = 1 /(metal.Tm - metal.Tl);
  if (!quiet) printf("c: %1.4f \n", c);
  *fs = 1 - ( powf(a,b) );
  *dfs = powf(a,b);
}

void showProperties(float temp, struct metalProperties *metal){
  float fs = 0;
  float dfs = 0;
  getFracPart(&fs, &dfs, temp, *metal);
  if (!quiet){
    printf("temp: %1.4f \n",temp);	
    printf("fs:  %1.4f \n",fs);
    printf("dfs: %1.4f  \n",dfs);
  }
}

void usage(void) {
  fprintf(stderr, "\nbeck - Fernando Bittencourt <fmbitts@gmail.com>\n");
  fprintf(stderr, "       Filipi Vianna <fvianna@gmail.com>\n  ");
  fprintf(stderr, "     http://github.com/fmbitts/beck\n\n");
  fprintf(stderr, "beck <options>\n");
  fprintf(stderr, "Options:\n");
  fprintf(stderr, "    -m nodes\tAmount of nodes on the metal\n");
  fprintf(stderr, "    -M nodes\tAmount of nodes on the mold\n");
  fprintf(stderr, "    -f filname\tMetal or alloy properties file.\n");
  fprintf(stderr, "    -v\t\tShow version.\n");
  fprintf(stderr, "    -q\t\tquiet.\n");
  fprintf(stderr, "    -h\t\tShow this help message.\n");
  fprintf(stderr, "\n");
}

void printversion(void) {
  fprintf(stderr, "%s\n", BECK_VERSION);
}

void flush_in(){
  unsigned int ch;
  while( (ch = fgetc(stdin)) != EOF && ch != '\n' ){}
}

void *mallocX (unsigned int nbytes){
  void *ptr;
  ptr = malloc (nbytes);
  if (ptr == NULL) {
    fprintf (stderr, "Error allocating memory - malloc returned NULL!\n");
#ifdef WIN32
    system("pause");
#endif
    exit (EXIT_FAILURE);
  }
  return ptr;
}

void *reallocX (void *ptr, unsigned int nbytes){
  ptr = realloc (ptr, nbytes);
  if (ptr == NULL) {
    fprintf (stderr, "Error reallocating memory - realloc returned NULL!\n");
#ifdef WIN32
    system("pause");
#endif
    exit (EXIT_FAILURE);
  }
  return ptr;
}
