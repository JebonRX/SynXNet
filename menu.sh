#!/bin/bash
#
# Detail VPS
OS=$(hostnamectl 2>/dev/null | awk -F': ' '/Operating System/ {print $2; exit}')
OS2=$(lsb_release -ds)
MYIP=$(curl -s ipv4.icanhazip.com || curl -s ipinfo.io/ip || curl -s ifconfig.me)
domain=$(cat /usr/local/etc/xray/domain)
ISP=$(curl -s ipv4.icanhazip.com || curl -s ipinfo.io/ip || curl -s ifconfig.me)
CITY=$(curl -s ipinfo.io/city )
WKT=$(curl -s ipinfo.io/timezone )

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

#
# Detect OS
if grep -qi "ubuntu" /etc/os-release; then
    OS="ubuntu"
elif grep -qi "debian" /etc/os-release; then
    OS="debian"
else
    OS="other"
fi

# Detect interface vnstat
# Try detect using ifconfig first
iface="$(ifconfig 2>/dev/null | awk 'NR==1 {sub(/:$/, "", $1); print $1}')"

# If empty, fallback to ip command
if [ -z "$iface" ]; then
    iface=$(ip -o link show | awk -F': ' '$2 != "lo" {print $2; exit}')
fi


#############################
# ✅ Debian (old vnstat format — UPPER)
#############################
if [ "$OS" = "debian" ]; then

    # Today
    dtoday="$(vnstat -i $iface | grep "today" | awk '{print $2" "substr($3,1,1)}')"
    utoday="$(vnstat -i $iface | grep "today" | awk '{print $5" "substr($6,1,1)}')"
    ttoday="$(vnstat -i $iface | grep "today" | awk '{print $8" "substr($9,1,1)}')"

    # Yesterday
    dyest="$(vnstat -i $iface | grep "yesterday" | awk '{print $2" "substr($3,1,1)}')"
    uyest="$(vnstat -i $iface | grep "yesterday" | awk '{print $5" "substr($6,1,1)}')"
    tyest="$(vnstat -i $iface | grep "yesterday" | awk '{print $8" "substr($9,1,1)}')"

    # Current month
    dmon="$(vnstat -i $iface -m | grep "$(date +"%b '%y")" | awk '{print $3" "substr ($4, 1, 1)}')"
    umon="$(vnstat -i $iface -m | grep "$(date +"%b '%y")" | awk '{print $6" "substr ($7, 1, 1)}')"
    tmon="$(vnstat -i $iface -m | grep "$(date +"%b '%y")" | awk '{print $9" "substr ($10, 1, 1)}')"

#############################
# ✅ Ubuntu (vnstat v2 format — LOWER)
#############################
elif [ "$OS" = "ubuntu" ]; then

    # Monthly
    dmon="$(vnstat -m | grep $(date +%Y-%m) | awk '{print $2, $3}')"
    umon="$(vnstat -m | grep $(date +%Y-%m) | awk '{print $5, $6}')"
    tmon="$(vnstat -m | grep $(date +%Y-%m) | awk '{print $8, $9}')"

    # Today
    dtoday="$(vnstat -d | grep $(date +%Y-%m-%d) | awk '{print $2, $3}')"
    utoday="$(vnstat -d | grep $(date +%Y-%m-%d) | awk '{print $5, $6}')"
    ttoday="$(vnstat -d | grep $(date +%Y-%m-%d) | awk '{print $8, $9}')"

    # Yesterday
    dyest="$(vnstat -d | grep $(date -d 'yesterday' +%Y-%m-%d) | awk '{print $2, $3}')"
    uyest="$(vnstat -d | grep $(date -d 'yesterday' +%Y-%m-%d) | awk '{print $5, $6}')"
    tyest="$(vnstat -d | grep $(date -d 'yesterday' +%Y-%m-%d) | awk '{print $8, $9}')"
