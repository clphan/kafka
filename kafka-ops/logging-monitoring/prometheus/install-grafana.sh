# Download binary source
mkdir grafana
cd grafana
wget https://dl.grafana.com/enterprise/release/grafana-enterprise-8.2.3.linux-amd64.tar.gz
tar -zxvf grafana-enterprise-8.2.3.linux-amd64.tar.gz
rm grafana-enterprise-*.linux-amd64.tar.gz
mv grafana-*/ grafana
cd grafana

# Create systemd service for grafana 
sudo vi /etc/systemd/system/grafana.service
  # Copy the following lines into grafana.service file
  [Unit]
  Description=Grafana server
  After=network-online.target

  [Service]
  User=ec2-user
  WorkingDirectory=/home/ec2-user/grafana
  ExecStart=/home/ec2-user/grafana/grafana/bin/grafana-server

  [Install]
  WantedBy=multi-user.target