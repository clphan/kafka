# Install prometheus agent
mkdir prometheus
wget https://repo1.maven.org/maven2/io/prometheus/jmx/jmx_prometheus_javaagent/0.16.1/jmx_prometheus_javaagent-0.16.1.jar
wget https://raw.githubusercontent.com/prometheus/jmx_exporter/master/example_configs/zookeeper.yaml
# Update systemD file
vi /etc/systemd/system/zookeeper.service
  [Unit]
  Description=Zookeeper
  After=network.target

  [Service]
  User=ec2-user
  Group=ec2-user
  SyslogIdentifier=zookeeper
  Environment="KAFKA_OPTS=-javaagent:/home/ec2-user/prometheus/jmx_prometheus_javaagent-0.16.1.jar=8080:/home/ec2-user/prometheus/zookeeper.yaml"
  ExecStart=/home/ec2-user/kafka/bin/zookeeper-server-start.sh /home/ec2-user/zookeeper.properties
  SuccessExitStatus=143

  [Install]
  WantedBy=multi-user.target

# Restart kafka service 
sudo systemctl restart kafka

# Install prometheus
mkdir prometheus 
cd prometheus
wget https://github.com/prometheus/prometheus/releases/download/v2.31.1/prometheus-2.31.1.linux-amd64.tar.gz
tar -xzf prometheus-*.tar.gz
mv prometheus-*linux-amd64 prometheus
rm prometheus-*.tar.gz

# Update prometheus yaml file 

  # delete all then copy the following lines


# Setup systemD for prometheus
sudo vi /etc/systemd/system/prometheus.service
  # Copy the following lines
