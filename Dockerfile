# pianobar => vlc => icecast stream with archlinux
#
# VERSION               0.0.2

FROM	 archlinux:latest
MAINTAINER 	Dan Midthun <dan _DOT_ midthun _AT_ gmail _DOT_ com>

# Install things with updated repos
RUN	 pacman -Syu --noconfirm alsa-lib alsa-utils curl libshout pianobar pulseaudio nano screen vlc git binutils fakeroot make autoconf automake gcc debigedit

# Fix makepkg, Download urlencode & install
RUN  sed -i '1229d' /usr/bin/makepkg
RUN git clone https://aur.archlinux.org/urlencode.git
RUN (cd urlencode && makepkg -i --noconfirm)

# Fix vlc, libao, makepkg
RUN  sed -i 's/geteuid/getppid/' /usr/bin/vlc
RUN  rm /etc/libao.conf
RUN  echo "default_driver=pulse" > /etc/libao.conf

ADD  nowplaying.sh /root/nowplaying.sh
ADD  .bashrc /root/.bashrc

RUN  chmod +x /root/nowplaying.sh
