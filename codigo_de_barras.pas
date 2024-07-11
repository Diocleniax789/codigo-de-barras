PROGRAM codigos_de_barras;
USES crt;

CONST
     ULTIMA_POSICION_X = 4;

TYPE
    importe = array [1..4]of string;
VAR
   imp: importe;

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


FUNCTION valida_importe(): integer;
VAR
 i: integer;
 digito: string;
 BEGIN
 writeln('>>> Ingrese importe <unicamente de 4 digitos>: ');
 writeln('-----------------------------------------------');
 digito:= readkey;
 i:= 0;
 WHILE digito <> #13 DO
  BEGIN
  IF digito <> #8 THEN
   BEGIN
   gotoxy(whereX,whereY);
   IF (whereX <= ULTIMA_POSICION_X)  THEN
    BEGIN
    write(digito);
    i:= i + 1;
    imp[i]:= digito;
    END;
   END
  ELSE
   BEGIN
   gotoxy(whereX - 1,whereY);
   write(' ',#8);
   imp[i]:=' ';
   IF (i >= 1) AND (i <= ULTIMA_POSICION_X) THEN
    i:= i - 1
    ELSE
    i:= 0;
   END;
  digito:= readkey;
  END;




 END;


PROCEDURE genera_codigo_de_barras;
VAR
 codigo_empresa: integer;
 opcion: string;
 BEGIN
 REPEAT
 writeln();
 codigo_empresa:= valida_codigo_de_empresa;
 writeln();
 valida_importe;

   IF SizeOf(imp) < 3 THEN
   writeln('es chico');

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
