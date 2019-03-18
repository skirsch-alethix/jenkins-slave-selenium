FROM skirschalethix/selenium-cucumber-centos
LABEL maintainer="Deven Phillips <deven.phillips@redhat.com>"

# Copy the entrypoint
COPY configuration/* /var/lib/jenkins/
COPY configuration/run-jnlp-client /usr/local/bin/run-jnlp-client

ENV JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk/ \
    HOME=/var/lib/jenkins

RUN chown root:root -R /var/lib/jenkins && \
    chmod 777 /var/lib/jenkins -R && \
    chmod 777 /usr/local/bin/run-jnlp-client

WORKDIR /var/lib/jenkins

# Run the Jenkins JNLP client
ENTRYPOINT ["/usr/local/bin/run-jnlp-client"]
