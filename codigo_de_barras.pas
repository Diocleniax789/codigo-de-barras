PROGRAM codigos_de_barras;
USES crt, SysUtils;

CONST
     ULTIMA_POSICION_X = 4;

TYPE
    importe = array[1..4]of string;
    empresa = array[1..3]of integer;
    empresa_importe = array[1..7]of integer;
    empresa_importe_codigo_verificador = array[1..8]of integer;
    cadena_binaria = array[1..4]of integer;
    cadena_binaria_string = array[1..8]of string;
VAR
   imp: importe;
   emp: empresa;
   emp_imp: empresa_importe;
   emp_imp_cod_verif: empresa_importe_codigo_verificador;
   cad_bin: cadena_binaria;
   cad_bin_string: cadena_binaria_string;

PROCEDURE inicializar_arreglo_importe;
VAR
 f:integer;
 BEGIN
 FOR f:= 1 TO ULTIMA_POSICION_X DO
  BEGIN
  imp[f]:= ' ';
  END;
 END;

PROCEDURE inicializar_arreglo_empresa;
VAR
 f: integer;
 BEGIN
 FOR f:= 1 TO 3 DO
  BEGIN
  emp[f]:= 0;
  END;
 END;

PROCEDURE inicializar_arreglo_empresa_importe;
VAR
 f: integer;
 BEGIN
 FOR f:= 1 TO 3 DO
  BEGIN
  emp_imp[f]:= 0;
  END;
 END;

PROCEDURE incializar_arreglo_empresa_importa_cod_verificacion;
VAR
 f: integer;
 BEGIN
 FOR f:= 1 TO 8 DO
  BEGIN
  emp_imp_cod_verif[f]:= 0;
  END;
 END;

PROCEDURE valida_codigo_de_empresa;
VAR
  f,cod_empre: integer;
  BEGIN
  inicializar_arreglo_empresa;
  FOR f:= 1 TO 3 DO
   BEGIN
    IF f = 1 THEN
    BEGIN
      REPEAT
      textcolor(white);
      write('>>> INGRESE UN PRIMER DIGITO <DE ENTRE 0 Y 9>: ');
      readln(cod_empre);
      IF (cod_empre < 0) OR (cod_empre > 9) THEN
       BEGIN
       textcolor(lightred);
       writeln();
       writeln('=======================================');
       writeln('X FUERA DEL RANGO. INGRESE NUEVAMENTE X');
       writeln('=======================================');
       writeln();
       END;
      UNTIL (cod_empre >= 0) AND (cod_empre <= 9);
      emp[f]:= cod_empre;
    END
  ELSE IF f = 2 THEN
   BEGIN
    REPEAT
    textcolor(white);
    write('>>> INGRESE UN SEGUNDO DIGITO <DE ENTRE 0 Y 9>: ');
    readln(cod_empre);
    IF (cod_empre < 0) OR (cod_empre > 9) THEN
     BEGIN
     textcolor(lightred);
     writeln();
     writeln('=======================================');
     writeln('X FUERA DEL RANGO. INGRESE NUEVAMENTE X');
     writeln('=======================================');
     writeln();
     END;
    UNTIL (cod_empre >= 0) AND (cod_empre <= 9);
    emp[f]:= cod_empre;
   END
  ELSE
   BEGIN
    REPEAT
    textcolor(white);
    write('>>> INGRESE UN PRIMER DIGITO <DE ENTRE 0 Y 9>: ');
    readln(cod_empre);
    IF (cod_empre < 0) OR (cod_empre > 9) THEN
     BEGIN
     textcolor(lightred);
     writeln();
     writeln('=======================================');
     writeln('X FUERA DEL RANGO. INGRESE NUEVAMENTE X');
     writeln('=======================================');
     writeln();
     END;
    UNTIL (cod_empre >= 0) AND (cod_empre <= 9);
    emp[f]:= cod_empre;
   END;
  END;
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

FUNCTION convertir_arreglo_empresa_integer_a_string(): string;
VAR
 aux,integer_to_string,unir_string: string;
 f:integer;
 BEGIN
 inicializar_arreglo_empresa_importe;
 aux:= ' ';
 FOR f:= 1 TO 3 DO
  BEGIN
   IF aux = ' ' THEN
    BEGIN
    integer_to_string:= IntToStr(emp[f]);
    aux:= integer_to_string;
    END
   ELSE
    BEGIN
    integer_to_string:= IntToStr(emp[f]);
    unir_string:= concat(aux,integer_to_string);
    aux:= unir_string;
    END;
  END;
  convertir_arreglo_empresa_integer_a_string:= aux;
 END;

PROCEDURE codigo_completo_string_a_integer(codigo_completo_string: string);
VAR
 f: integer;
 BEGIN
 FOR f:= 1 TO Length(codigo_completo_string) DO
  BEGIN
  emp_imp[f]:= StrToInt(codigo_completo_string[f]);
  END;
 END;

FUNCTION generar_digito_verificador(): integer;
VAR
 f,acumulador_impares,acumulador_pares,digito_verificador,absoluto: integer;
 BEGIN
 acumulador_impares:= 0;
 acumulador_pares:= 0;
 FOR f:= 1 TO 7 DO
  BEGIN
  IF  (f MOD 2) = 0 THEN
   acumulador_pares:= acumulador_pares + emp_imp[f]
  ELSE
   acumulador_impares:= acumulador_impares + emp_imp[f];
  END;
  absoluto:= abs(acumulador_impares + acumulador_pares);
  digito_verificador:=  absoluto  MOD 10;
  generar_digito_verificador:= digito_verificador;
 END;

