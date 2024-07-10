PROGRAM codigos_de_barras;
USES crt;

VAR
   codigo_empresa: integer;

FUNCTION valida_codigo_de_empresa(): integer;
VAR
  cod_empre: integer;
  BEGIN
  REPEAT
  textcolor(white);
  write('>>> Ingrese codigo de empresa <unicamente de tres digitos>: ');
  readln(cod_empre);
  IF (cod_empre < 100) OR (cod_empre > 999) THEN
   BEGIN
   textcolor(lightred);
   writeln();
   writeln('==========================================================');
   writeln('X POR FAVOR. INGRESE UN NUMERO DE TRES CIFRAS NUEVAMENTE X');
   writeln('==========================================================');
   writeln();
   END;
  UNTIL (cod_empre >= 100) AND (cod_empre <= 999);
  valida_codigo_de_empresa:= cod_empre;
  END;

{
FUNCTION valida_importe(): integer;
VAR
 imp: integer;
 BEGIN
 write('>>> Ingrese importe <unicamente de 4 digitos>: ');
 readln(imp);
 IF (imp < 1000) AND ()
 END;
                      }

PROCEDURE genera_codigo_de_barras;
VAR
 codigo_empresa: integer;
 opcion: string;
 BEGIN
 REPEAT
 writeln();
 codigo_empresa:= valida_codigo_de_empresa;
 {importe:= valida_importe;  }

 REPEAT
 writeln();
 write('Desea ingresar otro codigo de empresa[s/n]?: ');
 readln(opcion);
 IF (opcion <> 's') AND (opcion <> 'n') THEN
  BEGIN
  textcolor(lightred);
  writeln();
  writeln('====================================');
  writeln('VALOR INCORRECTO. INGRESE NUEVAMENTE');
  writeln('====================================');
  writeln();
  END;
 UNTIL (opcion = 's') OR (opcion = 'n');
 UNTIL (opcion = 'n');
 END;

PROCEDURE menu_principal;
VAR
 opcion: integer;
 BEGIN
 REPEAT
 writeln('1. Generar codigo de barras');
 writeln('2. Salir');
 writeln();
 write('Seleccione opcion: ');
 readln(opcion);
 CASE opcion OF
      1:BEGIN
        clrscr;
        genera_codigo_de_barras;
        END;
 END;
 UNTIL (opcion = 2);
 END;

BEGIN
menu_principal;
END.
