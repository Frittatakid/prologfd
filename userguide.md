# GUIA DE INSTAL·LACIÓ DEL EFK STACK

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

http://www.elastichq.org # plugin per elastic a explorador ( host:9200/_plugin/hq/ )

---

## Personalització


config file fluentd -> /etc/td-agent/td-agent.conf

<source>
  @type forward
  port 24224
  bind 0.0.0.0
</source>


/etc/elasticsearch/elasticsearch.yml

/opt/kibana/config/kibana.yml
/usr/share/elasticsearch/kibana.yml


### Editor a container

apt-get update

apt-get install X(nano,vim...)




### Als container

docker inspect <container> - infod el container, veure la seva IP

docker exec -it kibana /bin/bash


---

## Links de referéncia

https://www.elastic.co/guide/en/elasticsearch/reference/current/index.html

http://docs.fluentd.org/articles/recipe-syslog-to-elasticsearch

http://docs.fluentd.org/articles/quickstart
http://docs.fluentd.org/articles/input-plugin-overview
http://docs.fluentd.org/articles/output-plugin-overview

https://www.elastic.co/guide/en/elasticsearch/reference/current/search-search.html

https://www.elastic.co/guide/

http://blog.trifork.com/2014/01/07/elasticsearch-how-many-shards/ **info sobre shards i funcionament de elastic**



### search -> curl 'localhost:9200/mylogs-2016.05.12/_search?q=*'

curl -XGET 'http://localhost:9200/mylogs-2016.05.12/_search?pretty?q=*' | jq .




