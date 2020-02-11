# corruptclient

##Build

docker build -t corruptclient .


##Run

docker run  -e CONNECTIONS=10 -e DURATION=2 -e THREADS=1 -e ENDPOINT="<Some HTTP/HTTPS endpoint" corruptclient
