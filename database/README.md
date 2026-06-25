# Database

## jv_starter.sql

Starter tabellen voor eigen Jv420 uitbreidingen:

- `jv_server_settings`
- `jv_donations`

## Installatie

1. Maak database aan:

```sql
CREATE DATABASE fivem_qbcore CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
```

2. Importeer eerst QBCore/ox SQL.
3. Importeer daarna `jv_starter.sql`.

Deze SQL vervangt geen QBCore database. Het is alleen voor extra Jv420 uitbreidingen.
