CLAUSULAS Y OPERADORES

CLAUSULAS
from
Especifica la tabla de la que se quieren obtener registros
where
Especifica las condiciones y criterios de los registros seleccionados
group by
Para agrupar los registros seleccionados en funcion de un campo
having
Especifica las condiciones y criterios que deben cumplir los grupos 
order by
Ordena los registros seleccionados en funcion de un campo

OPERADORES
between
utilizado para especificar rangos de valores 
like 
utilizado con caracteres comodin (? *)
in 
para especificar registros en un campo en concreto
and
Y logico
or
O logico
not
Negacion logico

ORDEN DE ESCRITURA
Comando + from + where + group by + having + order by



EJEMPLOS
SELECT * FROM productos WHERE SECCIÓN="CERÁMICA" OR SECCIÓN="DEPORTES" ORDER BY SECCIÓN, PRECIO DESC

OR PERMITE OBTENER DATOS DE UNA COLUMNA Y OTRA 
ORDER BY ORDENA COLUMNAS, SIQUIERES VARIOS ORDENAMIENTOS A LA VEZ SEPARAR POR COLUMNAS


FUNCIONES DE AGREGADO

AVG CALCULA EL PROMEDIO DE UN CAMPO
COUNT CUENTA LOS REGISTROS DE UN CAMPO
SUM SUMA LOS VALORES DE UN CAMPO
MAX DEVUELVE EL MAXIMO DE UN CAMPO
MIN DEVUELVE EL MINIMO DE UN CAMPO

SELECT SECCIÓN, SUM(PRECIO) FROM productos GROUP BY SECCIÓN
SELECCIONAR CAMPO SECCION SUMADAS POR PRECIO TOTAL POR CAMPO AGRUPADAS POR SECCION

SELECT SECCIÓN, SUM(PRECIO) AS SUMA FROM productos GROUP BY SECCIÓN ORDER BY SUMA
SELECCIONAR CAMPO SECCIÓN SUMADAS POR PRECIO TOTAL CON UN ALIAS "SUMA" EN ORDEN ASCENDENTE

SELECT SECCIÓN, AVG(PRECIO) AS PROMEDIO FROM productos GROUP BY SECCIÓN HAVING SECCIÓN="DEPORTES" OR SECCIÓN="CERÁMICA"
SELECCIONAR CAMPO SECCION POR PROMEDIO DE TOTALES AGRUPADAS POR SECCION OBTENIENDO SOLO DEL CAMPO : DEPORTES Y CERAMICA

SELECT POBLACIÓN, COUNT(CÓDIGOCLIENTE) AS COD FROM clientes GROUP BY POBLACIÓN
CUENTA CUANTOS CLIENTES HAY POR POBLACIÓN

SELECT SECCIÓN, MAX(PRECIO) AS MAXIMO_PRECIO FROM productos WHERE SECCIÓN="CONFECCIÓN" GROUP BY SECCIÓN
MUESTRA POR SECCION EL VALOR MAXIMO DE PRECIO SOLO DE CONFECCION AGRUPADO POR SECCION
NOTA.- SI SE AGREGA UN TERCER CAMPO DE CONSULTA EN EL SELECT MOSTRARA EL PRIMER CAMPO DE LA TERCERA SELECCION QUE NO CORRESPONDERA A LA CONSULTA QUE QUEREMOS REALIZAR 

FUNCIONES DE CALCULO SOBRE CAMPOS INDIVIDUALES

NOW() DIA Y HORA ACTUAL
DATEDIFF() DIFERENCIA ENTRE FECHAS
DATE_FORMAT() FORMATEAR RESULTADOS 
CONCAT() CONCATENAR CADENAS DE TEXTO

Una opción muy simple en MySql para trabajar solo con fechas sin necesidad de tocar formatos, es sustituir NOW() por CURDATE() que nos devuelve solo la fecha. Si queremos solo la hora CURTIME(). Incluso tenemos la función DATE() que nos devuelve solo la fecha de un campo de "fecha" que contenga día y hora

