#! /bin/bash
docker run -d --name netbeans -ti -e DISPLAY=host.docker.internal:0 -v /tmp/.X11-unix:/tmp/.X11-unix -v $(pwd)/projects:/home/netbeans netbns
