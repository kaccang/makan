#!/bin/bash

NC='\e[0m'
DEFBOLD='\e[39;1m'
RB='\e[31;1m'
GB='\e[32;1m'
YB='\e[33;1m'
BB='\e[34;1m'
MB='\e[35;1m'
CB='\e[35;1m'
WB='\e[37;1m'

clear
echo -n >/tmp/other.txt
data=($(cat /usr/local/etc/xray/config.json | grep '^#@' | cut -d ' ' -f 2 | sort | uniq))
echo -e "${BB}————————————————————————————————————————————————————${NC}"
echo -e "              ${WB}Vmess User Login Account${NC}              "
echo -e "${BB}————————————————————————————————————————————————————${NC}"

for akun in "${data[@]}"; do
    if [[ -z "$akun" ]]; then
        akun="Tidak Ada"
    fi
    
    echo -n >/tmp/ipvmess.txt
    
    # Mengambil IP unik dari log
    data2=($(tail -n 500 /var/log/xray/access.log | awk -F " from | accepted " '{print $2}' | cut -d ":" -f 1 | sort | uniq))
    
    for ip in "${data2[@]}"; do
        # Menghitung jumlah koneksi untuk akun ini
        jum=$(grep "email: $akun" /var/log/xray/access.log | grep -w "$ip" | wc -l)
        
        # Jika ada koneksi, simpan IP ke file sementara
        if [[ "$jum" -gt 0 ]]; then
            echo "$ip" >>/tmp/ipvmess.txt
        else
            echo "$ip" >>/tmp/other.txt
        fi
    done
    
    jum=$(cat /tmp/ipvmess.txt)
    if [[ -z "$jum" ]]; then
        echo >/dev/null
    else
        jum2=$(cat /tmp/ipvmess.txt | nl)
        echo "user : $akun"
        echo "$jum2" | grep -v "tcp"  # Menghilangkan kata 'tcp'
        echo -e "${BB}————————————————————————————————————————————————————${NC}"
    fi
    
    rm -rf /tmp/ipvmess.txt
done

rm -rf /tmp/other.txt
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
vmess
