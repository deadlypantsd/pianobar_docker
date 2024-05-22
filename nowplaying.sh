while true;
do
  export NOWPLAYING=`tail -n 2 ~/nowplaying.txt | head -n 1 | sed 's/.*|>\ \ //g' | sed 's/\ on.*//g' | awk -F '\ on\ ' '{print $2 $1 ;}' | sed 's:\ by\ :\ -\ :g'|sed 's/\"//g' | urlencode`;
  curl -s --user $sHOUT_AUTH -X "GET" "http://$SHOUT_SERVER/admin/metadata.xsl?song=$NOWPLAYING&mount=%2F$SHOUT_MOUNT&mode=updinfo" > /dev/null;
  sleep 2;
done
