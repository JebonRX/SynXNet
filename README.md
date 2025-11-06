<h1 align="center">✨ AutoScript VPN ✨</h1>
<p align="center">
  <img src="https://img.shields.io/badge/Version-Stable-purple.svg" alt="Version Badge">
</p>

---

<h2 align="center">💻 Supported Linux Distributions 💻</h2>

<p align="center">
  <img src="https://d33wubrfki0l68.cloudfront.net/5911c43be3b1da526ed609e9c55783d9d0f6b066/9858b/assets/img/debian-ubuntu-hover.png" width="400" alt="Debian Ubuntu">
</p>

<h3 align="center">🌀 Compatible with Debian 12 / 13 & Ubuntu 22.04 / 24.04 / 25.04 🌀</h3>

---

<h2 align="center">⚙️ Installation Guide ⚙️</h2>

<p align="center"><b>Copy and paste the following command into your VPS terminal:</b></p>

```bash
apt update -y && apt upgrade -y && apt dist-upgrade -y && \
sysctl -w net.ipv6.conf.all.disable_ipv6=1 && \
sysctl -w net.ipv6.conf.default.disable_ipv6=1 && \
apt install -y net-tools htop wget iftop bzip2 gzip coreutils screen curl && \
wget https://raw.githubusercontent.com/JebonRX/SynXNet/main/setup.sh && \
chmod +x setup.sh && sed -i -e 's/\r$//' setup.sh && \
screen -S setup ./setup.sh
