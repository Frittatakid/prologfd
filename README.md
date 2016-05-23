# Centralització de logs JSON en BBDD i post-processat

<div>
<a href="http://www.fluentd.org/">
  <img src="http://www.fluentd.org/assets/img/miscellany/fluentd-logo.png" width="200" height="97" hspace="70" />
</a>

<a href="https://www.elastic.co/products/elasticsearch">
  <img src="https://static-www.elastic.co/assets/blt5206a5d68cf558f0/elastic-elasticsearch-fw.svg?q=120" width="110" height="122" hspace="70" />
</a>

<a href="https://www.elastic.co/products/kibana">
  <img src="https://static-www.elastic.co/assets/blt1227b0c93c157e40/elastic-kibana-fw.svg?q=120" width="71" height="122" hspace="70" />
</a>

</div>


## EFK STACK

El "EFK stack" (Elasticsarch-Fluentd-Kibana) és un conjunt de serveis que s'encarrega de centralitzar logs de múltiples fonts a més de oferir una manera de visualitzar-los.  
És una variant del més conegut "ELK stack", el qual utilitza [Logstash](https://www.elastic.co/products/logstash) en lloc de Fluentd.


### Fluentd

[Fluentd](http://www.fluentd.org/) centralitza els logs de múltiples fonts i enviar-los a diferents destins en un format unificat (JSON).  
En aquest cas l'objectiu és destinar-los íntegrament a elasticsearch, però es poden fer copies locals dels logs, distribuir-los en diferents bases de dades...


### Elasticsearch

[Elasticsearch](https://www.elastic.co/products/elasticsearch) s'encarrega de enregistrar els logs en la seva base de dades en forma de indexos.  
Cada índex és el destí de una o més fonts de logs, i els índex es divideixen en "shards" que poden ser distribuides entre diferents nodes de elasticsearch per dividir la càrrega.

### Kibana

[Kibana](https://www.elastic.co/products/kibana) és un servei gràfic per elasticsearch, permet mostrar dades sobre els logs continguts en els índexos de elasticsearch, a més pot (mitjançant serveis adicionals) rebre informació del sistema per la monitorització.
  
  
  
  
## Instal·lació

La instal·lació de aquest EFK stack està completament automatitzada amb els scripts.  
Veure la [guia](userguide.md) per més informació sobre la instal·lació i els paràmetres modificables.
  
  
  
  
## Config

Conté les configuracións necessaries per cada un dels serveis.
Per defecte el servidor Fluentd recull tot el que s'insereix a syslog de la màquina local, i es poden afegir fonts o outputs.  
Prengui com a refèrencia la [guia](userguide.md) per fer-ho.  
  
  
  
## Docker-files

Conté els docker files necessaris per crear containers amb cada ún dels serveis.

  
  
  
## Scripts

### createContainers.sh

Crea les imatges i contenidors a partir dels docker files. 

### start.sh

Inicia els contenidors creats amb createimages.sh.

### stop.sh

Para els contenidors creats amb createimages.sh

### wipeALL.sh

Borra tot el que createimage.sh crea, utilitzar en càs de voler modificar algún paràmetre de creació.


  
  
  



<p align="right" >Sergi Vegas Medina - ASIX2</p>
