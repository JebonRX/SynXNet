#!/bin/bash
############
# detail vps
OS=$(hostnamectl 2>/dev/null | awk -F': ' '/Operating System/ {print $2; exit}')
MYIP=$(curl -s ipv4.icanhazip.com || curl -s ipinfo.io/ip || curl -s ifconfig.me)
domain=$(cat /usr/local/etc/xray/domain)
ISP=$(curl -s ipv4.icanhazip.com || curl -s ipinfo.io/ip || curl -s ifconfig.me)

# detail cpu ram
cname=$( awk -F: '/model name/ {name=$2} END {print name}' /proc/cpuinfo )
cores=$( awk -F: '/model name/ {core++} END {print core}' /proc/cpuinfo )
freq=$( awk -F: ' /cpu MHz/ {freq=$2} END {print freq}' /proc/cpuinfo )
tram=$(free -m | awk 'NR==2 {print $2}')
uram=$(free -m | awk 'NR==2 {print $3}')
fram=$(free -m | awk 'NR==2 {print $4}')
swap=$( free -m | awk 'NR==4 {print $2}' )

# if no IPv6
IPVPS=$(curl -s ipv4.icanhazip.com || curl -s ipinfo.io/ip || curl -s ifconfig.me)
IPV6=$(curl -s -6 ipv6.icanhazip.com)

if [ -z "$IPV6" ]; then
    IPV6="\e[32m(IPv4 only)\e[0m"
else
    IPV6="\e[32m($IPV6)\e[0m"
fi

# OS Uptime
uptime="$(uptime -p | cut -d " " -f 2-10)"

# Getting CPU Information
cpu_usage1="$(ps aux | awk 'BEGIN {sum=0} {sum+=$3}; END {print sum}')"
cpu_usage="$((${cpu_usage1/\.*/} / ${corediilik:-1}))"
cpu_usage+=" %"

# Interface vnstat
iface="$(ifconfig | awk 'NR==1 {sub(/:$/, "", $1); print $1}')"

# Download/Upload today
dtoday="$(vnstat -i $iface | grep "today" | awk '{print $2" "substr ($3, 1, 1)}')"
utoday="$(vnstat -i $iface | grep "today" | awk '{print $5" "substr ($6, 1, 1)}')"
ttoday="$(vnstat -i $iface | grep "today" | awk '{print $8" "substr ($9, 1, 1)}')"

# Download/Upload yesterday
dyest="$(vnstat -i $iface | grep "yesterday" | awk '{print $2" "substr ($3, 1, 1)}')"
uyest="$(vnstat -i $iface | grep "yesterday" | awk '{print $5" "substr ($6, 1, 1)}')"
tyest="$(vnstat -i $iface | grep "yesterday" | awk '{print $8" "substr ($9, 1, 1)}')"

# Download/Upload current month
dmon="$(vnstat -i $iface -m | grep "$(date +"%b '%y")" | awk '{print $3" "substr ($4, 1, 1)}')"
umon="$(vnstat -i $iface -m | grep "$(date +"%b '%y")" | awk '{print $6" "substr ($7, 1, 1)}')"
tmon="$(vnstat -i $iface -m | grep "$(date +"%b '%y")" | awk '{print $9" "substr ($10, 1, 1)}')"

# TOTAL ACC CREATE VMESS WS
vmess=$(grep -c -E "^#vms " "/usr/local/etc/xray/config.json")
# TOTAL ACC CREATE  VLESS WS
vless=$(grep -c -E "^#vls " "/usr/local/etc/xray/config.json")
# TOTAL ACC CREATE  VLESS TCP XTLS
xtls=$(grep -c -E "^#vxtls " "/usr/local/etc/xray/config.json")
# TOTAL ACC CREATE  TROJAN TCP
trtls=$(grep -c -E "^#trx " "/usr/local/etc/xray/config.json")
# TOTAL ACC CREATE  TROJAN WS TLS
trws=$(grep -c -E "^### " "/usr/local/etc/xray/trojanws.json")
# TOTAL ACC CREATE  TROJAN GO
trgo=$(grep -c -E "^### " "/etc/trojan-go/akun.conf")
# TOTAL ACC CREATE OVPN SSH
total_ssh="$(awk -F: '$3 >= 1000 && $1 != "nobody" {print $1}' /etc/passwd | wc -l)"

