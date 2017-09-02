FROM resin/rpi-raspbian:latest

# Based on http://blog.bennymichielsen.be/2016/03/14/getting-up-and-running-with-mono-and-raspberry-pi-3/

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF

RUN echo "deb http://download.mono-project.com/repo/debian jessie main" | sudo tee /etc/apt/sources.list.d/mono-xamarin.list

RUN apt-get update -y && apt-get install mono-runtime -y