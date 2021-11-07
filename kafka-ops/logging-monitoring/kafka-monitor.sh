# Install kafka-monitor
git clone https://github.com/linkedin/kafka-monitor.git
cd kafka-monitor 
./gradlew jar

# Update config file
vi config/xinfra-monitor.properties
# Find and change the following line
"zookeeper.connect": "localhost:2181" => "zookeeper.connect": "<ZOOKEEPER_HOST:2181" 
# example: "zookeeper.connect": "172.31.17.151:2181"
"bootstrap.servers": "localhost:9092,localhost:9093" => "bootstrap.servers": "<BROKER1_HOST>:<BROKER_PORT>,<BROKER2_HOST>:<BROKER_PORT>"
# example: "bootstrap.servers": "172.31.26.197:9092"

# Start kafka-monitor from command
cd kafka-monitor 
./bin/xinfra-monitor-start.sh config/xinfra-monitor.properties