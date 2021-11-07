# Install prometheus agent
mkdir prometheus
wget https://repo1.maven.org/maven2/io/prometheus/jmx/jmx_prometheus_javaagent/0.16.1/jmx_prometheus_javaagent-0.16.1.jar
wget https://raw.githubusercontent.com/prometheus/jmx_exporter/master/example_configs/kafka-2_0_0.yml
# Update systemD file
vi /etc/systemd/system/kafka.service

sudo yum install net-tools
sudo vi /etc/systemd/system/kafka.service
[Unit]
Description=Kafka
After=network.target

[Service]
User=ec2-user
Group=ec2-user
Environment="KAFKA_HEAP_OPTS=-Xmx256M -Xms128M"
Environment="KAFKA_OPTS=-javaagent:/home/ec2-user/prometheus/jmx_prometheus_javaagent-0.16.1.jar=8080:/home/ec2-user/prometheus/kafka-2_0_0.yml"
ExecStart=/home/ec2-user/kafka/bin/kafka-server-start.sh /home/ec2-user/kafka.properties
SuccessExitStatus=143

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
cd /prometheus
vi prometheus.yml
  # delete all then copy the following lines
  global:
    scrape_interval: 15s
    evaluation_interval: 15s
  alerting:
    alertmanagers:
      - static_configs:
        - targets:
          # - <LERT_HOST>:9093
  scape_configs:
    - job_name: 'kafka'
      static_configs:
      - targets:
        - <KAFKA_HOST>:8080
    - job_name: 'zookeeper'
      static_configs:
        - targets:
          - <ZOOKEEPER_HOST>:8080

# Setup systemD for prometheus
sudo vi /etc/systemd/system/prometheus.service
  # Copy the following lines
  [Unit]
  Description=Prometheus
  After=network-online.target

  [Service]
  User=ec2-user
  Group=ec2-user
  SyslogIdentifier=prometheus
  ExecStart=/home/ec2-user/prometheus/prometheus/prometheus --config.file=/home/ec2-user/prometheus/prometheus/prometheus.yml --storage.tsdb.path=/home/ec2-user/prometheus/prometheus/data
  SuccessExitStatus=143

  [Install]
  WantedBy=multi-user.target