fi

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
# PROVIDED
creditt=$(cat /root/provided)
# BANNER COLOUR
banner_colour=$(cat /etc/banner)
# TEXT ON BOX COLOUR
box=$(cat /etc/box)
# LINE COLOUR
line=$(cat /etc/line)
# TEXT COLOUR ON TOP
text=$(cat /etc/text)
# TEXT COLOUR BELOW
below=$(cat /etc/below)
# BACKGROUND TEXT COLOUR
back_text=$(cat /etc/back)
# NUMBER COLOUR
number=$(cat /etc/number)
# BANNER
banner=$(cat /usr/bin/bannerku)
ascii=$(cat /usr/bin/test)
clear
# MENU
echo -e "\e[$banner_colour"
figlet -f $ascii "$banner"
echo -e "\e[$text Premium Script"
echo -e   " \e[$line════════════════════════════════════════════════════════════\e[m"
echo -e   " \e[$back_text                    \e[30m[\e[$box SERVER INFORMATION\e[30m ]\e[1m                  \e[m"
echo -e   " \e[$line════════════════════════════════════════════════════════════\e[m"
#echo -e "  \e[${text}Operating System     : $(hostnamectl 2>/dev/null | awk -F': ' '/Operating System/ {print $2; exit}') @ $OS \e[0m"
echo -e "  \e[${text}Operating System     : $OS2 \e[0m"
echo -e "  \e[${text}Kernel               : $(uname -r) \e[0m"
echo -e "  \e[${text}CPU Model            :$cname\e[0m"
echo -e "  \e[${text}CPU Info             : ${cores} core / ${freq} MHz (${cpu_usage})\e[0m"
echo -e "  \e[${text}Total RAM            : ${uram} MB / ${tram} MB\e[0m"
echo -e "  \e[${text}System Uptime        : $uptime \e[0m"
echo -e "  \e[${text}IP Address           : $IPVPS, $IPV6\e[0m"
echo -e "  \e[${text}Domain Name          : $domain\e[0m"
echo -e "  \e[${text}Provided By          : $creditt"
echo -e   " \e[$line════════════════════════════════════════════════════════════\e[m"
echo -e   " \e[$back_text                        \e[30m[\e[$box  VNSTAT \e[30m ] \e[1m                       \e[m"
echo -e   " \e[$line════════════════════════════════════════════════════════════\e[m"
echo -e "${white}   Traffic       Today          Yesterday         Month${reset}"
echo -e "${white}   Download     ${white}$(printf '%-10s' "$dtoday")${white}   $(printf '%-10s' "$dyest")   $(printf '%-10s' "$dmon")${reset}"
echo -e "${white}   Upload       ${white}$(printf '%-10s' "$utoday")${white}   $(printf '%-10s' "$uyest")   $(printf '%-10s' "$umon")${reset}"
echo -e "${white}   Total        ${white}$(printf '%-10s' "$ttoday")${white}   $(printf '%-10s' "$tyest")   $(printf '%-10s' "$tmon")${reset}"
echo -e   " \e[$line════════════════════════════════════════════════════════════\e[m"
echo -e " \e[$text Ssh/Ovpn   VMess   Vless   VlessXtls   Trojan-Tcp       \e[0m "    
echo -e " \e[$below    $total_ssh        $vmess        $vless        $xtls           $trtls            \e[0m "
echo -e   " \e[$line════════════════════════════════════════════════════════════\e[m"
echo -e   " \e[$back_text                        \e[30m[\e[$box MAIN MENU\e[30m ]\e[1m                       \e[m"
echo -e   " \e[$line════════════════════════════════════════════════════════════\e[m"

# MAIN MENU (1–4)
echo -e   "  \e[$number (•1)\e[m \e[$below VMESS & VLESS\e[m"
echo -e   "  \e[$number (•2)\e[m \e[$below TROJAN TCP\e[m"
echo -e   "  \e[$number (•3)\e[m \e[$below SSH-WS & OPENVPN\e[m"
echo -e   "  \e[$number (•4)\e[m \e[$below NOOBZVPN\e[m"

echo -e   " \e[$line════════════════════════════════════════════════════════════\e[m"
echo -e   " \e[$back_text                         \e[30m[\e[$box TOOLS\e[30m ]\e[1m                          \e[m"
echo -e   " \e[$line════════════════════════════════════════════════════════════\e[m"

# TOOLS (5–11)
echo -e   "  \e[$number (•5)\e[m \e[$below SYSTEM MENU\e[m        \e[$number (•9)\e[m \e[$below REBOOT VPS\e[m"
echo -e   "  \e[$number (•6)\e[m \e[$below MENU THEMES\e[m        \e[$number (10)\e[m \e[$below INFO ALL PORT\e[m"
echo -e   "  \e[$number (•7)\e[m \e[$below CHANGE PORT\e[m        \e[$number (11)\e[m \e[$below CLEAR EXPIRED CONFIG & LOG\e[m"
echo -e   "  \e[$number (•8)\e[m \e[$below CHECK RUNNING\e[m      \e[$number (12)\e[m \e[$below VNSTAT\e[m"

echo -e   " \e[$line════════════════════════════════════════════════════════════\e[m"
echo -e   "  \e[$below Version Name         : SSH XRAY WEBSOCKET MULTIPATH"
echo -e   "  \e[$below Autoscript By        : NevermoreSSH"
echo -e   "  \e[$below Version Update       : v1.2 @ 11/11/2025"
echo -e   " \e[$line════════════════════════════════════════════════════════════\e[m"
echo -e   ""
echo -e   "  \e[$below [Ctrl + C] For exit from main menu\e[m"
echo -e   "\e[$below "
read -p   "   Select From Options [1-12 or x] :  " menu
echo -e   ""
case $menu in
1)
xraay
;;
2)
trojaan
;;
3)
ssh2
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
check-sc
;;
9)
reboot
;;
10)
info
;;
12)
vnstat
;;
11)
clear-log && delete && xp
;;
99)
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
