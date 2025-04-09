#! /bin/bash

# update .bashrc with proxy (EN) settings:

IP=172.17.3.64
PORT=80

echo -e "\nUpdating .bashrc with proxy (EN) settings ..."
echo -e "\n#ADDED 20190119" >> .bashrc
echo 'export http_proxy=http://${IP}:${PORT}/' >> ~/.bashrc
echo 'export https_proxy=http://${IP}:${PORT}/' >> ~/.bashrc
echo 'export HTTP_PROXY=http://${IP}:${PORT}/' >> ~/.bashrc
echo 'export HTTPS_PROXY=http://${IP}:${PORT}/' >> ~/.bashrc
echo "Done."


# update apt.conf with proxy (EN) settings:
echo -e "\nUpdating apt.conf with proxy (EN) settings ..."
echo "Creating /etc/apt/apt.conf.d/05proxy ..."
sudo touch /etc/apt/apt.conf.d/05proxy

echo "Adding proxy (EN) settings to /etc/apt/apt.conf.d/05proxy ..."
sudo echo 'Acquire::http::Proxy "http://${IP}:${PORT}/";' >> /etc/apt/apt.conf.d/05proxy
echo "Done."

