#!/bin/bash
MYIP=$(wget -qO- icanhazip.com);
#Email domain
printf '\n\033[1;32m───────────────────────────────────────────────\033[0m\n'
printf ' \033[1;37mEnter your email Domain / Cloudflare\033[0m\n'
printf ' \033[1;31m(Press ENTER for default email)\033[0m\n'
printf '\033[1;32m───────────────────────────────────────────────\033[0m\n'
printf ' Email : '

# POSIX read
read email || email=""
# Specify email
if [ -z "${email}" ]; then
  sts="$default_email"
else
  sts="$email"
fi

# email
mkdir -p /usr/local/etc/xray/
touch /usr/local/etc/xray/email
echo $sts > /usr/local/etc/xray/email
printf '\n'
mkdir /var/lib/premium-script;
printf '\n\033[1;32m───────────────────────────────────────────────\033[0m\n'
printf ' \033[1;37mEnter your Subdomain / Domain\033[0m\n'
printf ' \033[1;31m(Press ENTER to skip)\033[0m\n'
printf '\033[1;32m───────────────────────────────────────────────\033[0m\n'
read -p " Subdomain: " host
echo "IP=" >> /var/lib/premium-script/ipvps.conf
echo $host > /root/domain
mkdir -p /usr/local/etc/xray/
printf '\n'
printf '\033[1;32mPlease enter the name of provider.\033[0m\n'
printf 'Name : '
read nm || nm=""
printf '%s\n' "$nm" > /root/provided
clear

# =============================
# start installing setup
# =============================
printf '\n\033[1;32m╭────────────────────────────────────────────╮\033[0m\n'
printf '   🚀  \033[1;37mReady for installation script...\033[0m\n'
printf '\033[1;32m╰────────────────────────────────────────────╯\033[0m\n\n'
sleep 2
wget https://raw.githubusercontent.com/JebonRX/SynXNet/main/install/ssh-vpn.sh && chmod +x ssh-vpn.sh && screen -S ssh-vpn ./ssh-vpn.sh
printf '\n\033[1;32m╭────────────────────────────────────────────╮\033[0m\n'
printf '   ✅  \033[1;37mDone installing SSH & OVPN\033[0m\n'
printf '\033[1;32m╰────────────────────────────────────────────╯\033[0m\n\n'
clear

# =============================
# INSTALL XRAY SERVER SECTION
# =============================

clear
printf '\n\033[1;32m╭────────────────────────────────────────────╮\033[0m\n'
printf '   ⚙️  \033[1;37mInstalling Xray Server...\033[0m\n'
printf '\033[1;32m╰────────────────────────────────────────────╯\033[0m\n\n'

sleep 1
wget https://raw.githubusercontent.com/JebonRX/SynXNet/main/install/ins-xray.sh -O ins-xray.sh \
&& chmod +x ins-xray.sh \
&& screen -S ins-xray ./ins-xray.sh

printf '\n\033[1;32m╭────────────────────────────────────────────╮\033[0m\n'
printf '   ✅  \033[1;37mDone installing Xray Core\033[0m\n'
printf '\033[1;32m╰────────────────────────────────────────────╯\033[0m\n\n'

sleep 1
clear

# =============================
# INSTALL OHP SERVER SECTION
# =============================

clear
printf '\n\033[1;32m╭────────────────────────────────────────────╮\033[0m\n'
printf '   ⚙️  \033[1;37mInstalling OHP Server...\033[0m\n'
printf '\033[1;32m╰────────────────────────────────────────────╯\033[0m\n\n'

sleep 1
wget https://raw.githubusercontent.com/JebonRX/SynXNet/main/install/ohp.sh -O ohp.sh \
&& chmod +x ohp.sh && ./ohp.sh

wget https://raw.githubusercontent.com/JebonRX/SynXNet/main/install/ohp-dropbear.sh -O ohp-dropbear.sh \
&& chmod +x ohp-dropbear.sh && ./ohp-dropbear.sh

wget https://raw.githubusercontent.com/JebonRX/SynXNet/main/install/ohp-ssh.sh -O ohp-ssh.sh \
&& chmod +x ohp-ssh.sh && ./ohp-ssh.sh

printf '\n\033[1;32m╭────────────────────────────────────────────╮\033[0m\n'
printf '   ✅  \033[1;37mDone installing OHP Port\033[0m\n'
printf '\033[1;32m╰────────────────────────────────────────────╯\033[0m\n\n'

sleep 1
clear


# =============================
# INSTALL WEBSOCKET SECTION
# =============================

clear
printf '\n\033[1;32m╭────────────────────────────────────────────╮\033[0m\n'
printf '   ⚙️  \033[1;37mInstalling WebSocket...\033[0m\n'
printf '\033[1;32m╰────────────────────────────────────────────╯\033[0m\n\n'

sleep 1
wget https://raw.githubusercontent.com/JebonRX/SynXNet/main/websocket-python/websocket.sh -O websocket.sh \
&& chmod +x websocket.sh \
&& screen -S websocket ./websocket.sh

printf '\n\033[1;32m╭────────────────────────────────────────────╮\033[0m\n'
printf '   ✅  \033[1;37mDone installing WebSocket Port\033[0m\n'
printf '\033[1;32m╰────────────────────────────────────────────╯\033[0m\n\n'

sleep 1
clear


# =============================
# INSTALL SET-BR SECTION
# =============================

clear
printf '\n\033[1;32m╭────────────────────────────────────────────╮\033[0m\n'
printf '   ⚙️  \033[1;37mInstalling SET-BR...\033[0m\n'
printf '\033[1;32m╰────────────────────────────────────────────╯\033[0m\n\n'

