# Using the Debian
FROM resin/raspberrypi3-python

#### Bluetooth setup for raspberrypi3
# Add the key for foundation repository
RUN apt-get update
RUN apt-get install wget
RUN wget http://archive.raspberrypi.org/debian/raspberrypi.gpg.key -O - | sudo apt-key add -

# Add apt source of the foundation repository
# We need this source because bluez needs to be patched in order to work with rpi3
# ( Issue #1314: How to get BT working on Pi3B. by clivem in raspberrypi/linux on GitHub https://github.com/raspberrypi/linux/issues/1314 )
# Add it on top so apt will pick up packages from there
RUN sed -i '1s#^#deb http://archive.raspberrypi.org/debian jessie main\n#' /etc/apt/sources.list
RUN apt-get update
####

# Install required packages
RUN apt-get install -yq --no-install-recommends bluetooth bluez bluez-firmware libbluetooth-dev

COPY ./requirements.txt /requirements.txt

RUN pip install -r /requirements.txt

WORKDIR /usr/src/app

COPY . ./

ENV INITSYSTEM on

# Start main program, setting up bluetooth in the script
CMD ["bash", "script.sh"]
