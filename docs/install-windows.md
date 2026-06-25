# FiveM server installeren op Windows

## Benodigdheden

- Windows 10/11 PC
- FXServer artifacts
- txAdmin of handmatige FXServer setup
- MariaDB/MySQL
- HeidiSQL of phpMyAdmin
- FiveM license key via Keymaster
- Git of GitHub Desktop

## Mappenstructuur advies

```txt
C:\FXServer\server\
├─ FXServer.exe
├─ server.cfg
├─ resources\
│  ├─ [qb]\
│  ├─ [ox]\
│  ├─ [standalone]\
│  └─ [jv]\
```

## Stap 1 - Database

Maak een database aan:

```sql
CREATE DATABASE fivem_qbcore CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
```

Pas daarna in `server.cfg` aan:

```cfg
set mysql_connection_string "mysql://root:password@localhost/fivem_qbcore?charset=utf8mb4"
```

## Stap 2 - License key

Vul je FiveM license key in:

```cfg
sv_licenseKey "JOUW_KEY"
```

## Stap 3 - Admin maken

Start je server één keer en typ in de console:

```txt
status
```

Zoek jouw license identifier en zet die in `server.cfg`:

```cfg
add_principal identifier.license:xxxxx group.admin
```

## Stap 4 - Starten

Dubbelklik op:

```txt
start-server.bat
```

## Veelvoorkomende fouten

### Could not open resource metadata file
De resource heeft geen `fxmanifest.lua` of staat verkeerd in de map.

### Access denied command
Je admin license identifier staat niet goed in `server.cfg`.

### Database connection failed
Controleer:

- Database naam
- Wachtwoord
- MySQL/MariaDB draait
- oxmysql staat vóór qb-core in server.cfg

### Resource dependency missing
Installeer eerst de dependency, bijvoorbeeld `ox_lib` of `qb-core`.
