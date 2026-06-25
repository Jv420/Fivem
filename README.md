# FiveM Server Starter - Jv420

Gratis basis voor een Nederlandse FiveM roleplay/economy server op Windows.

## Wat zit hierin?

- `server.cfg` template voor FXServer
- Windows startbestand `start-server.bat`
- Basis resources-map
- Gratis script/mods checklist
- Installatiehandleiding
- Voorbeeld Discord logging config

## Aanbevolen gratis stack

Framework:
- QBCore
- ox_lib
- oxmysql
- ox_target
- ox_inventory

Basis systemen:
- Banking
- Garages
- Vehicle keys
- Police job
- Ambulance job
- Shops
- Dealership
- Apartments/housing
- Admin menu
- Loading screen

## Belangrijk

Gebruik alleen gratis/open-source scripts van betrouwbare bronnen:

- Cfx.re forum releases
- QBCore GitHub
- Overextended GitHub/docs
- Bekende GitHub repositories

Gebruik geen leaked/pirated scripts. Dat kan zorgen voor malware, backdoors, FiveM problemen en copyright claims.

## Snelle installatie

1. Zet je FXServer map bijvoorbeeld op:

```txt
C:\FXServer\server
```

2. Clone deze repo of download hem als ZIP.

3. Kopieer `server.cfg.example` naar:

```txt
C:\FXServer\server\server.cfg
```

4. Maak een map:

```txt
C:\FXServer\server\resources\[standalone]
C:\FXServer\server\resources\[qb]
C:\FXServer\server\resources\[ox]
```

5. Download de scripts uit `docs/free-resources.md`.

6. Vul je FiveM license key in bij:

```cfg
sv_licenseKey "JOUW_KEY_HIER"
```

7. Start de server met:

```bat
start-server.bat
```

## Volgende stap

Deze repo is een startbasis. Daarna kunnen we uitbreiden met:

- Complete QBCore server pack structuur
- Nederlandse jobs
- Nederlandse politie/ambulance configs
- Discord bot/logs
- Webshop met Stripe
- Donatie/VIP systeem
- Database install scripts
