

#### Data Sources
Syslog
Rsyslog
Syslog-ng
Journal
Apache


### ELK STACK
Our ELK stack setup has four main components:

    Logstash: The server component of Logstash that processes incoming logs
    Elasticsearch: Stores all of the logs
    Kibana: Web interface for searching and visualizing logs, which will be proxied through Nginx
    Filebeat: Installed on client servers that will send their logs to Logstash, Filebeat serves as a log shipping agent that utilizes the lumberjack networking protocol to communicate with Logstash


###Links
http://docs.fluentd.org/articles/before-install
