#!/bin/bash

sleep 3
echo "-------------------------------------"
echo "ReverseProxy Script"
echo "By Mastermined"
echo "https://github.com/Mastermined69/ReverseProxyScript"
echo "--------------------------------------"

read -p "What domain do you want to use to proxy. (Example: example.com): " $proxydomain
echo "$proxydomain is about to get proxied, if it isn't right do CTRL+C. You have 5 seconds"
sleep 5
read -p "What is the servers domain (not by URL): " $serverdomain
echo "$serverdomain is about to be used to proxy $proxydomain, if it ins't rught do CTRL+C. You have 5 seconds."
read -p "What should be the name of the name of the config file: (Don't use .conf at the end and dont use the same name twice): " $configfile
echo "Configuration file is ready to be setup, Setting up SSL certificates..."
certbot certonly --nginx -d $proxydomain
echo "SSL ready! Creating config file $configfile.conf..."
pause 3
cd /etc/nginx/sites-available
sudo wget -O /etc/nginx/sites-available/$configfile.conf https://raw.githubusercontent.com/Mastermined69/ReverseProxyScript/main/proxy.conf
sleep 8
sed -s 's%PASS%'http://$serverdomain'%g' /etc/nginx/sites-available/$configfile.conf
sed -s 's/P_DOMAIN/'$proxydomain'/g' /etc/nginx/sites-available/$configfile.conf
sudo nginx -t
sudo nginx -s reload
echo "Setting the link..."
In -s /etc/nginx/sites-available/$configfile.conf /etc/nginx/sites-enabled
echo "Proxy is setup, Restarting Nginx!"
sleep 3
systemctl restart nginx
echo "If this doesnt work, please report it to the Github Repo!"
sleep 3
sudo nginx -t
echo "If it does say "ok", You can now navigate to $proxydomain if you have set everything up correctly."
