FROM quay.io/centos/centos:stream9

# Install Java & tools
RUN yum install -y java-11-openjdk wget tar \
    && yum clean all

# Set working directory
WORKDIR /opt

# Download and extract Tomcat
RUN wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.108/bin/apache-tomcat-9.0.108.tar.gz \
    && tar -xzf apache-tomcat-9.0.108.tar.gz \
    && rm apache-tomcat-9.0.108.tar.gz

# Set Tomcat home
ENV CATALINA_HOME=/opt/apache-tomcat-9.0.108
WORKDIR $CATALINA_HOME

# Copy WAR file into Tomcat's webapps directory
COPY student.war $CATALINA_HOME/webapps/

# Copy JDBC connector JAR into Tomcat lib directory
COPY mysql-connector.jar $CATALINA_HOME/lib/

# Copy custom context.xml into conf directory
COPY context.xml $CATALINA_HOME/conf/context.xml

# Expose Tomcat port
EXPOSE 8080

# Start Tomcat
CMD ["./bin/catalina.sh", "run"]

