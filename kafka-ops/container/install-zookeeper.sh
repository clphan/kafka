# Install kafka
  wget -P /home/ec2-user https://dlcdn.apache.org/kafka/3.0.0/kafka_2.13-3.0.0.tgz
  tar xf /home/ec2-user/kafka_2.13-3.0.0.tgz -C /home/ec2-user
  ln -s /home/ec2-user/kafka_2.13-3.0.0 /home/ec2-user/kafka
  chown -R ec2-user:ec2-user /home/ec2-user/kafka /home/ec2-user/kafka_2.13-3.0.0
  rm /home/ec2-user/kafka_2.13-3.0.0.tgz

# Install java
sudo yum install openjdk-1.8.0-jdk
# Mount file system
  Check disk:
    lsblk
    sudo mkfs -t xfs /dev/xvdb
    sudo mkdir -p /data/zookeeper
    sudo mount /dev/xvdb /data/zookeeper
    sudo chown -R ec2-user:ec2-user /data/zookeeper
    # Create backup file 
    sudo cp /etc/fstab /etc/fstab.orig
    # find UUID
    sudo blkid
    sudo vim /etc/fstab
    # Add the following file example: UUID = 660d453f-012d-48df-922c-f81d0d6cca5f
    # UUID=660d453f-012d-48df-922c-f81d0d6cca5f /data/kafka  xfs  defaults,nofail  0  2
    UUID=<UUID>  /data/zookeeper  xfs  defaults,nofail  0  2

# Export PATH
  vi .bash_profile
  copy the following line:
    DAEMON_PATH=/home/ec2-user/kafka/bin
    export PATH=$PATH:$DAEMON_PATH
    export KAFKA_HEAP_OPTS="-Xmx256M -Xms128M"

# Setup systemD
# Install net-tools
sudo yum install net-tools
sudo vi /etc/systemd/system/zookeeper.service
  # copy and past the following code
  [Unit]
  Description=Zookeeper
  After=network.target

  [Service]
  User=ec2-user
  Group=ec2-user
  SyslogIdentifier=zookeeper
  ExecStart=/home/ec2-user/kafka/bin/zookeeper-server-start.sh /home/ec2-user/zookeeper.properties
  SuccessExitStatus=143

  [Install]
  WantedBy=multi-user.target
  # Change mode 
  sudo chmod 755 /etc/systemd/system/zookeeper.service

# Start zookeeper service 
systemctl enable zookeeper.service
systemctl start zookeeper.service