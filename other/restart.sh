#!/bin/bash

red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
bl='\e[36;1m'
bd='\e[1m'

clear
echo -e ""
echo -e "======================================"| lolcat 
echo -e ""
echo -e "           Restart Services Menu           "
echo -e ""
echo -e "    $bl[$bd 1 $bl]\e[m$bd Restart All Services"
echo -e "    $bl[$bd 2 $bl]\e[m$bd Restart Xray"
echo -e "    $bl[$bd 3 $bl]\e[m$bd Restart Nginx"
echo -e "    $bl[$bd 4 $bl]\e[m$bd Restart Wireproxy"
echo -e "    $bl[$bd x $bl]\e[m$bd Exit"
echo -e ""
read -p "    Select From Options [1-4 or x] :  " Restart
echo -e ""
echo -e "======================================"| lolcat
sleep 1
clear
case $Restart in
                1)
                clear
                systemctl restart xray
                systemctl restart nginx
                systemctl restart wireproxy
                echo -e ""
                echo -e "======================================"| lolcat
                echo -e ""
                echo -e "         All Services Restarted        "
                echo -e ""
                echo -e "======================================"| lolcat
                exit
                ;;
                2)
                clear
                systemctl restart xray
                echo -e ""
                echo -e "======================================"| lolcat
                echo -e ""
                echo -e "           Xray Service Restarted        "
                echo -e ""
                echo -e "======================================"| lolcat
                exit
                ;;
                3)
                clear
                systemctl restart nginx
                echo -e ""
                echo -e "======================================"| lolcat
                echo -e ""
                echo -e "           Nginx Service Restarted      "
                echo -e ""
                echo -e "======================================"| lolcat
                exit
                ;;
                4)
                clear
                systemctl restart wireproxy
                echo -e ""
                echo -e "======================================"| lolcat
                echo -e ""
                echo -e "        Wireproxy Service Restarted    "
                echo -e ""
                echo -e "======================================"| lolcat
                exit
                ;;
                x)
                clear
                exit
                ;;
        esac
