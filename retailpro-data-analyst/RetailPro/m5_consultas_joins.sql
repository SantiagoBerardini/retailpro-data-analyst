-- Motor utilizado: SQL Server (SSMS)
-- Pre-entrega M5: Consultas con JOINs para el proyecto
-- Base de datos: Ventas_Tech_DB (creada en M3)

USE Ventas_Tech_DB;
GO

-- Consulta 1: Vista base del proyecto (INNER JOIN)
-- Propósito: cruzar ventas con clientes, productos y categorías en una sola fila por venta;
-- es la fuente de datos principal para Power BI (ciudad y categoría sirven para agrupar y filtrar).
SELECT
    v.id_venta,
    v.fecha_venta,
    c.id_cliente,
    c.nombre                          AS nombre_cliente,
    c.ciudad,
    p.nombre_producto,
    cat.nombre_categoria,
    v.cantidad,
    v.precio_unitario,
    v.cantidad * v.precio_unitario    AS total_venta
FROM ventas v
INNER JOIN clientes   c   ON v.id_cliente   = c.id_cliente
INNER JOIN productos  p   ON v.id_producto  = p.id_producto
INNER JOIN categorias cat ON p.id_categoria = cat.id_categoria
ORDER BY v.fecha_venta, v.id_venta;
-- Hallazgo: la vista devuelve las 10 ventas con cliente, producto, categoría y ciudad completos, sin perder ninguna en el cruce.
-- Computación concentra 4.950 de los 6.444 facturados (76,8%), por lo que es la categoría que más pesa en el dashboard.

-- Consulta 2: Clientes sin ventas (LEFT JOIN)
-- Propósito: detectar clientes registrados que nunca compraron, para que CRM los contacte.
SELECT
    c.nombre,
    c.email,
    c.fecha_registro
FROM clientes c
LEFT JOIN ventas v ON c.id_cliente = v.id_cliente
WHERE v.id_venta IS NULL;
-- Hallazgo: 0 de los 5 clientes registrados nunca compraron, todos tienen al menos una venta.
-- Para CRM no hay clientes inactivos que contactar por ahora, y el esfuerzo puede ir a retener a los que ya compran.

-- Consulta 3: Productos sin ventas (LEFT JOIN)
-- Propósito: identificar artículos del catálogo sin movimiento, para que producto decida si los promociona o los da de baja.
SELECT
    p.nombre_producto,
    cat.nombre_categoria,
    p.precio
FROM productos p
LEFT JOIN ventas v        ON p.id_producto  = v.id_producto
LEFT JOIN categorias cat  ON p.id_categoria = cat.id_categoria
WHERE v.id_venta IS NULL;
-- Hallazgo: 0 de los 6 productos del catálogo están sin ventas, los 6 se vendieron en marzo de 2024.
-- Para producto no hay artículos para dar de baja por falta de rotación; conviene vigilar al de menor facturación (Auriculares BT Pro, 360).

-- Consulta 4: Consolidado por canal (UNION ALL)
-- Propósito: comparar la facturación de dos períodos del mes. El esquema no guarda el canal de venta,
-- así que el origen se crea como valor fijo en cada SELECT, separando las ventas hasta el 10 de marzo y desde el 11.
SELECT canal, SUM(total) AS total_canal
FROM (
    SELECT fecha_venta, cantidad * precio_unitario AS total, 'Hasta el 10 de marzo' AS canal
    FROM ventas
    WHERE fecha_venta <= '2024-03-10'
    UNION ALL
    SELECT fecha_venta, cantidad * precio_unitario AS total, 'Desde el 11 de marzo' AS canal
    FROM ventas
    WHERE fecha_venta > '2024-03-10'
) AS consolidado
GROUP BY canal
ORDER BY total_canal DESC;
-- Hallazgo: las ventas hasta el 10 de marzo facturaron 3.620 (56,2%) y las del 11 en adelante 2.824 (43,8%).
-- Ambos totales suman 6.444, igual que el total de la base, así que ninguna venta quedó afuera ni se contó dos veces.
