FROM ubuntu:trusty
RUN \
   apt-get -q -y update && \
   apt-get -y install software-properties-common && \
   add-apt-repository ppa:webupd8team/java && \
   apt-get -q -y update && \
   ( echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections ) && \
   apt-get -y install oracle-java8-installer && \
   apt-get -y install oracle-java8-set-default && \
   apt-get clean
               
RUN \
    apt-get -y install \
      less \
      curl \
      sudo \
      unzip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* \
    rm -rf /var/cache/apt/*
                
RUN \
   wget -O spark.tgz http://mirrors.ocf.berkeley.edu/apache/spark/spark-2.4.0/spark-2.4.0.tgz | tar xvzf spark.tar.gz -C /opt && \
   ln -s /opt/SparkR /opt/spark && \
   mkdir /opt/spark/work && \
   chmod 0777 /opt/spark/work
               
RUN \
   wget -O sw.zip http://h2o-release.s3.amazonaws.com/sparkling-water/rel-2.3/1/sparkling-water-2.3.1.zip && \
   unzip sw.zip -d /opt/ && \
   ln -s /opt/sparkling-water-2.3.1 /opt/sparkling-water && \
   rm -f sw.zip
               
ENV SPARK_HOME /opt/spark
ENV SPARKLING_WATER_HOME /opt/sparkling-water
EXPOSE 4040 54321
WORKDIR /opt/sparkling-water
