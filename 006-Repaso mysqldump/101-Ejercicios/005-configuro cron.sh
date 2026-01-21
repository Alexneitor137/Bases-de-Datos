En el cron, añado esta linea:

* * * * * /usr/bin/python3 /var/www/html/generadorapuntesv3/informe.py "/var/www/html/dam2526/Segundo/Acceso a datos" >/dev/null 2>&1