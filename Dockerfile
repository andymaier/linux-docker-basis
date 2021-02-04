FROM ubuntu:18.04
RUN  apt-get update

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y lxde-core lxterminal
RUN apt-get -y install tightvncserver firefox nano

# files for VNC
RUN touch /root/.Xresources
RUN touch /root/.Xauthority
WORKDIR /root
RUN mkdir .vnc

# COPY xstartup with start for lxde
COPY xstartup /root/.vnc/
RUN echo "export USER=root" >> /root/.bashrc
ENV USER root
# COPY script. removes Lock files and start tightvncserver
COPY entrypoint.sh /entrypoint.sh
# set password
RUN printf "maketest\nmaketest\nn\n" | vncpasswd
ENTRYPOINT ["/entrypoint.sh" ]
