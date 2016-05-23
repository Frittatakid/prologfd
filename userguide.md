# GUIA DE INSTAL·LACIÓ DEL EFK STACK A DOCKER

Aquesta guia conté ordres i explicacións pel procés de instal·lació de la combinació de serveis Elasticsearch, Fluentd, i Kibana coneguts com "EFK STACK".


## Prerequisits

### Docker

#### Instal·lació
Es requereix almenys la versió de docker 1.10.1 per tal de realitzar la instal·lació.

[Instal·lació de docker per diferentes distribucions](https://docs.docker.com/engine/installation/)

#### Acces de usuari a docker

El més probable és que es tingi la intenció de utilitzar docker com a usuari, en aquest càs s'han de realitzar les següents ordres.

```
sudo groupadd docker

sudo gpasswd -a (user) docker

sudo systemctl restart docker

newgrp docker
```
### Permissos /var/log

Fluentd agafarà els logs que s'insereixin a /var/log/messages, comprova que es puguin llegir els fitxers dels que vols agafar logs.  
```
chmod o+r /var/log -R
```
Aquesta opció eś poc segura, ja que permet el acces de lectura a qualsevol usuari pel que es recomana fer-ho amb precaució.

### Selinux / firewall

Els contenidors redirigiran ports al host local, pel que serà necessari que es permetin.	
Aquests ports són els 9200 i el 5601, el 9300 també s'exposa, però només s'utilitzarà en càs que es vulgi crear un clúster de elasticsearch.  
  
---

## Instal·lació

Iniciar docker en càs que no ho estigui:
```
sudo systemctl start docker
```

Clonar el repositori:
```
git clone git@github.com:theseregi/prologfd.git
```

```
cd prologfd
```

Executar script de generació de les imatges i contenidors:
```
./createContainers.sh
```
*Aquest procés tardarà una estona, ja que ha de descarregar múltiples imatges.*	
**En càs de requerir tornar a començar o borrar els contenidors es pot utilitzar el script "./wipeALL.sh"**	
*AVÍS: Aquest script no borrarà TOTES les imatges generades, ja que cada una de les imatges finals requereixen de altres com a base, les quals es preservaràn i s'hauràn de borrar manualment (docker rmi [id de imatge]).*	

Quan hagi acabat el procés de creació, s'hauràn creat les imatges, els contenidors i una xarxa per aquests contenidors.

Es poden iniciar els tres amb:  
```
./start.sh
```
O parar amb:
```
./stop.sh
```

En aquest punt hauries de tenir al teu host exposats els ports 9200 i 5601.	
La imatge de Elasticsearch porta incorporada un [plugin](http://www.elastichq.org) gràfic al qual pots accedir desde un explorador amb "http://(host):9200/_plugin/hq/".	  
El port 5601 és el própi de Kibana, per accedir a ell només s'ha de anar a "http://(host):5601".	
	
	
Per defecte, si no has realitzar cap modificació, estaras recollint tot el que rep el syslog del host dels containers.	
A la següent secció pots veure com modificar els serveis per variar el seu comportament.	

---

## Visualització

Dins dels interfaces de ElasticHQ i Kibana pots realitzar diferents operacions.	

A ElasticHQ es poden fer tant consultes com operacións de gestió de Elasticsearch i els seus índex, però es preferible utilitzar Kibana per les consultes ja que ofereix més informació i estabilitat.	
	
Al accedir a Kibana per primer cop es demanarà el nom dels índex a recollir.	
Per defecte el nom del índex és fluentd-(data), pel que s'ha de introduir al camp de text "fluentd-*".
	
Desprès de afegir el índex ja es pot començar a realitzar consultes i generar visualitzacións.


Alternativament, també pots consultar manualment els logs de Elasticsearch amb curl:

```
curl -XGET 'http://localhost:9200/(index_name)/_search?q=host:hostname' | jq .
```
	
Pots instalar jq per mostrar les dades de manera més visual:
```
curl -XGET 'http://localhost:9200/(index_name)/_search?q=host:hostname' | jq .
```


O amb el mateix explorador amb la ruta:
```
http://hostname:9200/_search?q=host:hostname
```
*Aquestes dues consultes mostren en aquest càs les entrades en les quals el camp "host" és igual a hostname.*

--- 

## Personalització

### Fluentd

Existeixen dues maneres de modificar la configuració de fluentd.  

#### Abans de crear les imatges

Es pot modificar el script situat a prologfd/docker-files/fluentd+elasticp/setup_plugin.sh per que inclogui configuració pròpia.	
Si edites setup_plugin.sh podràs veure una ordre així:

```
...
echo "

<source>
  type tail
  format syslog
  path /var/log/syslogs/messages
  tag fd.syslog
</source>

<match **>
	type elasticsearch
	logstash_format true
	host $ES_HOST
	port $ES_PORT
	index_name $ES_INDEX
	type_name $ES_TYPE
	include_tag_key true
	logstash_prefix fluentd
</match>" >> /etc/td-agent/td-agent.conf
...

```
Això és la configuració per defecte, la pots modificar de manera que la teva imatge de fluentd sempre contingui certs valors.
	
La configuració funciona principalment mitjançant tags "source" i "match".	
Source consisteix en les fonts de dades, match determina que fer amb les dades que coincideixin amb un pattern.	
En el càs del exemple la source prové de /var/log/syslogs/messages (aquí està montat el /var/log del host).	
Informació sobre la configuració de Fluentd	 [http://docs.fluentd.org/articles/config-file](http://docs.fluentd.org/articles/config-file)	

#### Amb els contenidors ja creats

Una opció que pots utilitzar en càs de canvis situacionals és accedir directament al contenidor i modificar el fitxer de configuració.	
Per tal de accedir al contenidor, ens hem de assegurar que està iniciat i realitzar la següent ordre:

```
docker exec -it fluentd /bin/bash
```
Ja dins del contenidor has de modificar /etc/td-agent/td-agent.conf, però el contenidor no poseeix ningun editor de text.	
Pots utilitzar cat per fer append de text al fitxer, o instal·lar algún editor amb:

```
apt-get update

apt-get install vim
```

Informació sobre la configuració de Fluentd	 [http://docs.fluentd.org/articles/config-file](http://docs.fluentd.org/articles/config-file)	

### Elasticsearch i kibana

Pots modificar manualment la configuració de Elasticsearch i Kibana, com les rutes dels hosts, però no és recomana degut a que les direccións estàn predefinides.	
Si es volen realitzar aquest tipus de modificacions s'ha de executar:

```
docker exec -it elastic /bin/bash

o

docker exec -it kibana /bin/bash
```

Dins podràs trobar els fitxers de configuració a "/etc/elasticsearch/elasticsearch.yml" i "/opt/kibana/config/kibana.yml"

Referència configuració Elasticsearch: [https://www.elastic.co/guide/en/elasticsearch/reference/current/index.html](https://www.elastic.co/guide/en/elasticsearch/reference/current/index.html)	
	
Referència configuració Kibana: (https://www.elastic.co/guide/en/kibana/current/index.html)[https://www.elastic.co/guide/en/kibana/current/index.html]	





