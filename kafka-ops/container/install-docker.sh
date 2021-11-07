# Install docker & docker compose 
sudo yum install -y docker
sudo systemctl start docker.service
sudo usermod -a -G docker ec2-user
sudo curl -L https://github.com/docker/compose/releases/download/1.21.2/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
exit 

# Start kafka manager
docker run -d \
     -p 9000:9000  \
     -e ZK_HOSTS="172.31.17.151:2181" \
     hlebalbau/kafka-manager:stable

# Start zoonavigator
docker run \
  -d --network host \
  -e HTTP_PORT=9001 \
  --name zoonavigator \
  --restart unless-stopped \
  elkozmon/zoonavigator:latest
