# Installatie op Nitrado + txAdmin

1. Open txAdmin.
2. Stop je server.
3. Upload de resource mappen via FTP/Filebrowser.
4. Zet `server.cfg` in je server root of kopieer de inhoud naar je bestaande cfg.
5. Vul `set mysql_connection_string` in met je Nitrado database gegevens.
6. Importeer `sql/delfzijl_starter.sql` in je database.
7. Start server.
8. Check console op missing resources.
9. Test in-game:
   - /setjob
   - /car
   - inventory openen
   - target oogje
   - identity registratie

## Goede startvolgorde
oxmysql -> ox_lib -> es_extended -> ox_target -> ox_inventory -> esx scripts -> delfzijl scripts
