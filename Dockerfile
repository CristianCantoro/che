FROM ubuntu
RUN apt-get update && apt-get -y install curl sudo procps wget
RUN echo "%sudo ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    groupadd -g 6139 dbtrento && \
    useradd -u 1000 -G users,dbtrento,sudo -d /home/eclipse --shell /bin/bash -m eclipse && \
    echo "secret\nsecret" | passwd eclipse && \
    curl -sSL https://get.docker.com/ | sh && \
    usermod -aG docker eclipse && sudo apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
    
USER eclipse
ENV JAVA_VERSION=8u65 \
    JAVA_VERSION_PREFIX=1.8.0_65 \
    CHE_LOCAL_CONF_DIR=/home/eclipse/.che
RUN mkdir /home/eclipse/.che && \
    wget \
   --no-cookies \
   --no-check-certificate \
   --header "Cookie: oraclelicense=accept-securebackup-cookie" \
   -qO- \
   "http://download.oracle.com/otn-pub/java/jdk/$JAVA_VERSION-b17/jre-$JAVA_VERSION-linux-x64.tar.gz" | sudo tar -zx -C /opt/
ENV JAVA_HOME /opt/jre$JAVA_VERSION_PREFIX
ENV PATH $JAVA_HOME/bin:$PATH

EXPOSE 8080

ADD /assembly/assembly-main/target/eclipse-che-*/eclipse-che-* /home/eclipse/che

CMD sudo chown -R eclipse:dbtrento /home/eclipse && \
    rm -rf /home/eclipse/che/lib-copy/* && \
    mkdir -p /home/eclipse/che/lib-copy/ && \
    cp -rf /home/eclipse/che/lib/* /home/eclipse/che/lib-copy && \
    /home/eclipse/che/bin/che.sh run
