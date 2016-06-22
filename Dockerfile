FROM resin/raspberrypi3-python

# Add the key for foundation repository
RUN apt-get update
RUN apt-get install wget
RUN wget http://archive.raspberrypi.org/debian/raspberrypi.gpg.key -O - | sudo apt-key add -

# Add apt source of the foundation repository
# We need this source because bluez needs to be patched in order to work with rpi3 ( Issue #1314: How to get BT working on Pi3B. by clivem in raspberrypi/linux on GitHub )
# Add it on top so apt will pick up packages from there
RUN sed -i '1s#^#deb http://archive.raspberrypi.org/debian jessie main\n#' /etc/apt/sources.list
RUN apt-get update

# Install required packages
RUN apt-get install bluez bluez-firmware

WORKDIR usr/src/app

COPY scan.sh ./

CMD ["bash", "scan.sh"]
