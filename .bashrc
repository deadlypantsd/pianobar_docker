pulseaudio -D --exit-idle-time=-1
sleep 2
pacmd load-module module-virtual-sink sink_name=v1
pacmd set-default-sink v1
pacmd set-default-source v1.monitor

mkdir -p $HOME/.config/pianobar

echo user = $USER > $HOME/.config/pianobar/config
echo password = $PASSWORD >> $HOME/.config/pianobar/config
echo autostart_station = $STATION_ID >> $HOME/.config/pianobar/config

screen -S vlc.restream -dm cvlc pulse://v1.monitor --sout '#transcode{vcodec=none,acodec=mp3,ab=128,channels=2,samplerate=44100,scodec=none}:std{access=shout{mp3},mux=raw,dst='$SHOUT_AUTH'@'$SHOUT_SERVER'/'$SHOUT_MOUNT'}'
screen -S pianobar -dm bash -c "pianobar | tee /root/nowplaying.txt"
screen -S metadata -dm bash -c "/root/nowplaying.sh"