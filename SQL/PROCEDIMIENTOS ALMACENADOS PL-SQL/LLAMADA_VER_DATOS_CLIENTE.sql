set SERVEROUTPUT on
DECLARE 
    V_IDCLIENTE clientes.idcliente%type;

BEGIN
    V_IDCLIENTE :=&identificativo_del_cliente;
    ver_datos_cliente(V_IDCLIENTE);
END;