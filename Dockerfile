FROM alpine:3.10

ENV LANG C.UTF-8


RUN echo 'Installing openjdk and basics' && \
    apk --no-cache --update add \
    openjdk8 openjdk8-dbg

RUN apk --no-cache --update add \
    cmake g++ git linux-headers libpthread-stubs make gradle

RUN apk --no-cache --update add \
    bash bash-completion coreutils file openssl openssh font-noto

RUN apk --no-cache --update add \
    gdb musl-dbg strace

ADD state.xml /tmp/state.xml

RUN echo 'Downloading netbeans' && \
    wget -c http://download.netbeans.org/netbeans/8.2/final/bundles/netbeans-8.2-linux.sh -O /tmp/netbeans.sh -q && \
    chmod +x /tmp/netbeans.sh && \
    echo 'Installing netbeans' && \
    /tmp/netbeans.sh --silent --state /tmp/state.xml && \
    rm -rf /tmp/*

# ADD run /usr/local/bin/netbeans

# 'shadow' gives the capabilities to create an user 
RUN chmod +x /usr/local/netbeans-8.2/bin/netbeans && \
    apk --no-cache --update add shadow && \
    useradd --create-home --shell /bin/bash netbeans && \
    passwd -d netbeans && \
    chmod 777 /home/netbeans/



USER netbeans
ENV HOME /home/netbeans
WORKDIR /home/netbeans

CMD /usr/local/netbeans-8.2/bin/netbeans

