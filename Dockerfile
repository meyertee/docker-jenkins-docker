# TeamCity Agent Dockerfile
# docker run -e TEAMCITY_SERVER=http://teamcity:8111 -dt -p 9090:9090 meyertee/teamcity-agent

FROM meyertee/jenkins

MAINTAINER Thomas Meyer <thomas@meyertee.com>

#ENV DOCKER_HOST unix:///var/run/docker.sock
ENV DOCKER_HOST tcp://127.0.0.1:2375
ENV REGISTRY_HOSTNAME registry
ENV REGISTRY_PORT 5000
ENV REGISTRY_ADDRESS http://registry:5000

USER root

VOLUME /var/lib/docker

RUN apt-get update && apt-get install -y sudo docker.io
RUN echo "DOCKER_OPTS=\"-H=$DOCKER_HOST --insecure-registry $REGISTRY_HOSTNAME:$REGISTRY_PORT\"" >> /etc/default/docker

CMD service docker start; /usr/local/bin/jenkins.sh
