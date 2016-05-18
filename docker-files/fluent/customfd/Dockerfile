


FROM openfirmware/fluentd-elasticsearch
MAINTAINER Sergi Vegas Medina <theseregi@gmail.com>


RUN mkdir /var/log/syslogs

RUN echo "\
<source>
  type tail
  format syslog
  path /var/log/syslogs/messages
  tag fd.syslog
</source>
" >> /etc/td-agent/td-agent.conf











