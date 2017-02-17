FROM resin/rpi-raspbian:jessie-20160511

ENV INITSYSTEM=on

RUN apt-get update \
  && apt-get -y install python-imaging git libfuse-dev \
     ca-certificates build-essential pkg-config fonts-freefont-ttf \
     qrencode imagemagick ghostscript

# Install the PaPiRus API
WORKDIR /usr/src
RUN git clone https://github.com/PiSupply/PaPiRus.git
WORKDIR /usr/src/PaPiRus
RUN python setup.py install

# Install the PaPiRus driver
WORKDIR /usr/src
RUN git clone https://github.com/repaper/gratis.git
WORKDIR /usr/src/gratis/PlatformWithOS
RUN git checkout ab46fd7
RUN make rpi PANEL_VERSION=V231_G2
RUN make rpi-install PANEL_VERSION=V231_G2

WORKDIR /app
COPY . ./

CMD ./prestart.sh && ./start.sh ; sleep infinity
