

## Data Sources
Syslog
Rsyslog
Syslog-ng
Journal
Apache


## Links
http://docs.fluentd.org/articles/before-install
http://docs.fluentd.org/articles/install-by-rpm#step-1-install-from-rpm-repository
http://www.techstricks.com/elasticsearch-fluentd-kibana-efk-setup-guide/
https://github.com/uken/fluent-plugin-elasticsearch
https://www.elastic.co/guide/en/elasticsearch/reference/current/index.html
https://stedolan.github.io/jq/download/
http://docs.fluentd.org/articles/recipe-syslog-to-elasticsearch
http://docs.fluentd.org/articles/in_tail#
http://docs.fluentd.org/articles/in_syslog
https://www.elastic.co/guide/en/elasticsearch/reference/current/search-search.html

https://www.elastic.co/guide/en/beats/
http://qiita.com/repeatedly/items/77af41788f0b3ccdefd2
https://github.com/repeatedly/fluent-plugin-beats

http://blog.trifork.com/2014/01/07/elasticsearch-how-many-shards/ **info sobre shards i funcionament de elastic**
## 
Utilitzant CENTOS7 a vimet
i

22  vim /etc/security/limits.conf
23  vim /etc/sysctl.conf
24  curl -L https://toolbelt.treasuredata.com/sh/install-redhat-td-agent2.sh | sh
 ( # install the toolbelt
  yes | yum install -y td-agent )

25  /etc/init.d/td-agent start 

27  vim /etc/td-agent/td-agent.conf
28  systemctl status httpd

31  yum install -y httpd
32  systemctl start httpd

journalctl -o json | jq .

### 40  setenforce 0
### 43  systemctl stop firewalld

## fitxer recol·leció logs /var/log/td-agent/td-agent.log

### test -> curl -X POST -d 'json={"json":"message"}' http://localhost:8888/debug.test

### search -> curl 'localhost:9200/mylogs-2016.05.12/_search?q=*'

curl -XGET 'http://localhost:9200/mylogs-2016.05.12/_search?pretty?q=*' |jq .




## Install stuff

config file fluentd -> /etc/td-agent/td-agent.conf

/etc/elasticsearch/elasticsearch.yml

/opt/kibana/config/kibana.yml
/usr/share/elasticsearch/kibana.yml


yum install -y openjdk-7-jre

vim /etc/rsyslog.conf

td-agent-gem install fluent-plugin-beats -> plugins *beat
*not working*

/etc/topbeat/topbeat.yml
systemctl start topbeat

/etc/filebeat/filebeat.yml

/etc/packetbeat/packetbeat.yml

http://www.elastichq.org # plugin per elastic a explorador ( host:9200/_plugin/hq/ )
### Crear imatges

docker build elasticsearch
docker build fluentd
docker build kibana


### Crear containers

docker create X

### Iniciar containers

docker start $1

docker exec -it $1 /bin/bash



### Editor a container

apt-get update

apt-get install X(nano,vim...)




### Als container

### Acces de usuari a docker

El més probable és que es tingi la intenció de utilitzar docker com a usuari, en aquest càs s'han de realitzar les seguents ordres.

sudo groupadd docker

sudo gpasswd -a (user) docker

sudo systemctl restart docker

newgrp docker / relog


--


docker inspect <container> - infod el container, veure la seva IP
Mes val fer bind dels ports a el host, ja que és una maquina virtual i no podem accedir a les ip dels containers.

docekr start
docker exec -it kibana /bin/bash

#### Fluentd



#### Elasticsearch
docker build -t "elasticswplug" custom # construir elastic desde directori custom ( porta elastic+plugin de explorador )

docker create --name elastic -p 9200:9200 -p 9300:9300 elasticswplug
*redirigeix els ports especificats als ports locals*

docker start elastic



#### Kibana

docker build -t fluentd fluentd

docker create  --name kibana -p 5601:5601 kibana


