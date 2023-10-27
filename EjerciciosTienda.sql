-- EJERCICIO 2

-- 1. Lista el nombre de todos los productos que hay en la tabla producto.
select nombre from tienda.producto;

-- 2. Lista los nombres y los precios de todos los productos de la tabla producto.
select nombre, precio from tienda.producto;

-- 3. Lista todas las columnas de la tabla producto.
select * from tienda.producto;

-- 4. Lista los nombres y los precios de todos los productos de la tabla producto, redondeando
-- el valor del precio.
select nombre, ROUND(precio) from tienda.producto;

-- 5. Lista el código de los fabricantes que tienen productos en la tabla producto.
select codigo_fabricante from tienda.producto;

-- 6. Lista el código de los fabricantes que tienen productos en la tabla producto, sin mostrar
-- los repetidos.
select distinct codigo_fabricante from tienda.producto;

-- 7. Lista los nombres de los fabricantes ordenados de forma ascendente.
select nombre from tienda.producto ORDER BY nombre ASC;

-- 8. Lista los nombres de los productos ordenados en primer lugar por el nombre de forma
-- ascendente y en segundo lugar por el precio de forma descendente.
select nombre, precio from tienda.producto ORDER BY nombre ASC, precio DESC;

-- 9. Devuelve una lista con las 5 primeras filas de la tabla fabricante.
select * from tienda.fabricante LIMIT 5;

-- 10. Lista el nombre y el precio del producto más barato. (Utilice solamente las cláusulas
-- ORDER BY y LIMIT)
select nombre, precio from tienda.producto ORDER BY precio asc LIMIT 1;

-- 11. Lista el nombre y el precio del producto más caro. (Utilice solamente las cláusulas ORDER
-- BY y LIMIT)
select nombre, precio from tienda.producto ORDER BY precio desc LIMIT 1;

-- 12. Lista el nombre de los productos que tienen un precio menor o igual a $120.
select nombre from tienda.producto WHERE precio <= 120;

-- 13. Lista todos los productos que tengan un precio entre $60 y $200. Utilizando el operador
-- BETWEEN.
select * from tienda.producto WHERE precio BETWEEN 60 and 200; 

-- 14. Lista todos los productos donde el código de fabricante sea 1, 3 o 5. Utilizando el operador
-- IN.
select * from tienda.producto WHERE codigo_fabricante IN (1,3,5); 

-- 15. Devuelve una lista con el nombre de todos los productos que contienen la cadena Portátil
-- en el nombre.
select nombre from tienda.producto WHERE nombre LIKE ('%Portátil%');

-- Consultas Multitabla 
-- CON tablas:
select * from tienda.producto;
select * from tienda.fabricante;
 
-- 1. Devuelve una lista con el código del producto, nombre del producto, código del fabricante
-- y nombre del fabricante, de todos los productos de la base de datos.
SELECT 
    p.codigo AS codigo_producto,
    p.nombre AS nombre_producto,
    codigo_fabricante,
    f.nombre AS nombre_fabricante
FROM
    tienda.producto AS p
        INNER JOIN
    tienda.fabricante AS f ON p.codigo = f.codigo;

-- 2. Devuelve una lista con el nombre del producto, precio y nombre de fabricante de todos
-- los productos de la base de datos. Ordene el resultado por el nombre del fabricante, por
-- orden alfabético.
SELECT 
    p.nombre AS nombre_producto,
    p.precio,
    f.nombre AS nombre_fabricante
FROM
    tienda.producto AS p
        INNER JOIN
    tienda.fabricante AS f ON p.codigo = f.codigo
ORDER BY f.nombre ASC;

-- 3. Devuelve el nombre del producto, su precio y el nombre de su fabricante, del producto
-- más barato.
SELECT 
    p.nombre AS nombre_producto,
    p.precio,
    f.nombre AS nombre_fabricante
FROM
    tienda.producto AS p
        INNER JOIN
    tienda.fabricante AS f ON p.codigo = f.codigo
ORDER BY p.precio ASC
LIMIT 1;

-- 4. Devuelve una lista de todos los productos del fabricante Lenovo.
SELECT 
    p.nombre AS nombre_producto,
    p.precio,
    f.nombre AS nombre_fabricante
FROM
    tienda.producto AS p
        INNER JOIN
    tienda.fabricante AS f ON p.codigo = f.codigo
WHERE
    f.nombre = 'Lenovo';

-- 5. Devuelve una lista de todos los productos del fabricante Crucial que tengan un precio
-- mayor que $200.
SELECT 
    p.nombre AS nombre_producto,
    p.precio,
    f.nombre AS nombre_fabricante
FROM
    tienda.producto AS p
        INNER JOIN
    tienda.fabricante AS f ON p.codigo = f.codigo
WHERE
    p.precio > 200 AND f.nombre = 'Crucial';

-- 6. Devuelve un listado con todos los productos de los fabricantes Asus, Hewlett-Packard.
-- Utilizando el operador IN.
SELECT 
    p.nombre AS nombre_producto,
    p.precio,
    f.nombre AS nombre_fabricante
FROM
    tienda.producto AS p
        INNER JOIN
    tienda.fabricante AS f ON p.codigo = f.codigo
WHERE
    f.nombre IN ('Asus' , 'Hewlett-Packard');

-- 7. Devuelve un listado con el nombre de producto, precio y nombre de fabricante, de todos
-- los productos que tengan un precio mayor o igual a $180. Ordene el resultado en primer
-- lugar por el precio (en orden descendente) y en segundo lugar por el nombre (en orden
-- ascendente)
SELECT 
    p.nombre AS nombre_producto,
    p.precio,
    f.nombre AS nombre_fabricante
