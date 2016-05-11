

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






