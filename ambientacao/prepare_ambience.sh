#!/bin/bash
ES_VERSION="7.5.1-linux-x86_64"
ESSTACK_DIR="/elasticstack"
ES_APPS="elasticsearch/elasticsearch kibana/kibana logstash/logstash beats/metricbeat/metricbeat beats/filebeat/filebeat beats/packetbeat/packetbeat beats/auditbeat/auditbeat apm-server/apm-server" 

# Ajustando as particoes de disco
if [ -e "/dev/sdb" ]; then
   echo -e "o\nn\np\n1\n\n\nw" | fdisk /dev/sdb
   mkfs.ext4 /dev/sdb1
   echo "/dev/sdb1       /elasticstack                   ext4    defaults        0 0" >> /etc/fstab
   mkdir /elasticstack 
   mount -a
fi

# Desabilitando o IPV6
sysctl -w net.ipv6.conf.all.disable_ipv6=1
sysctl -w net.ipv6.conf.default.disable_ipv6=1

# Criando diretório de instalacao
mkdir -p $ESSTACK_DIR/datasets

#Instalando as ferramentas do SO
yum install -y tzdata net-tools curl git java-1.8.0-openjdk

# Baixando as ferramentas da Stack
for APPS in $ES_APPS; do
   if [ "$APPS" == "logstash/logstash" ]; then
      wget -P $ESSTACK_DIR https://artifacts.elastic.co/downloads/logstash/logstash-7.5.1.tar.gz
   else 
      wget -P $ESSTACK_DIR https://artifacts.elastic.co/downloads/$APPS-$ES_VERSION.tar.gz
   fi
done

# Baixando os datasets 
wget -P $ESSTACK_DIR/datasets/cb_2012.csv.zip https://obamawhitehouse.archives.gov/sites/default/files/disclosures/whitehouse-waves-2012.csv_.zip 
wget -O $ESSTACK_DIR/datasets/apache.log https://www.todaynewsportal.com/access.log
wget -O $ESSTACK_DIR/datasets/employees.zip https://github.com/datacharmer/test_db/archive/master.zip
wget -O $ESSTACK_DIR/datasets/despesas_parlamentares.zip https://drive.google.com/file/d/1-ClkPZBNtoktWMMqBeJbzW_QEDVgKP8x/view?usp=sharing