sleep 1
wget https://raw.githubusercontent.com/JebonRX/SynXNet/main/install/set-br.sh -O set-br.sh \
&& chmod +x set-br.sh \
&& ./set-br.sh

printf '\n\033[1;32m╭────────────────────────────────────────────╮\033[0m\n'
printf '   ✅  \033[1;37mDone installing SET-BR\033[0m\n'
printf '\033[1;32m╰────────────────────────────────────────────╯\033[0m\n\n'

sleep 1
clear


echo " "
printf '\n\033[1;32m╭────────────────────────────────────────────╮\033[0m\n'
printf '   🎉  \033[1;37mInstallation has been completed!!\033[0m\n'
printf '\033[1;32m╰────────────────────────────────────────────╯\033[0m\n\n'
echo " "
echo "=========================[Script By JebonRX]========================" | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "   >>> Service & Port"  | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "    [INFORMATION SSH & OpenVPN]" | tee -a log-install.txt
echo "    -------------------------" | tee -a log-install.txt
echo "   - OpenSSH                 : 22"  | tee -a log-install.txt
echo "   - OpenVPN                 : TCP 1194, UDP 2200"  | tee -a log-install.txt
echo "   - OpenVPN SSL             : 110"  | tee -a log-install.txt
echo "   - Stunnel4                : 737"  | tee -a log-install.txt
echo "   - Dropbear                : 442, 109"  | tee -a log-install.txt
echo "   - OHP Dropbear            : 8585"  | tee -a log-install.txt
echo "   - OHP SSH                 : 8686"  | tee -a log-install.txt
echo "   - OHP OpenVPN             : 8787"  | tee -a log-install.txt
echo "   - Websocket SSH(HTTP)     : 8080"  | tee -a log-install.txt
echo "   - Websocket SSL(HTTPS)    : 8443"  | tee -a log-install.txt
echo "   - Websocket OpenVPN       : 2084"  | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "    [INFORMATION Squid, Badvpn, Nginx]" | tee -a log-install.txt
echo "    ---------------------------" | tee -a log-install.txt
echo "   - Squid Proxy             : 3128, 8000 (limit to IP Server)"  | tee -a log-install.txt
echo "   - Badvpn                  : 7100, 7200, 7300"  | tee -a log-install.txt
echo "   - Nginx                   : 81"  | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "    [INFORMATION NOOBZVPN]"  | tee -a log-install.txt
echo "    --------------" | tee -a log-install.txt
echo "   - Noobzvpn Tls            : 2096"  | tee -a log-install.txt
echo "   - Noobzvpn Non Tls        : 2086"  | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "    [INFORMATION XRAY]"  | tee -a log-install.txt
echo "    ----------------" | tee -a log-install.txt
echo "   - Xray Vmess Ws Tls       : 443"  | tee -a log-install.txt
echo "   - Xray Vless Ws Tls       : 443"  | tee -a log-install.txt
echo "   - Xray Vless Tcp Xtls     : 443"  | tee -a log-install.txt
echo "   - Xray Vmess Ws None Tls  : 8880"  | tee -a log-install.txt
echo "   - Xray Vless Ws None Tls  : 80"  | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "    [INFORMATION TROJAN]"  | tee -a log-install.txt
echo "    ------------------" | tee -a log-install.txt
echo "   - Xray Trojan Tcp Tls     : 443"  | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "    [INFORMATION CLASH FOR ANDROID (YAML)]"  | tee -a log-install.txt
echo "    -----------------------------------" | tee -a log-install.txt
echo "   - Xray Vmess Ws Yaml      : Yes"  | tee -a log-install.txt
echo "   --------------------------------------------------------------" | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "   >>> Server Information & Other Features"  | tee -a log-install.txt
echo "   - Timezone                : Asia/Kuala_Lumpur (GMT +8)"  | tee -a log-install.txt
echo "   - Fail2Ban                : [ON]"  | tee -a log-install.txt
echo "   - Dflate                  : [ON]"  | tee -a log-install.txt
echo "   - IPtables                : [ON]"  | tee -a log-install.txt
echo "   - Auto-Reboot             : [ON]"  | tee -a log-install.txt
echo "   - IPv6                    : [ON]"  | tee -a log-install.txt
echo "   - Autoreboot On 05.00 GMT +8" | tee -a log-install.txt
echo "   - Autobackup Data" | tee -a log-install.txt
echo "   - Restore Data" | tee -a log-install.txt
echo "   - Auto Delete Expired Account" | tee -a log-install.txt
echo "   - White Label" | tee -a log-install.txt
echo "   - Installation Log --> /root/log-install.txt"  | tee -a log-install.txt
echo "=========================[Script By JebonRX]========================" | tee -a log-install.txt
clear
echo ""
echo ""
printf '\n\033[1;32m╭──────────────────────────────────────────────╮\033[0m\n'
printf '   🎯  \033[1;37mSuccessfully installed the script!\033[0m\n'
printf '\033[1;32m╰──────────────────────────────────────────────╯\033[0m\n\n'
echo ""
printf '   \033[1;33mServer will automatically reboot in 5 seconds...\033[0m\n\n'

# remove installer
rm -f /root/ssh-vpn.sh
rm -f /root/ins-xray.sh
rm -f /root/trojan-go.sh
rm -f /root/set-br.sh
rm -f /root/ohp.sh
rm -f /root/ohp-dropbear.sh
rm -f /root/ohp-ssh.sh
rm -f /root/websocket.sh
rm -r setup.sh
sleep 5
reboot
