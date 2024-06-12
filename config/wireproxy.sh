#!/bin/bash
apt update 
apt install make -y
snap install go --classic

# Clone wireproxy repository
cd /root/
sudo git clone https://github.com/octeep/wireproxy 
cd /root/wireproxy 

# Compile wireproxy
sudo make

# Move binary to /usr/local/bin
sudo mkdir -p /usr/local/bin/wireproxy
sudo mv /root/wireproxy/* /usr/local/bin/wireproxy
sudo chmod +x /usr/local/bin/wireproxy

# Create configuration directory and download config file
sudo mkdir -p /usr/local/etc/wireproxy
sudo wget -O /usr/local/etc/wireproxy/wireproxy.conf https://raw.githubusercontent.com/kaccang/makan/main/config/wire

# Create systemd service file
sudo tee /etc/systemd/system/wireproxy.service > /dev/null <<EOF
[Unit]
Description=WireProxy Service
After=network.target

[Service]
ExecStart=/usr/local/bin/wireproxy/wireproxy -c /usr/local/etc/wireproxy/wireproxy.conf
Restart=on-failure
User=nobody
Group=nogroup

[Install]
WantedBy=multi-user.target
EOF

# Reload systemd, enable and start wireproxy service
sudo systemctl daemon-reload
sudo systemctl enable wireproxy
sudo systemctl start wireproxy
sudo systemctl status wireproxy

cd