FROM
    tienda.producto AS p
        INNER JOIN
    tienda.fabricante AS f ON p.codigo = f.codigo
WHERE
    p.precio > 180
ORDER BY p.precio DESC , p.nombre ASC;

-- Consultas Multitabla

-- Resuelva todas las consultas utilizando las cláusulas LEFT JOIN y RIGHT JOIN.
-- 1. Devuelve un listado de todos los fabricantes que existen en la base de datos, junto con los
-- productos que tiene cada uno de ellos. El listado deberá mostrar también aquellos
-- fabricantes que no tienen productos asociados.
SELECT 
    *
FROM
    tienda.fabricante AS f
        LEFT JOIN
    tienda.producto AS p ON p.codigo = f.codigo;

-- 2. Devuelve un listado donde sólo aparezcan aquellos fabricantes que no tienen ningún
-- producto asociado.
SELECT 
    *
FROM
    tienda.fabricante AS f
        LEFT JOIN
    tienda.producto AS p ON p.codigo = f.codigo
WHERE
    f.codigo IS NULL;

-- Subconsultas (En la cláusula WHERE)

-- Con operadores básicos de comparación
-- 1. Devuelve todos los productos del fabricante Lenovo. (Sin utilizar INNER JOIN).
-- OPCION 1 SIN SUBCONSULTA
SELECT 
    *
FROM
    tienda.fabricante AS f
        LEFT JOIN
    tienda.producto AS p ON p.codigo = f.codigo
WHERE
    f.nombre = 'Lenovo';

-- OPCION 2 CON SUBCONSULTA
SELECT 
    *
FROM
    tienda.fabricante AS f
        LEFT JOIN
    tienda.producto AS p ON p.codigo = f.codigo
WHERE
    f.nombre = (SELECT 
            F.NOMBRE
        FROM
            tienda.fabricante AS f
        WHERE
            f.nombre = 'Lenovo');

-- 2. Devuelve todos los datos de los productos que tienen el mismo precio que el producto
-- más caro del fabricante Lenovo. (Sin utilizar INNER JOIN).

SELECT 
    *
FROM
    tienda.fabricante AS f
        LEFT JOIN
    tienda.producto AS p ON p.codigo = f.codigo
WHERE
    p.precio = (SELECT 
            MAX(precio) AS max_precio
        FROM
            tienda.fabricante AS f
                LEFT JOIN
            tienda.producto AS p ON p.codigo = f.codigo
        WHERE
            f.nombre = (SELECT 
                    f.nombre
                FROM
                    tienda.fabricante AS f
                WHERE
                    f.nombre = 'Lenovo'));

-- Queryes hijas Punto 2 (anterior); 
-- SELECT f.nombre FROM tienda.fabricante as f WHERE f.nombre='Lenovo';
-- select MAX(precio) as max_precio FROM tienda.fabricante as f LEFT JOIN tienda.producto as p ON p.codigo = f.codigo WHERE f.nombre = (SELECT f.nombre FROM tienda.fabricante as f WHERE f.nombre='Lenovo'); 


-- 3. Lista el nombre del producto más caro del fabricante Lenovo.
SELECT 
    p.nombre
FROM
    tienda.fabricante AS f
        LEFT JOIN
    tienda.producto AS p ON p.codigo = f.codigo
WHERE
    p.precio = (SELECT 
            MAX(precio) AS max_precio
        FROM
            tienda.fabricante AS f
                LEFT JOIN
            tienda.producto AS p ON p.codigo = f.codigo
        WHERE
            f.nombre = (SELECT 
                    f.nombre
                FROM
                    tienda.fabricante AS f
                WHERE
                    f.nombre = 'Lenovo'));

-- 4. Lista todos los productos del fabricante Asus que tienen un precio superior al precio
-- medio de todos sus productos.
SELECT 
    *
FROM
    tienda.fabricante AS f
        LEFT JOIN
    tienda.producto AS p ON p.codigo = f.codigo
WHERE
    p.precio > (SELECT 
            AVG(precio) AS avg_precio
        FROM
            tienda.fabricante AS f
                LEFT JOIN
            tienda.producto AS p ON p.codigo = f.codigo
        WHERE
            f.nombre = (SELECT 
                    f.nombre
                FROM
                    tienda.fabricante AS f
                WHERE
                    f.nombre = 'Asus'));

-- Subconsultas con IN y NOT IN
select * from tienda.producto;
select * from tienda.fabricante;

-- 1. Devuelve los nombres de los fabricantes que tienen productos asociados. (Utilizando IN o
-- NOT IN).

SELECT 
    *
FROM
    tienda.fabricante AS f
        LEFT JOIN
    tienda.producto AS p ON p.codigo_fabricante = f.codigo WHERE p.codigo IN (1,2,3,4,5,6,7,8,9,10,11);

-- 2. Devuelve los nombres de los fabricantes que no tienen productos asociados. (Utilizando
-- IN o NOT IN).
SELECT 
    *
FROM
    tienda.fabricante AS f
        LEFT JOIN
    tienda.producto AS p ON p.codigo_fabricante = f.codigo WHERE p.codigo NOT IN (1,2,3,4,5,6,7,8,9,10,11);

-- Subconsultas (En la cláusula HAVING)
-- 1. Devuelve un listado con todos los nombres de los fabricantes que tienen el mismo número
-- de productos que el fabricante Lenovo.
SELECT 
    *
FROM
    tienda.fabricante AS f
        LEFT JOIN
    tienda.producto AS p ON p.codigo_fabricante = f.codigo WHERE f.codigo='2';