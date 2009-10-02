#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#define CHECKER_VERSION "$Id: beck.c,v 1.12 2009/09/09 21:31:42 filipi Exp $"
#define	EXIT_FAILURE  1
#define	EXIT_SUCCESS  0
//Metal properties
static float Ks=213;  // condutividade termica do solido
static float Kl=91;   // condutividade termica do liquido
static float Cs=1181; // calor especifico solido
static float Cl=1086; //calor especifico liquido
static float Ds=2550; // densidade solido
static float Dl=2368; //densidade loquido
static float Ts=548;  //temperatura solidus
static float Tl=645;  //temperatura liquidus
static float Cp=0.17; //coeficiente de particao
static float TF=660;  //temperatura fusao

//
struct tmap {
  int col, line, val, top, bottom;
  unsigned char busy;
  } *map;

unsigned char locateVal(int value, int count, int *col, int *line, int *index,\
                        struct tmap *map);
unsigned char locateXY(int col, int line, int count, int *val, int *index, \
                       struct tmap *map);
int maxDepth(struct tmap *map, int count);

int quiet;
//

void usage(void);
void printversion(void);
void flush_in();
void *mallocX (unsigned int nbytes);
void *reallocX (void *ptr, unsigned int nbytes);
void frac_part(float *fs, float *dfs,float temp);
void properties(float temp);


int main(int argc, char *argv[]){
  int col = 0, line = 0;
  int lastLine = 0, lastColumn = 0, *index;
  char *arg, disableEqualTest = 0;

  int count, i,left, right, *vecleft, *vecright, val;
  int j, k;
  char oper, *vecoper;

  ///////////
  FILE *propsFile;
  int metalNodes = 0, moldNodes = 0, nodes = 0;
  float *vecTemp;
  char *filename = 0;

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
    if (!quiet) printf("Temperature on node %d: %1.2f\n", i, vecTemp[i]);
  }
  if (!quiet){
    printf("Tf:  %1.4f \n",TF);	
    printf("Tl:  %1.4f \n",Tl);
  }
  properties(600);
  free(vecTemp);

  if (!quiet) printf("\nBeck finished successfully!!\n");
  if (!quiet) printf("\n");

#ifdef WIN32
    system("pause");
#endif
  return EXIT_SUCCESS;
}

unsigned char locateVal(int value, int count, int *col, int *line, \
                        int *index, struct tmap *map){
  int i = 0,  j = 0;
  unsigned char success = 0;
  while( (i<count) && (success==0) ){
    if (map[i].val == value){
      *col = map[i].col;
      *line = map[i].line;
      success = 1;
      j = i;
    }
    i++;
  }
  *index = j;
  return success;
}

unsigned char locateXY(int col, int line, int count, int *val, \
                       int *index, struct tmap *map){
  int i = 0, j = 0;
  unsigned char success = 0;
  while( (i<count) && (success==0) ){
    if ( (map[i].col == col) && (map[i].line == line && (map[i].val != 0) ) ){
      *val = map[i].val;
      j = i;
      success = 1;
    }
    i++;
  }
  *index = j;
  return success;
}

int maxDepth(struct tmap *map, int count){
  int i = 0, iniDepth = 0;
  while( (i<2*count) && (map[i].val!=0) ){
    if (map[i].line > iniDepth){ 
      iniDepth = map[i].line;
    }
    i++;
  }
  return iniDepth;
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
  fprintf(stderr, "%s\n", CHECKER_VERSION);
}

void flush_in(){
  unsigned int ch;
  while( (ch = fgetc(stdin)) != EOF && ch != '\n' ){}
}

void *mallocX (unsigned int nbytes){
  void *ptr;
  ptr = malloc (nbytes);
  if (ptr == NULL) {
    printf ("Error allocating memory - malloc returned NULL!\n");
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
    printf ("Error reallocating memory - realloc returned NULL!\n");
#ifdef WIN32
    system("pause");
#endif
    exit (EXIT_FAILURE);
  }
  return ptr;
}

void frac_part(float *fs, float *dfs,float temp){	
  float a, b, c;
  a = ((TF - temp) / (TF -Tl));
  if (!quiet) printf("a:  %1.4f \n", a);	
  b = 1 / (Cp -1);
  if (!quiet) printf("b: %1.4f \n", b);
  c = 1 /(TF - Tl);
  if (!quiet) printf("c: %1.4f \n", c);
  *fs = 1 - (powf(a,b));
  *dfs = powf(a,b);
}

void properties(float temp){
  float fs = 0;
  float dfs = 0;
  frac_part(&fs, &dfs, temp);
  if (!quiet){
    printf("temp: %1.4f \n",temp);	
    printf("fs:  %1.4f \n",fs);
    printf("dfs: %1.4f  \n",dfs);
  }
}

	
