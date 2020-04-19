FROM ubuntu:18.04
RUN \
  apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y lxde-core lxterminal tightvncserver firefox nano && \
  rm -rf /var/lib/apt/lists/*

# INSTALL ROS Melodic
RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
RUN apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654
RUN apt update
RUN apt install -y ros-melodic-desktop-full
RUN echo "source /opt/ros/melodic/setup.bash" >> ~/.bashrc && source ~/.bashrc
RUN sudo apt install -y python-rosdep python-rosinstall python-rosinstall-generator python-wstool build-essential


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

