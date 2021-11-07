# Install kafka
  wget -P /home/ec2-user https://dlcdn.apache.org/kafka/3.0.0/kafka_2.13-3.0.0.tgz
  tar xf /home/ec2-user/kafka_2.13-3.0.0.tgz -C /home/ec2-user
  ln -s /home/ec2-user/kafka_2.13-3.0.0 /home/ec2-user/kafka
  chown -R ec2-user:ec2-user /home/ec2-user/kafka /home/ec2-user/kafka_2.13-3.0.0
  rm /home/ec2-user/kafka_2.13-3.0.0.tgz

# Install java
sudo yum install -y java-1.8.0-openjdk-devel

# Mount file system
  Check disk:
    lsblk
    sudo mkfs -t xfs /dev/xvdb
    sudo mkdir -p /data/kafka
    sudo mount /dev/xvdb /data/kafka
    sudo chown -R ec2-user:ec2-user /data/kafka
    # Create backup file 
    sudo cp /etc/fstab /etc/fstab.orig
    # find UUID
    sudo blkid
    sudo vim /etc/fstab
    # Add the following file example: UUID = 660d453f-012d-48df-922c-f81d0d6cca5f
    # UUID="bdb8ca97-1e7e-4a22-8654-7cdd501e3895 /data/kafka  xfs  defaults,nofail  0  2
    UUID=<UUID>  /data/kafka  xfs  defaults,nofail  0  2

# Export PATH
  vi .bash_profile
  copy the following line:
    DAEMON_PATH=/home/ec2-user/kafka/bin
    export PATH=$PATH:$DAEMON_PATH
    export KAFKA_HEAP_OPTS="-Xmx256M -Xms128M"

# Setup systemD
sudo yum install net-tools
sudo vi /etc/systemd/system/kafka.service
[Unit]
Description=Kafka
After=network.target

[Service]
User=ec2-user
Group=ec2-user
Environment="KAFKA_HEAP_OPTS=-Xmx256M -Xms128M"
ExecStart=/home/ec2-user/kafka/bin/kafka-server-start.sh /home/ec2-user/kafka.properties
SuccessExitStatus=143

[Install]
WantedBy=multi-user.target
  # Change mode 
  sudo chmod 755 /etc/systemd/system/kafka.service

# Start kafka service 
systemctl enable kafka.service
systemctl start kafka.service

