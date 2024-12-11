#!/bin/bash
IMAGE_NAME="myimage"
IMAGE_TAG="latest"
CONTAINER_NAME="app-cont"
SERVER_USER="ec2-user"
SERVER_IP="server-ip"
SSH_KEY="path-to-sshkey"
DOCKER_PORT=80
echo "docker login"
docker login -u usernmae -p pwd
echo "push image to registry"
docker push $IMAGE_NAME:$IMAGE_TAG
echo "connecting to server"
ssh -i $SSH_KEY
$SERVER_USER@$SERVER_IP << EOF
echo "pulling docker image"
docker pull $IMAGE_NAME:$IMAGE_TAG
echo "stopping existing docker container"
docker stop $CONTAINER_NAME || true
docker rm $CONTAINER_NAME || true
echo "running docker container"
docker run -d --name $CONTAINER_NAME -p $DOCKER_PORT:80 $IMAGE_NAME:$IMAGE_TAG
echo "deployment complete"