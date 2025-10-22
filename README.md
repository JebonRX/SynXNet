<h2 align="center">

♦️Autoscript VPN Websocket Remake♦️



 <h2 align="center">AutoScriptVPN <img src="https://img.shields.io/badge/Version-Stable_1.0-purple.svg"></h2>


<p align="center"><img src="https://img.shields.io/static/v1?style=for-the-badge&logo=debian&label=Debian%2012&message=Bookworm&color=purple"> <img src="https://img.shields.io/static/v1?style=for-the-badge&logo=debian&label=Debian%2013&message=Trixie&color=purple">  <img src="https://img.shields.io/static/v1?style=for-the-badge&logo=ubuntu&label=Ubuntu%2024&message=Focal&color=red"> <img src="https://img.shields.io/static/v1?style=for-the-badge&logo=ubuntu&label=Ubuntu%2025&message=Beta&color=red">
</p>

<p align="center">
  
## ♦️Update & Upgrade First Your VPS for Debian♦️

  ```html
  apt-get update && apt-get upgrade -y && update-grub && sleep 2 && reboot
  
  ```
 or
 
 
   ```html
  apt update -y && apt upgrade -y && apt dist-upgrade -y && reboot

  ```

## ♦️Update & Upgrade First Your VPS for Ubuntu♦️

  ```html
  apt-get update && apt-get upgrade -y && apt dist-upgrade -y && update-grub && sleep 2 && reboot

  ```
  
 or
   ```html
  apt-get update && apt-get upgrade -y && apt dist-upgrade -y && update-grub && reboot

  ```
 
 
## ♦️INSTALLATION SCRIPT♦️
ipv4 only
  ```html
sysctl -w net.ipv6.conf.all.disable_ipv6=1 && sysctl -w net.ipv6.conf.default.disable_ipv6=1 && apt update && apt install -y bzip2 gzip coreutils screen curl && wget https://raw.githubusercontent.com/JebonRX/SynXNet/main/setup.sh && chmod +x setup.sh && sed -i -e 's/\r$//' setup.sh && screen -S setup ./setup.sh

  ```
or 
 ```html
sysctl -w net.ipv6.conf.all.disable_ipv6=1 && sysctl -w net.ipv6.conf.default.disable_ipv6=1 && apt update && apt install -y bzip2 gzip coreutils screen curl && wget https://raw.githubusercontent.com/‎JebonRX/SynXNet/main/setup2.sh && chmod +x setup2.sh && sed -i -e 's/\r$//' setup2.sh && screen -S setup ./setup2.sh

  ```
ipv4 + ipv6
 ```html
apt update && apt install -y bzip2 gzip coreutils screen curl && wget https://raw.githubusercontent.com/‎JebonRX/SynXNet/main/setup3.sh && chmod +x setup3.sh && sed -i -e 's/\r$//' setup3.sh && screen -S setup ./setup3.sh
  ```
  
 Server Information & Other Features:-
 
   - Timezone                 : Asia/Kuala_Lumpur (GMT +8)
   - Fail2Ban                 : [ON]
   - DDOS Dflate              : [ON]
   - IPtables                 : [ON]
   - Auto-Reboot              : [ON] - 5.00 AM
   - IPv6                     : [OFF]
   - Auto-Remove-Expired      : [ON]
   - Auto-Backup-Account      : [ON]
   - Fully automatic script
   - VPS settings
   - Admin Control
   - Change port
   - Change Dropbear Version

