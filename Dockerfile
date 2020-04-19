FROM ubuntu:18.04
RUN \
  apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y lxde-core lxterminal tightvncserver firefox nano && \
  rm -rf /var/lib/apt/lists/*

RUN touch /root/.Xresources
RUN touch /root/.Xauthority

WORKDIR /root
RUN mkdir .vnc
COPY xstartup /root/.vnc/
RUN echo "export USER=root" >> /root/.bashrc
ENV USER root
COPY entrypoint.sh /entrypoint.sh
RUN printf "maketest\nmaketest\nn\n" | vncpasswd

ENTRYPOINT ["/entrypoint.sh" ]