SELECT NOMBREARTÍCULO, SECCIÓN, PRECIO, ROUND(PRECIO*1.18, 2) AS PRECIO_IGV FROM productos
CONSULTA DE PRODUCTOS POR NOMBRE, SECCION Y PRECIO MAS CAMPO AÑADIDO "PRECIO_IGV" CON PRECIO MAS 18% REDONDEADO A DOS DECIMALES

SELECT NOMBREARTÍCULO, SECCIÓN, PRECIO, ROUND(PRECIO-3, 2) AS PRECIO_IGV FROM productos
CONSULTA DE PRODUCTOS POR NOMBRE, SECCION Y PRECIO MAS CAMPO AÑADIDO "PRECIO_IGV" CON PRECIO MENOS 3 UNIDADES AL VALOR DEL PRECIO REDONDEADO A DOS DECIMALES

EJEMPLO
SELECT NOMBREARTÍCULO, SECCIÓN, PRECIO, FECHA, DATE_FORMAT(CURDATE(), '%D-%M') AS DIA_HOY, DATEDIFF(CURDATE(), FECHA) AS DIFERENCIA FROM productos

CONSULTAS MULTITABLA
TIENEN QUE ENCONTRARSE LAS DOS TABLAS DENTRO DE UNA MISMA BASE DE DATOS

UNION EXTERNA
UNION 
UNION ALL 
EXCEPT 
INTERSECT
MINUS

UNION INTERNA
INNER JOIN
LEFT JOIN
RIGHT JOIN

SELECT * FROM productos WHERE SECCIÓN="DEPORTES" UNION SELECT * FROM productosnuevos WHERE SECCIÓN="DEPORTES DE RIESGO"
**.- CON UNION SI HAY DOS REGISTROS IGUALES EN AMBAS TABLAS SOLO MOSTRARA UN SOLO REGISTRO
SELECT * FROM productos WHERE SECCIÓN="DEPORTES" UNION ALL SELECT * FROM productosnuevos WHERE SECCIÓN="DEPORTES DE RIESGO"
**.- CON UNION ALL SI HAY DOS REGISTROS IGUALES EN AMBAS TABLAS MOSTRARA TODOS LOS REGISTROS IGUALES
CONSULTA DE DOS CAMPOS DE DOS TABLAS

EJEMPLO
SELECT * FROM productos WHERE PRECIO > 500 UNION SELECT * FROM productosnuevos WHERE SECCIÓN="DEPORTES DE RIESGO"

Intervalos de Valores (BETWEEN)
Para indicar que deseamos recuperar los registros según el intervalo de valores de un campo emplearemos el operador Between cuya sintaxis es:

    campo [Not] Between valor1 And valor2 (la condición Not es opcional)

En este caso la consulta devolvería los registros que contengan en "campo" un valor incluido en el intervalo valor1, valor2 (ambos inclusive). Si anteponemos la condición Not devolverá aquellos valores no incluidos en el intervalo.

    SELECT * FROM Pedidos WHERE CodPostal Between 28000 And 28999;
    (Devuelve los pedidos realizados en la provincia de Madrid)

    SELECT IIf(CodPostal Between 28000 And 28999, 'Provincial', 'Nacional')
    FROM Editores;
    (Devuelve el valor 'Provincial' si el código postal se encuentra en el intervalo,
    'Nacional' en caso contrario)


El Operador LIKE

Se utiliza para comparar una expresión de cadena con un modelo en una expresión SQL. Su sintaxis es:

    expresión Like modelo

En donde expresión es una cadena modelo o campo contra el que se compara expresión. Se puede utilizar el operador Like para encontrar valores en los campos que coincidan con el modelo especificado. Por modelo puede especificar un valor completo (Ana María), o se pueden utilizar caracteres comodín como los reconocidos por el sistema operativo para encontrar un rango de valores (Like An*).

