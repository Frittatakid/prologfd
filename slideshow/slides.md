% CENTRALITZACIÓ DE LOGS JSON EN BBDD I POST-PROCESSAT
% Sergi Vegas Medina
% 26/05/2016


LOGS?
--------------------

**Exemples de logs**

```
May 24 19:52:20 localhost.localdomain gdm-password][31985]: 
pam_unix(gdm-password:auth): conversation failed


May 24 19:13:30 localhost.localdomain systemd[1]: 
Starting Fingerprint Authentication Daemon...
```

PROJECTE
---------

* Unificació de logs de múltiples fonts

* Format únic

* Emmagatzament

* Visualització

SERVEIS
---------

* Fluentd - Unificació i format

* Elasticsearch - Emmagatzament

* Kibana - Visualització

FLUENTD
---------
![](slidepics/fluentd.png)

* Ús
* Configuració - /etc/td-agent/td-agent.conf

```
<source>
  type tail
  format apache
  path /var/log/httpd/access_log
  tag host.httpd.access
</source>

<match host.httpd.access>
  @type file
  path /var/log/fluent/test
  flush_interval 20s
</match>
```

ELASTICSEARCH
---------
![](slidepics/elastic.png)

* Ús

* Configuració - /etc/elasticsearch/elasticsearch.yml

```
path.logs: /path/to/logs
http.port: 9200
```
KIBANA
---------
![](slidepics/kibana.png)

* Ús

* Configuració - /opt/kibana/config/kibana.yml

```
kibana.index: ".kibana"
elasticsearch.url: "http://localhost:9200"
http.port: 5601
```

APLICACIÓ
---------

* Automatització de la construcció

* Mínima intervenció del usuari

* Possibilitat de personalització
    * Abans o desprès de la instal·lació
  
  
DOCKER
---------

Creació de les imatges i contenidors per cada servei

* docker-files

* docker build

* docker create
    * network (Versió 1.10.1)
    * ports
  
   

SCRIPTS
---------

* createContainers.sh

* start.sh

* stop.sh

* wipeALL.sh


FUNCIONAMENT I ÚS
---------

* Elastic HQ - host:9200/_plugin/hq/

* Kibana - host:5601
    * Selecció de índex
    * Visualitzacións
    * Dashboard
 
CONCLUSIONS
---------

* Sumari

* Aprenentatge
    * Github
    * Logs
    * Docker
    * Serveis

CENTRALITZACIÓ DE LOGS JSON EN BBDD I POST-PROCESSAT
---------

Sergi Vegas Medina	

ASIX2

26/05/2016