PROCEDURE crea_codigo_completo(codigo_verificador: integer);
VAR
 k,f,h,n1,n2,n3,n4,n5,n6,n7,n8:integer;
 BEGIN
 FOR f:= 1 TO 7 DO
  BEGIN
  IF f = 1 THEN
   n1:= emp_imp[f]
  ELSE IF f = 2 THEN
   n2:= emp_imp[f]
  ELSE IF f = 3 THEN
   n3:= emp_imp[f]
  ELSE IF f = 4 THEN
   n4:= emp_imp[f]
  ELSE IF f = 5 THEN
   n5:= emp_imp[f]
  ELSE IF f = 6 THEN
   n6:= emp_imp[f]
  ELSE
   n7:= emp_imp[f];
  END;
  n8:= codigo_verificador;
 FOR h:= 1 TO 8 DO
  BEGIN
  IF h = 1 THEN
   emp_imp_cod_verif[h]:= n1
  ELSE IF h = 2 THEN
   emp_imp_cod_verif[h]:= n2
  ELSE IF h = 3 THEN
   emp_imp_cod_verif[h]:= n3
  ELSE IF h = 4 THEN
   emp_imp_cod_verif[h]:= n4
  ELSE IF h = 5 THEN
   emp_imp_cod_verif[h]:= n5
  ELSE IF h = 6 THEN
   emp_imp_cod_verif[h]:= n6
  ELSE IF h = 7 THEN
   emp_imp_cod_verif[h]:= n7
  ELSE
   emp_imp_cod_verif[h]:= n8;
  END;

 writeln('TU CODIGO NUMERICO: ');
 writeln('--------------------');
 FOR k:= 1 TO 8 DO
  BEGIN
   write(emp_imp_cod_verif[k]);
  END;
 writeln();
 END;

FUNCTION convertir_digito_a_binario(digito: integer): string;
VAR
 aux,cadena,cadena_completa: string;
 h,f,exp,base,potencia,resta,digito_aux: integer;
 BEGIN
 exp:= 4;
 base:= 2;
 FOR f:= 1 TO 4 DO
  BEGIN
  exp:= exp - 1;
  potencia:= power(base,exp);
  IF potencia <= digito THEN
   BEGIN
   cad_bin[f]:= 1;
   resta:= digito - potencia;
   IF resta >= 0 THEN
   digito:= resta;
   END
  ELSE
   cad_bin[f]:= 0;
  END;

 aux:= ' ';
 FOR h:= 1 TO 4 DO
  BEGIN
  IF aux = ' ' THEN
   BEGIN
   digito_aux:= cad_bin[h];
   cadena:= IntToStr(digito_aux);
   aux:= cadena;
   END
  ELSE
   BEGIN
   digito_aux:= cad_bin[h];
   cadena:= IntToStr(digito_aux);
   cadena_completa:= concat(aux,cadena);
   aux:= cadena_completa;
   END;
  END;
  convertir_digito_a_binario:= aux;
 END;

FUNCTION verifica_1_0(digito_cadena: string): string;
VAR
 cadena,aux,cadena_parte: string;
 k: integer;
 BEGIN
   aux:= ' ';
   FOR k:= 1 TO Length(digito_cadena) DO
    BEGIN

    IF  aux = ' ' THEN
     BEGIN
      IF digito_cadena[k] = '1' THEN
       BEGIN
       cadena:= '|';
       aux:= cadena;
       END
      ELSE
       BEGIN
       cadena:= '  ';
       aux:= cadena;
       END;
     END
    ELSE
     IF digito_cadena[k] = '1' THEN
       BEGIN
       cadena:= '|';
       cadena_parte:= concat(aux,cadena);
       aux:= cadena_parte;
       END
      ELSE
       BEGIN
       cadena:= '  ';
       cadena_parte:= concat(aux,cadena);
       aux:= cadena_parte;
       END;
   END;
   verifica_1_0:= aux;
  END;


PROCEDURE crear_codigo_de_barras;
VAR
 digitos_binarios,digito_cadena,codigo_barra: string;
 h,f,digito: integer;
 BEGIN
 FOR f:= 1 TO 8 DO
  BEGIN
   digito:= emp_imp_cod_verif[f];
   digitos_binarios:= convertir_digito_a_binario(digito);
   cad_bin_string[f]:= digitos_binarios;
  END;

 FOR h:= 1 TO 8 DO
  BEGIN
  digito_cadena:= cad_bin_string[h];
  codigo_barra:= verifica_1_0(digito_cadena);
  textcolor(green);
  write(codigo_barra);
  END;

 END;

PROCEDURE genera_codigo_de_barras;
VAR
 codigo_verificador: integer;
 opcion,op,codigo_completo_string,importe,codigo_empresa: string;
 BEGIN
 REPEAT
 clrscr;
 incializar_arreglo_empresa_importa_cod_verificacion;
 writeln();
 valida_codigo_de_empresa;
 writeln();
 codigo_empresa:= convertir_arreglo_empresa_integer_a_string;
 REPEAT
 textcolor(white);
 writeln();
 importe:= valida_importe;
 writeln();
 codigo_completo_string:= concat(codigo_empresa,importe);
 codigo_completo_string_a_integer(codigo_completo_string);
 codigo_verificador:= generar_digito_verificador;
 crea_codigo_completo(codigo_verificador);
 writeln();
 crear_codigo_de_barras;
 writeln();
 REPEAT
 textcolor(white);
 writeln();
 writeln('Desea agregar otro codigo[s/n]?: ');
 readln(op);
 IF (op <> 's') AND (op <> 'n') THEN
  BEGIN
  textcolor(lightred);
  writeln();
  writeln('========================================');
  writeln('X VALOR INCORRECTO. INGRESE NUEVAMENTE X');
  writeln('========================================');
  writeln();
  END;
 UNTIL (op = 's') OR (op = 'n');
 UNTIL (op = 'n');


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
