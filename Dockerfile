FROM phusion/baseimage
MAINTAINER Grega Vrbančič <grega.vrbancic@gmail.com>

# install mvn
RUN apt-get update && apt-get install -y wget

# get mvn
ENV MVN_VERSION 3.5.0
RUN wget -O /tmp/apache-maven-$MVN_VERSION.tar.gz http://archive.apache.org/dist/maven/maven-3/$MVN_VERSION/binaries/apache-maven-$MVN_VERSION-bin.tar.gz

# install mvn
RUN tar xzf /tmp/apache-maven-$MVN_VERSION.tar.gz -C /opt/
RUN ln -s /opt/apache-maven-$MVN_VERSION /opt/maven
RUN ln -s /opt/maven/bin/mvn /usr/local/bin
RUN rm -f /tmp/apache-maven-$MVN_VERSION.tar.gz
ENV MAVEN_HOME /opt/maven

# download java 
ENV JAVA_VERSION 1.8.0_141
ENV JAVA_DOWNLOAD http://download.oracle.com/otn-pub/java/jdk/8u141-b15/336fa29ff2bb4ef291e347e091f7f4a7/jdk-8u141-linux-x64.tar.gz
RUN wget --no-cookies --header "Cookie: oraclelicense=accept-secure-backup-cookie" -O /tmp/jdk-8u141-linux-x64.tar.gz $JAVA_DOWNLOAD

# install java
RUN mkdir /opt/java-oracle && tar -zxf /tmp/jdk-8u141-linux-x64.tar.gz -C /opt/java-oracle/
ENV JAVA_HOME /opt/java-oracle/jdk$JAVA_VERSION
ENV PATH $JAVA_HOME/bin:$PATH
RUN update-alternatives --install /usr/bin/java java $JAVA_HOME/bin/java 20000 && update-alternatives --install /usr/bin/javac javac $JAVA_HOME/bin/javac 20000

WORKDIR /deeplearning4j-ui

# resolve mvn dependencies
ADD deeplearning4j-ui/pom.xml /deeplearning4j-ui/pom.xml
RUN ["mvn", "dependency:resolve"]
RUN ["mvn", "verify", "-Dmaven.test.skip=true"]

# package deeplearning4j-ui to jar
ADD deeplearning4j-ui /deeplearning4j-ui
RUN ["mvn", "package", "-Dmaven.test.skip=true"]

# clean
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# run
EXPOSE 9000
CMD ["java", "-cp", "target/deeplearning4j-ui-1.0-bin.jar", "xyz.grega.deeplearning4jui.Server"]


