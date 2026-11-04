# RetailPro · Proyecto de Data Analyst

Repositorio con las entregas del curso de Data Analyst. El proyecto integrador consiste en construir un sistema de análisis completo para **RetailPro**, una distribuidora de tecnología: desde el modelo de datos y la base de datos hasta el dashboard ejecutivo.

**Autor:** Santiago Berardini

## Estructura del repositorio

| Carpeta | Contenido |
|---|---|
| [`modulo-1-brief/`](modulo-1-brief) | Brief analítico: problema de negocio, fuentes de datos, preguntas de análisis, KPIs y boceto del dashboard. |
| [`modulo-2-modelo-datos/`](modulo-2-modelo-datos) | Modelo relacional: diagrama ER, justificación de normalización hasta 3NF y conexión con el brief. |
| [`modulo-3-sql-server/`](modulo-3-sql-server) | Script SQL `ventas_tech_db.sql` que crea y carga la base `Ventas_Tech_DB`. |

## Cómo ejecutar el script SQL

1. Abrir SQL Server Management Studio (SSMS) y conectarse al servidor.
2. Abrir el archivo [`modulo-3-sql-server/ventas_tech_db.sql`](modulo-3-sql-server/ventas_tech_db.sql).
3. Ejecutar el script completo. Crea la base `Ventas_Tech_DB` si no existe, y se puede correr varias veces porque elimina las tablas antes de crearlas.
4. Las consultas de validación del final deben devolver 4, 5, 6 y 10 filas.

**Motor utilizado:** SQL Server (SSMS).
