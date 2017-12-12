FROM ubuntu:17.10
MAINTAINER BitbuyIO
LABEL description="dockerized diamondd for running DMD Node"

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y \
    ca-certificates curl wget libssl-dev libboost-all-dev libminiupnpc-dev  && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN wget https://github.com/DMDcoin/Diamond/releases/download/3.0.0.13/Linux.3-0-0-13.tar.gz 

tar -xzf Linux.3-0-0-13.tar.gz 
cd Linux.3-0-0-13
./configure
make
sudo make install


WORKDIR /usr/src/diamond

RUN cd /usr/src/diamond && \ 
    ./autogen.sh && \
    ./configure && \
    make install && \
    rm -rf /usr/src/diamond

ENV HOME /diamond

VOLUME ["/diamond"]
EXPOSE 17771 17772
WORKDIR /diamond

CMD ["dmd_oneshot"]
