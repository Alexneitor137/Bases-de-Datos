CREATE USER 
'composiciones2'@'localhost' 
IDENTIFIED  BY 'Composiciones123$';

GRANT USAGE ON *.* TO 'composiciones2'@'localhost';


ALTER USER 'composiciones2'@'localhost' 
REQUIRE NONE 
WITH MAX_QUERIES_PER_HOUR 0 
MAX_CONNECTIONS_PER_HOUR 0 
MAX_UPDATES_PER_HOUR 0 
MAX_USER_CONNECTIONS 0;

GRANT ALL PRIVILEGES ON composiciones.* 
TO 'composiciones2'@'localhost';

FLUSH PRIVILEGES;
