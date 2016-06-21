FROM resin/raspberrypi3-python:latest

RUN apt-get update \
    && apt-get install -yq bluetooth bluez bluez-firmware libbluetooth-dev

WORKDIR /usr/src/app

COPY ./requirements.txt /requirements.txt

RUN pip install -r /requirements.txt

COPY . ./

ENV INITSYSTEM on

CMD ["python","src/main.py"]