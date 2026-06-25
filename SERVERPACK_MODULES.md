# Jv420 Serverpack Modules

## Concrete starter modules

### starters/module-a

Commands:

- `/jvreport tekst`
- `/jvplayers`
- `/jvbill id bedrag`

Doel:

- reports
- speler aantal
- simpele facturen

### starters/module-b

Commands:

- `/jvvehhelp`
- `/jvlock`
- `/jvfuel`
- `/jvplate`

Doel:

- voertuig lock test
- fuel test
- kenteken check

## In server.cfg toevoegen

```cfg
ensure module-a
ensure module-b
```

Let op: zet de mappen dan in je server resources map, bijvoorbeeld:

```txt
resources/[jv]/module-a
resources/[jv]/module-b
```

of hernoem de folders naar:

```txt
jv-reports-billing
jv-vehicle-tools
```

## Werkmap

Extra plannen staan in:

```txt
notes-test.txt
```

Daarin staan ideeën voor:

- luxe opties
- kentekens
- telefoonnummers
- services
- vehicle mechanics
- economy systems
- extra jobs
