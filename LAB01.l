%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

#define MAX_IDS 1000  


char* ids[MAX_IDS]; 
char salida[10000] = "";  
int errores = 0;
int numIdentificadores = 0;

void listaids(const char* elemento) {
    int posicion = 0;
    int encontrado = false;

    // Buscamos el elemento en la lista de ids
    for (int i = 0; i < MAX_IDS && ids[i] != NULL; i++) {
        if (strcmp(ids[i], elemento) == 0) {
            sprintf(salida + strlen(salida), " id%d=%s,", i + 1, elemento);
            encontrado = true;
            break;
            
        }
        posicion++;

       
        
    }

    if (!encontrado) {
        sprintf(salida + strlen(salida), " id%d=%s,", posicion + 1, elemento);
        
        // Insertamos el nuevo elemento en la lista de ids
        for (int i = MAX_IDS - 1; i > posicion; i--) {
            ids[i] = ids[i - 1];
        }
        ids[posicion] = strdup(elemento);
        numIdentificadores++;
    }

    
}


%}

%option noyywrap
ESP " "+
DIGITO [0-9]
LETRA [a-zA-ZáéíóúÁÉÍÓÚñÑ]
CTE-ENT (\-{DIGITO}+)|{DIGITO}+
CTE-REAL (\-{DIGITO}*\.{DIGITO}+|{DIGITO}*\.{DIGITO}e[\+\-]{DIGITO}*)|{DIGITO}*\.{DIGITO}+|{DIGITO}*\.{DIGITO}e[\+\-]{DIGITO}*
CTE-CADENA \'({LETRA}|{DIGITO})*\'|\"({LETRA}|{DIGITO})*\"|\`({LETRA}|{DIGITO})*\`
VARIABLE {LETRA}({LETRA}|{DIGITO})*
OP-MULT "*"
OP-SUM "+"
OP-SUST "-"
OP-DIV "/"
OP-ASIGN "="
OP-MOD "%"
OP-MASMAS "++"
OP-MENOSMENOS "--"
OP-SUMASIG "+="
OP-SUSTASIG "-="
OP-PORASIG "*="
OP-DIVASIG "/="
LLAVE-A "{"
LLAVE-C "}"
PARENT-A "("
PARENT-C ")"
CORCHETE-A "["
CORCHETE-C "]"
PUNTO-COMA ";"
MAYOR-IGUAL ">="
MENOR-IGUAL "<="
MAYOR ">"
MENOR "<"
IGUAL "=="
DIFERENTE "!="|"<>"
OP-Y "&&"
OP-O "||"
OP-NO "!"
COMENTARIO_LINEA "//"(.)*[\r\n]
COMENTARIO_BLOQUE \/\*([^*]|(\*+[^*/]))*\*+\/


