# RetailPro · Proyecto de Data Analyst

Repositorio con las entregas del curso de Data Analyst. El proyecto integrador consiste en construir un sistema de análisis completo para **RetailPro**, una distribuidora de tecnología: desde el modelo de datos y la base de datos hasta el dashboard ejecutivo.

**Autor:** Santiago Berardini

## Estructura del repositorio

| Carpeta / archivo | Contenido |
|---|---|
| [`retailpro-data-analyst/modulo-1-brief/`](retailpro-data-analyst/modulo-1-brief) | Brief analítico: problema de negocio, fuentes de datos, preguntas de análisis, KPIs y boceto del dashboard. |
| [`retailpro-data-analyst/modulo-2-modelo-datos/`](retailpro-data-analyst/modulo-2-modelo-datos) | Modelo relacional: diagrama ER, justificación de normalización hasta 3NF y conexión con el brief. |
| [`retailpro-data-analyst/RetailPro/`](retailpro-data-analyst/RetailPro) | Scripts SQL de los módulos 3, 4 y 5 (detalle abajo). |

### Scripts SQL (`RetailPro/`)

| Archivo | Módulo | Contenido |
|---|---|---|
| `ventas_tech_db.sql` | M3 | Crea y carga la base `Ventas_Tech_DB`. |
| `m4_consultas_negocio.sql` | M4 | Consultas de negocio: resumen mensual, ranking de productos, clientes recurrentes y comparación contra el promedio. |
| `m5_consultas_joins.sql` | M5 | Consultas con JOINs: vista base del proyecto, clientes sin ventas, productos sin ventas y consolidado con UNION ALL. |

## Cómo ejecutar los scripts

1. Abrir SQL Server Management Studio (SSMS) y conectarse al servidor.
2. Abrir y ejecutar [`ventas_tech_db.sql`](retailpro-data-analyst/RetailPro/ventas_tech_db.sql). Crea la base `Ventas_Tech_DB` si no existe, y se puede correr varias veces porque elimina las tablas antes de crearlas.
3. Las consultas de validación del final deben devolver 4, 5, 6 y 10 filas.
4. Con la base creada, abrir y ejecutar [`m4_consultas_negocio.sql`](retailpro-data-analyst/RetailPro/m4_consultas_negocio.sql) y [`m5_consultas_joins.sql`](retailpro-data-analyst/RetailPro/m5_consultas_joins.sql).

**Motor utilizado:** SQL Server (SSMS).
