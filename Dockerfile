# This dockerfile builds the zap stable release
FROM centos:centos7
LABEL maintainer="Deven Phillips <deven.phillips@redhat.com>"

RUN yum install -y epel-release && \
    yum clean all && \
    yum install -y redhat-rpm-config \
    make automake autoconf gcc gcc-c++ libstdc++ libstdc++-devel java-1.8.0-openjdk wget curl \
    xmlstarlet git x11vnc gettext tar xorg-x11-server-Xvfb openbox xterm net-tools firefox \
    nss_wrapper java-1.8.0-openjdk-headless java-1.8.0-openjdk-devel nss_wrapper git-core \
    zlib zlib-devel patch readline readline-devel libyaml-devel libffi-devel openssl-devel \
    bzip2 libtool bison sqlite-devel && \
    curl -sL https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-installer | bash - && \
    echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc && \
    echo 'eval "$(rbenv init -)"' >> ~/.bashrc && \
    source ~/.bashrc && \
    mkdir -p /var/lib/jenkins/.vnc && \
    rbenv install 2.5.3 && \
    rbenv global 2.5.3

ADD SimpliTest /SimpliTest/

# Copy the entrypoint
COPY configuration/* /var/lib/jenkins/
COPY configuration/run-jnlp-client /usr/local/bin/run-jnlp-client
COPY .xinitrc /var/lib/jenkins/

ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/ \
    PATH=$JAVA_HOME/bin:$PATH \
    HOME=/var/lib/jenkins

WORKDIR /SimpliTest
# Download and expand the latest stable release 
RUN gem build SimpliTest.gemspec && \
    gem install SimpliTest && \
    chown root:root -R /var/lib/jenkins && \
    chmod 777 /var/lib/jenkins -R && \
    chmod 777 /usr/local/bin/run-jnlp-client

WORKDIR /var/lib/jenkins

# Run the Jenkins JNLP client
ENTRYPOINT ["/usr/local/bin/run-jnlp-client"]
