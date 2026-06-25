# QBCore installatievolgorde

Gebruik deze volgorde om errors te voorkomen.

## 1. Basis folders

```txt
resources/[ox]
resources/[qb]
resources/[standalone]
resources/[jv]
```

## 2. Plaats dependencies

In `[ox]`:

- oxmysql
- ox_lib
- ox_target
- ox_inventory

## 3. Plaats QBCore

In `[qb]`:

- qb-core
- qb-multicharacter
- qb-spawn
- qb-apartments
- qb-clothing
- qb-weathersync
- qb-smallresources
- qb-hud
- qb-management
- qb-banking
- qb-shops
- qb-phone
- qb-garages
- qb-vehiclesales
- qb-vehiclekeys
- qb-policejob
- qb-ambulancejob

## 4. Plaats eigen resources

In `[jv]`:

- jv-loading
- jv-discordlogs
- jv-notify
- jv-adminhelp

## 5. Database import

Importeer eerst de SQL van QBCore/ox_inventory. Daarna pas:

```txt
database/jv_starter.sql
```

## 6. Starten

Start met weinig resources. Als alles werkt, voeg je meer toe.
