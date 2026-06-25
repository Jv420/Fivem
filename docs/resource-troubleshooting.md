# Resource troubleshooting

## Resource start niet

Controleer:

- Bestaat `fxmanifest.lua`?
- Staat de mapnaam hetzelfde als in `ensure`?
- Staat de resource in de juiste map onder `resources`?
- Mist er een dependency?

## No such export

De dependency start te laat of ontbreekt.

Voorbeeld oplossing:

```cfg
ensure ox_lib
ensure qb-core
ensure jouw-resource
```

## Database error

Controleer:

- MySQL/MariaDB draait
- Database bestaat
- Gebruikersnaam/wachtwoord klopt
- oxmysql start vóór qb-core

## Permission denied

Controleer je admin identifier:

```txt
status
```

Daarna in `server.cfg`:

```cfg
add_principal identifier.license:xxxxx group.admin
```