%%
{ESP} {}
\n {(sprintf(salida + strlen(salida), "\n"));}
\r {}
"if" {(sprintf(salida + strlen(salida), " %s", "IF"));}
"else" {sprintf(salida + strlen(salida), " %s", "ELSE");}
"for" {sprintf(salida + strlen(salida), " %s", "FOR");}
"while" {sprintf(salida + strlen(salida), " %s", "WHILE");}
"double" {sprintf(salida + strlen(salida), " %s", "DOUBLE");}
"int" {sprintf(salida + strlen(salida), " %s", "INT");}
"String" {sprintf(salida + strlen(salida), " %s", "STRING");}
"char" {sprintf(salida + strlen(salida), " %s", "CHAR");}
"new" {sprintf(salida + strlen(salida), " %s", "NEW");}
"public" {sprintf(salida + strlen(salida), " %s", "PUBLIC");}
"class" {sprintf(salida + strlen(salida), " %s", "CLASS");}
"static" {sprintf(salida + strlen(salida), " %s", "STATIC");}
"void" {sprintf(salida + strlen(salida), " %s", "VOID");}
{CTE-ENT} {sprintf(salida + strlen(salida), " Cte-ent=%s,", yytext);}
{CTE-REAL} {sprintf(salida + strlen(salida), " Cte-real=%s,", yytext);}
{CTE-CADENA} {sprintf(salida + strlen(salida), " Cte-cadena=%s,", yytext);}
{VARIABLE} {listaids(yytext);}
{OP-MULT} {sprintf(salida + strlen(salida), " Op-mult=%s,", yytext);}
{OP-SUM} {sprintf(salida + strlen(salida), " Op-sum=%s,", yytext);}
{OP-SUST} {sprintf(salida + strlen(salida), " Op-sust=%s,", yytext);}
{OP-DIV} {sprintf(salida + strlen(salida), " Op-div=%s,", yytext);}
{OP-ASIGN} {sprintf(salida + strlen(salida), " Op-asign=%s,", yytext);}
{OP-MOD} {sprintf(salida + strlen(salida), " Op-mod=%s,", yytext);}
{OP-MASMAS} {sprintf(salida + strlen(salida), " Op-MasMas=%s,", yytext);}
{OP-MENOSMENOS} {sprintf(salida + strlen(salida), "Op-MenosMenos=%s,", yytext);}
{OP-SUMASIG} {sprintf(salida + strlen(salida), " Op-SumAsig=%s,", yytext);}
{OP-SUSTASIG} {sprintf(salida + strlen(salida), " Op-SustAsig=%s,", yytext);}
{OP-PORASIG} {sprintf(salida + strlen(salida), " Op-PorAsig=%s,", yytext);}
{OP-DIVASIG} {sprintf(salida + strlen(salida), " Op-DivAsig=%s,", yytext);}
{LLAVE-A} {sprintf(salida + strlen(salida), " Llave-a=%s", yytext);}
{LLAVE-C} {sprintf(salida + strlen(salida), " Llave-c=%s", yytext);}
{PARENT-A} {sprintf(salida + strlen(salida), " Parent-a=%s,", yytext);}
{PARENT-C} {sprintf(salida + strlen(salida), " Parent-c=%s,", yytext);}
{CORCHETE-A} {sprintf(salida + strlen(salida), " Corchete-a=%s,", yytext);}
{CORCHETE-C} {sprintf(salida + strlen(salida), " Corchete-c=%s,", yytext);}
{PUNTO-COMA} {sprintf(salida + strlen(salida), " Punto-coma=%s", yytext);}
{MAYOR-IGUAL} {sprintf(salida + strlen(salida), " Op-MayorIgual=%s,", yytext);}
{MENOR-IGUAL} {sprintf(salida + strlen(salida), " Op-MenorIgual=%s,", yytext);}
{MAYOR} {sprintf(salida + strlen(salida), " Op-mayor=%s,", yytext);}
{MENOR} {sprintf(salida + strlen(salida), " Op-menor=%s,", yytext);}
{IGUAL} {sprintf(salida + strlen(salida), " Op-igual=%s,", yytext);}
{DIFERENTE} {sprintf(salida + strlen(salida), " Op-dif=%s,", yytext);}
{OP-Y} {sprintf(salida + strlen(salida), " Op-y=%s,", yytext);}
{OP-O} {sprintf(salida + strlen(salida), " Op-o=%s,", yytext);}
{OP-NO} {sprintf(salida + strlen(salida), " Op-no=%s,", yytext);}
{COMENTARIO_LINEA} {sprintf(salida + strlen(salida), " Comentario=%s", yytext);}
{COMENTARIO_BLOQUE} {sprintf(salida + strlen(salida), " Comentario=%s", yytext);}
[^ \t\n\r0-9a-zA-ZáéíóúÁÉÍÓÚñÑ\+\-\*\=\/\%\>\<\!\&\|\(\)\{\}\[\];\'\"\`]+ {sprintf(salida + strlen(salida), " ERROR=%s,", yytext); errores++;} 
{DIGITO}({LETRA}|{DIGITO})* {sprintf(salida + strlen(salida), " ERROR=%s,", yytext); errores++;} 

%%

int main(int argc, char* argv[]) {

    char* nombreArchivoEntrada;
    char* nombreArchivoSalida = NULL;
   

    if (argc == 2) {
        nombreArchivoEntrada = argv[1];
    } else if (argc == 3) {
        nombreArchivoEntrada = argv[1];
        nombreArchivoSalida = argv[2];
    } else {
        fprintf(stderr, "Por favor ingrese un nombre de archivo de entrada y un nombre de archivo de salida.\n");
        return 1;
    }

    FILE* archivo = fopen(nombreArchivoEntrada, "r");
    if (archivo == NULL) {
        fprintf(stderr, "No se pudo abrir el archivo %s.\n", nombreArchivoEntrada);
        return 1;
    }

    char input[1024];
    input[0] = '\0';
    char linea[1024];

    while (fgets(linea, sizeof(linea), archivo) != NULL) {
        strcat(input, linea);
    }

    fclose(archivo);
    yy_scan_string(input); 
    yylex();
   
    sprintf(salida + strlen(salida), "\n");
    sprintf(salida + strlen(salida), "\nTABLA DE IDENTIFICADORES:");
    sprintf(salida + strlen(salida), "\n%d Identificadores\n", numIdentificadores);
    for (int i = 0; i < MAX_IDS && ids[i] != NULL; i++) {
        sprintf(salida + strlen(salida), "id%d=%s\n", i + 1, ids[i]);
    }

    sprintf(salida + strlen(salida), "\n%d errores léxicos", errores);

    if (nombreArchivoSalida == NULL) {
        printf("%s\n", salida);
    } else {
        FILE* archivoSalida = fopen(nombreArchivoSalida, "w");
        if (archivoSalida == NULL) {
            fprintf(stderr, "No se pudo abrir o crear el archivo de salida %s.\n", nombreArchivoSalida);
            return 1;
        }
        fwrite(salida, sizeof(char), strlen(salida), archivoSalida);
        fclose(archivoSalida);
        printf("Archivo creado con éxito...\n");
    }

    return 0;
}