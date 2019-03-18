FROM skirschalethix/selenium-cucumber-centos:v1
LABEL maintainer="Deven Phillips <deven.phillips@redhat.com>"

RUN yum clean all && \
    yum install -y redhat-rpm-config \
    xmlstarlet x11vnc gettext \
    xorg-x11-server-Xvfb openbox xterm \
    net-tools nss_wrapper \
    java-1.8.0-openjdk-headless
    
# Copy the entrypoint
COPY configuration/* /var/lib/jenkins/
COPY configuration/run-jnlp-client /usr/local/bin/run-jnlp-client

ENV JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk \
    GEM_PATH=/usr/local/rvm/gems/ruby-2.5.3:/usr/local/rvm/gems/ruby-2.5.3@global \
    GEM_HOME=/usr/local/rvm/gems/ruby-2.5.3 \
    PATH=$JAVA_HOME/bin:/usr/local/rvm/rubies/ruby-2.5.3/bin:/usr/local/rvm/gems/ruby-2.5.3/bin:$PATH \
    HOME=/var/lib/jenkins

RUN chown root:root -R /var/lib/jenkins && \
    chmod 777 /var/lib/jenkins -R && \
    chmod 777 /usr/local/bin/run-jnlp-client

WORKDIR /var/lib/jenkins

# Run the Jenkins JNLP client
ENTRYPOINT ["/usr/local/bin/run-jnlp-client"]
