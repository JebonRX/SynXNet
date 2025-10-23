#wget https://github.com/${GitUser}/
GitUser="JebonRX"
#IZIN SCRIPT
MYIP=$(curl -s ipv4.icanhazip.com || curl -s ipinfo.io/ip || curl -s ifconfig.me)
echo -e "\e[32mloading...\e[0m"
clear

echo " "
read -p "Input Username you want to lock: " username
egrep "^$username" /etc/passwd >/dev/null
if [ $? -eq 0 ]; then
# proses mengganti passwordnya
passwd -l $username
clear
  echo " "
  echo " "
  echo " "
  echo "-----------------------------------------------"
  echo -e "Username ${blue}$username${NC} successfully ${red}LOCKED!${NC}."
  echo -e "Access Login to username ${blue}$username${NC} has been locked."
  echo "-----------------------------------------------"
else
echo "Username not found on your server."
    exit 1
fi
