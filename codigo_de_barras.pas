PROGRAM codigos_de_barras;
USES crt;

CONST
     ULTIMA_POSICION_X = 4;

TYPE
    importe = array [1..4]of string;
VAR
   imp: importe;

PROCEDURE inicializar_arreglo_importe;
VAR
 f:integer;
 BEGIN
 FOR f:= 1 TO ULTIMA_POSICION_X DO
  BEGIN
  imp[f]:=' ';
  END;
 END;

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

FUNCTION valida_importe(): string;
VAR
 i,f,tamanio_cadena: integer;
 digito,importe_a_string,importe_a_string_completo,aux: string;
 BEGIN
 REPEAT
 textcolor(white);
 inicializar_arreglo_importe;
 writeln('>>> Ingrese importe <unicamente de 4 digitos>: ');
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
  aux:= ' ';
  FOR f:= 1 TO 4 DO
   BEGIN
   IF imp[f] <> ' ' THEN
    BEGIN
     IF aux = ' ' THEN
      BEGIN
      importe_a_string:= imp[f];
      aux:= importe_a_string;
      END
     ELSE
      BEGIN
      importe_a_string:= imp[f];
      importe_a_string_completo:= concat(aux,importe_a_string);
      aux:= importe_a_string_completo;
      END;
     END;
   END;
  writeln();
  tamanio_cadena:= Length(aux);
  IF (tamanio_cadena <= 3) THEN
   BEGIN
   textcolor(lightred);
   writeln();
   writeln('========================================================');
   writeln('X SE DEBEN INGRESAR CUATRO DIGITOS. INTENTE NUEVAMENTE X');
   writeln('========================================================');
   writeln();
   END;
  UNTIL (tamanio_cadena = 4);
  valida_importe:= aux;
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
 valida_importe();
 writeln('validado');

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
