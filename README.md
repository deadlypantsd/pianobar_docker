# Pianobar streamer to Icecast Server
##### _Stream pianobar audio output to an Icecast Server... and beyond!_
### About
This container provides an easy button to stream a Pandora station to an icecast server. (I use this for HomeAssistant media_player entities)

##### ENV Vars

- USER=[email@example.com]
- PASSWORD=[supersecretpassword]
- STATION_ID: (Optional, see below.)


- SHOUT_SERVER=[ex. 172.16.0.5:8000]
- SHOUT_AUTH=[source:hackme] (or whatever you changed it to in icecast)
- SHOUT_MOUNT=[mountpoint] (name of the icecast stream)



##### Station ID
STATION_ID is used to autostart a specific station that you've collected on Pandora. I use them for my HomeAssistant Setup to choose music for an individual media_player entity or the mrp_player package that I have put together.
The station ID can be retrieved 2 ways; from pianobar itself, or a web browser. Not providing a station ID will result in the last station played in pianobar to resume.
###### Pianobar:
> [!NOTE]
> You can 'screen -r pianobar' in an attached console, or run pianobar via local commandline for this part...

`101016533437788715` is the station ID in the example below. 
Press 's' to get a list of your stations and retrieve it's ID:

```
# pianobar
Welcome to pianobar (2020.11.28)! Press ? for a list of commands.
(i) Login... Ok.
(i) Get stations... Ok.
|>  Station "QuickMix" (101016533437788715)
(i) Receiving new playlist... Ok.
[...]
[press 's']
0)     Today's Hits Radio
1)     QuickMix
[?] Select station:
```
###### Pandora Radio website:
When you play a station on the website, the url in your browser gives you the station ID: `https://www.pandora.com/station/play/<station id>`


### Docker
##### Build it!
Now that we've gotten all that out of the way, build the image with the following command:
```sh
# docker build https://github.com/deadlypantsd/pianobar_docker/Dockerfile -t <imagename>
```
`<imagename>` can be anything... but I would suggest 'pianobar'.
##### Run it!
Create the container. I find the commandline to be much easier.
```sh
# docker run -it -d --name pianobar-stream \
  -e SHOUT_SERVER=172.16.0.5:8000 \
  -e SHOUT_AUTH=source:hackme \
  -e SHOUT_MOUNT=stream \
  -e USER=email@example.com \
  -e PASSWORD=supersecretpassword \
  -e STATION_ID=101016533437788715 \
  pianobar
```

##### Done!