El operador Like se puede utilizar en una expresión para comparar un valor de un campo con una expresión de cadena. Por ejemplo, si introduce Like C* en una consulta SQL, la consulta devuelve todos los valores de campo que comiencen por la letra C. En una consulta con parámetros, puede hacer que el usuario escriba el modelo que se va a utilizar.

El ejemplo siguiente devuelve los datos que comienzan con la letra P seguido de cualquier letra entre A y F y de tres dígitos:

    Like 'P[A-F]###'

Este ejemplo devuelve los campos cuyo contenido empiece con una letra de la A a la D seguidas de cualquier cadena.

    Like '[A-D]*'

El Operador In


Este operador devuelve aquellos registros cuyo campo indicado coincide con alguno de los en una lista. Su sintaxis es:

    expresión [Not] In(valor1, valor2, . . .)

    SELECT * FROM Pedidos WHERE Provincia In ('Madrid', 'Barcelona', 'Sevilla');

La cláusula WHERE


La cláusula WHERE puede usarse para determinar qué registros de las tablas enumeradas en la cláusula FROM aparecerán en los resultados de la instrucción SELECT. Depués de escribir esta cláusula se deben especificar las condiciones expuestas en los partados 3.1 y 3.2. Si no se emplea esta cláusula, la consulta devolverá todas las filas de la tabla. WHERE es opcional, pero cuando aparece debe ir a continuación de FROM.

    SELECT Apellidos, Salario FROM Empleados WHERE Salario > 21000;

    SELECT Id_Producto, Existencias FROM Productos
    WHERE Existencias <= Nuevo_Pedido;

    SELECT * FROM Pedidos WHERE Fecha_Envio = #5/10/94#;

    SELECT Apellidos, Nombre FROM Empleados WHERE Apellidos = 'King';

    SELECT Apellidos, Nombre FROM Empleados WHERE Apellidos Like 'S*';

    SELECT Apellidos, Salario FROM Empleados WHERE Salario Between 200 And 300;

    SELECT Apellidos, Salario FROM Empl WHERE Apellidos Between 'Lon' And 'Tol';

    SELECT Id_Pedido, Fecha_Pedido FROM Pedidos WHERE Fecha_Pedido
    Between #1-1-94# And  #30-6-94#;

    SELECT Apellidos, Nombre, Ciudad FROM Empleados WHERE Ciudad
    In ('Sevilla', 'Los Angeles', 'Barcelona');


SUBCONSULTAS

SUBCONSULTAS ESCALONADA
	SELECT NOMBREARTÍCULO, SECCIÓN FROM productos WHERE PRECIO > (SELECT AVG(PRECIO) FROM productos)
	MUESTRA PRODUCTOS POR NOMBREARTÍCULO Y SECCION DE TABLA PRODUCTOS DONDE PRECIO ES MAYOR A LA MEDIA DE TODOS LOS PRODUCTOS

SUBCONSULTAS DE LISTA
	SELECT * FROM productos WHERE PRECIO > ANY (SELECT PRECIO FROM productos WHERE SECCIÓN='CERÁMICA')
	SELECT * FROM productos WHERE PRECIO > ALL (SELECT PRECIO FROM productos WHERE SECCIÓN='CERÁMICA')

SUBCONSULTAS CORELACIONADA

EJEMPLO
SELECT NOMBREARTÍCULO, PRECIO FROM PRODUCTOS WHERE CÓDIGOARTÍCULO IN (SELECT CÓDIGOARTÍCULO FROM PRODUCTOSPEDIDOS WHERE UNIDADES>20
MUESTRA ARTICULOS Y PRECIO DE TABLA PRODUCTOS DONDE DE LA TABLA PRODUCTOSPEDIDOS HAYAN ARTICULOS VENDIDOS MAYORES A 20