# Color
white="\e[97m"
yellow="\e[93m"
blue="\e[94m"
green="\e[32m"
reset="\e[0m"

# simple menu
clear
echo -e "${blue}==================== Premium Script ====================${reset}"
#toilet -f big "Premium" --gay
figlet -f "$ascii" "Premium" >/dev/null 2>&1 || figlet "Premium"
echo -e "${blue}================= SERVER INFORMATION ===================${reset}"
echo -e "${white}Operating System     : $OS"
echo -e "Kernel               : $(uname -r)"
echo -e "CPU Model            :$cname"
echo -e "CPU Info             : ${cores} core /${freq} MHz (${cpu_usage})"
echo -e "Total RAM            : ${uram} MB / ${tram} MB"
echo -e "System Uptime        : $uptime"
echo -e "IP Address           : $IPVPS, $IPV6"
echo -e "Domain Name          : $domain"
echo -e "${blue}========================================================${reset}"
echo -e "${white}VMess-WS = ${green}${vmess:-0}${white},  VLess-WS = ${green}${vless:-0}${white},  VLess-XTLS = ${green}${xtls:-0}${reset}"
echo -e "${white}SSH/OpenVPN = ${green}${total_ssh:-0}${white},  Trojan-TCP = ${green}${trtls:-0}${reset}"
# Output vnStat Traffic Table
echo -e "${blue}========================================================${reset}"
echo -e "                     ${white}DATA USAGE${reset}"
echo -e "${blue}========================================================${reset}"
echo -e "${white}   Traffic       Today          Yesterday         Month${reset}"
echo -e "${white}   Download     ${yellow}$(printf '%-10s' "$dtoday")${white}   $(printf '%-10s' "$dyest")   $(printf '%-10s' "$dmon")${reset}"
echo -e "${white}   Upload       ${yellow}$(printf '%-10s' "$utoday")${white}   $(printf '%-10s' "$uyest")   $(printf '%-10s' "$umon")${reset}"
echo -e "${white}   Total        ${yellow}$(printf '%-10s' "$ttoday")${white}   $(printf '%-10s' "$tyest")   $(printf '%-10s' "$tmon")${reset}"
# Main menu
echo -e "${blue}========================================================${reset}"
echo -e "                     ${white}MAIN MENU${reset}"
echo -e "${blue}========================================================${reset}"
echo -e " ${yellow}(1)${white} VMESS & VLESS               ${yellow}(8)${white}  CLEAR LOG VPS"
echo -e " ${yellow}(2)${white} TROJAN TCP                  ${yellow}(9)${white}  CHECK RUNNING"
echo -e " ${yellow}(3)${white} SSH & OPENVPN               ${yellow}(10)${white} REBOOT VPS"
echo -e " ${yellow}(4)${white} NOOBZVPN                    ${yellow}(11)${white} INFO ALL PORT"
echo -e " ${yellow}(5)${white} SYSTEM MENU                 ${yellow}(12)${white} DAILY BANDWIDTH"
echo -e " ${yellow}(6)${white} MENU THEMES                 ${yellow}(13)${white} MONTHLY BANDWIDTH"
echo -e " ${yellow}(7)${white} CHANGE PORT                 ${yellow}(14)${white} LOG OUT"
echo -e "${blue}========================================================${reset}"
# script update
echo -e "${white}Lite AutoScriptVPN Webscoket v1.1"
echo -e "Last Updated : 4 Nov 2025"
echo -e "${blue}========================================================${reset}"
echo ""
echo -e "${white}[Ctrl + C] to exit from main menu${reset}"
echo ""
read -p " Select From Options [1-14 or x]: " menu
echo ""


case $menu in
1)
xraay
;;
2)
trojaan
;;
3)
ssh
;;
4)
menu-noobzvpn
;;
5)
system
;;
6)
themes
;;
7)
change-port
;;
8)
clear-log
;;
9)
check-sc
;;
10)
reboot
;;
11)
info
;;
12)
vnstat -d
;;
13)
vnstat -m
;;
14)
exit && exit
;;
x)
clear
exit
echo  -e "\e[1;31mPlease Type menu For More Option, Thank You\e[0m"
;;
*)
clear
echo  -e "\e[1;31mPlease enter an correct number\e[0m"
sleep 1
menu
;;
esac
