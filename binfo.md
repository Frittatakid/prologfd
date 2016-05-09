

## Data Sources
Syslog
Rsyslog
Syslog-ng
Journal
Apache


## ELK STACK
Our ELK stack setup has four main components:

    Logstash: The server component of Logstash that processes incoming logs
    Elasticsearch: Stores all of the logs
    Kibana: Web interface for searching and visualizing logs, which will be proxied through Nginx
    Filebeat: Installed on client servers that will send their logs to Logstash, Filebeat serves as a log shipping agent that utilizes the lumberjack networking protocol to communicate with Logstash


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


## 
Utilitzant CENTOS7 a vimet


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

## config file fluentd -> /etc/td-agent/td-agent.conf
## fitxer recol·leció logs /var/log/td-agent/td-agent.log

### test -> curl -X POST -d 'json={"json":"message"}' http://localhost:8888/debug.test
