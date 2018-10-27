chmod +x wait_for_it.sh

# Clean the volumes if present
rm -rf ./tmp

# Create new volumes for docker-compose services
mkdir -p ./tmp/db
mkdir -p ./tmp/graphite/configs
mkdir -p ./tmp/graphite/data
mkdir -p ./tmp/statsd


# Build the docker-compose file
docker-compose build

#Initialize the docker swarm
docker swarm init

#Deploy the stack on the swarm
#Might have to wait a few seconds before all the containers are up and running
docker stack deploy --compose-file docker-compose.yml futstat


