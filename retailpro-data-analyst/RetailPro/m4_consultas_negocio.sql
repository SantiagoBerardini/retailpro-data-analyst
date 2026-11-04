-- Motor utilizado: SQL Server (SSMS)
-- Pre-entrega M4: Consultas SQL de negocio
-- Base de datos: Ventas_Tech_DB (creada en M3)
-- Se trabaja solo sobre la tabla ventas. Total por venta = cantidad * precio_unitario.

USE Ventas_Tech_DB;
GO

-- === CONSULTA 1: Resumen ejecutivo mensual ===
-- Total facturado, cantidad de pedidos y ticket promedio, agrupados por mes.
SELECT
    MONTH(fecha_venta)                                AS mes,
    SUM(cantidad * precio_unitario)                   AS total_facturado,
    COUNT(*)                                          AS cantidad_pedidos,
    CAST(AVG(cantidad * precio_unitario) AS DECIMAL(10,2)) AS ticket_promedio
FROM ventas
GROUP BY MONTH(fecha_venta)
ORDER BY mes;

-- === CONSULTA 2: Ranking de productos ===
-- Top 5 de id_producto por total facturado, con unidades vendidas y total generado.
SELECT TOP 5
    id_producto,
    SUM(cantidad)                     AS unidades_vendidas,
    SUM(cantidad * precio_unitario)   AS total_generado
FROM ventas
GROUP BY id_producto
ORDER BY total_generado DESC;

-- === CONSULTA 3: Clientes recurrentes ===
-- id_cliente con más de un pedido, con la cantidad de pedidos y el total gastado.
SELECT
    id_cliente,
    COUNT(*)                          AS cantidad_pedidos,
    SUM(cantidad * precio_unitario)   AS total_gastado
FROM ventas
GROUP BY id_cliente
HAVING COUNT(*) > 1
ORDER BY total_gastado DESC;

-- === CONSULTA 4: Productos por encima / por debajo del promedio ===
-- Total facturado por id_producto, etiquetado según el promedio de los totales por producto
-- (no el promedio de las filas de ventas).
WITH facturacion_producto AS (
    SELECT
        id_producto,
        SUM(cantidad * precio_unitario) AS total_facturado
    FROM ventas
    GROUP BY id_producto
)
SELECT
    id_producto,
    total_facturado,
    CAST((SELECT AVG(total_facturado) FROM facturacion_producto) AS DECIMAL(10,2)) AS promedio_por_producto,
    CASE
        WHEN total_facturado > (SELECT AVG(total_facturado) FROM facturacion_producto)
            THEN 'Por encima'
        ELSE 'Por debajo'
    END AS comparacion_promedio
FROM facturacion_producto
ORDER BY total_facturado DESC;

-- === HALLAZGOS ===
-- 1. El producto 1 concentra el 55,9% de la facturación de marzo de 2024 (3.600 de 6.444).
--    Junto con el producto 3 (1.350) suman el 76,8%: son los dos únicos productos
--    por encima del promedio de 1.074 por producto.
-- 2. El producto 2 es el que más unidades vendió (13, contra 3 o 4 del resto) pero genera
--    solo 364, el 5,6% de la facturación. Mucho volumen y poco ingreso por su precio bajo.
-- 3. Los 5 clientes hicieron 2 pedidos cada uno, pero el gasto está muy concentrado:
--    los clientes 1 (2.640) y 5 (2.100) aportan el 73,6% del total, mientras que los otros
--    tres clientes gastan entre 510 y 674 cada uno.
