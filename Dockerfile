FROM gregsi/docker-oracle-java8
MAINTAINER Grega Vrbančič <grega.vrbancic@gmail.com>

# get mvn
ENV MVN_VERSION 3.5.0
RUN wget -O /tmp/apache-maven-$MVN_VERSION.tar.gz http://archive.apache.org/dist/maven/maven-3/$MVN_VERSION/binaries/apache-maven-$MVN_VERSION-bin.tar.gz

# install mvn
RUN tar xzf /tmp/apache-maven-$MVN_VERSION.tar.gz -C /opt/
RUN ln -s /opt/apache-maven-$MVN_VERSION /opt/maven
RUN ln -s /opt/maven/bin/mvn /usr/local/bin
RUN rm -f /tmp/apache-maven-$MVN_VERSION.tar.gz
ENV MAVEN_HOME /opt/maven

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
