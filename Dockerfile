FROM skirschalethix/selenium-cucumber-centos
LABEL maintainer="Deven Phillips <deven.phillips@redhat.com>"

RUN yum install -y epel-release && \
    yum clean all && \
    yum install -y redhat-rpm-config \
    xmlstarlet x11vnc gettext \
    xorg-x11-server-Xvfb openbox xterm \
    net-tools nss_wrapper \
    
# Copy the entrypoint
COPY configuration/* /var/lib/jenkins/
COPY configuration/run-jnlp-client /usr/local/bin/run-jnlp-client

ENV JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk \
    PATH=$JAVA_HOME/bin:$PATH \
    HOME=/var/lib/jenkins

RUN chown root:root -R /var/lib/jenkins && \
    chmod 777 /var/lib/jenkins -R && \
    chmod 777 /usr/local/bin/run-jnlp-client

WORKDIR /var/lib/jenkins

# Run the Jenkins JNLP client
ENTRYPOINT ["/usr/local/bin/run-jnlp-client"]
