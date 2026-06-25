# BMW 520D F11 - FiveM Addon Vehicle

Deze resource is klaar als FiveM addon-vehicle scaffold voor DelfzijlCity.

## Wat zit erin?

- `fxmanifest.lua`
- `client.lua` met `/bmw520` spawncommand
- `vehicles.meta`
- `carvariations.meta`
- `handling.meta`
- `stream/PUT_MODEL_FILES_HERE.txt`

## Wat ontbreekt nog?

De echte 3D modelbestanden ontbreken bewust. Die mag ik niet leveren zonder geldige licentie van de maker.

Je moet zelf een legaal verkregen BMW 520D/F11 FiveM/GTA model downloaden of kopen en deze bestanden in `stream` zetten:

```txt
bmw520f11.yft
bmw520f11_hi.yft
bmw520f11.ytd
```

De namen moeten exact overeenkomen met `bmw520f11`.

## Installatie

Upload de map naar je server:

```txt
resources/[cars]/bmw520f11
```

Voeg toe aan `server.cfg`:

```cfg
ensure bmw520f11
```

Restart je server.

## Testen

In-game:

```txt
/bmw520
```

Info command:

```txt
/bmw520info
```

## Veelvoorkomende fout

Als je krijgt dat het model niet laadt, dan staan de `.yft/.ytd` bestanden niet in `stream` of hebben ze niet exact de juiste naam.
