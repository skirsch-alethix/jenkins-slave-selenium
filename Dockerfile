FROM skirschalethix/selenium-cucumber-centos
LABEL maintainer="Deven Phillips <deven.phillips@redhat.com>"

# Copy the entrypoint
COPY configuration/* /var/lib/jenkins/
COPY configuration/run-jnlp-client /usr/local/bin/run-jnlp-client

ENV HOME=/var/lib/jenkins

RUN chown root:root -R /var/lib/jenkins && \
    chmod 777 /var/lib/jenkins -R

WORKDIR /var/lib/jenkins

# Run the Jenkins JNLP client
ENTRYPOINT ["/usr/local/bin/run-jnlp-client"]
