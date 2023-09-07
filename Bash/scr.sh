#!/bin/bash
#1. Добавляем репозиторий
# Проверяем, существует ли файл со списком репозиториев
if [ -f /etc/apt/sources.list ]; 
then
# Если файл существует, читаем его содержимое
repo_list=$(cat /etc/apt/sources.list)
else
echo "Файл со списком репозиториев не найден."
exit 1
fi

# Проверяем наличие репозитория. Обязательно указываем "-m 1 -o", иначе при нахождении второй строки будет ошибка
if  [ ` cat "/etc/apt/sources.list" | grep -m 1 -o "jessie-backports" ` ] 
	then echo "Репозиторий есть в списке"
	else 
		echo "Добавление репозитория 'Backports'"
		# Добавляем репозиторий 
		echo "# Backports repository
		deb http://deb.debian.org/debian jessie-backports main contrib non-free
		deb http://deb.debian.org/debian jessie-backports-sloppy main contrib non-free" >> /etc/apt/sources.list

fi

#2. Обновляем пакетный менеджер
apt update

#3. Установка Apache
apt install -y apache2

#4. Установка Python
apt install -y python3

#5. Установка и поднятие SSH
apt install -y ssh
#Настроим PublicAuthentification. Если есть строка, то её целиком меняем на правильную
if [ `cat /etc/ssh/ssh_config | grep -m 1 -o "PublicAuthentification" ` ]
then
	sed -i '/PublicAuthentification/с\PublicAuthentification on/' /etc/ssh/ssh_config
else
	#Если строки нет - до добавим
	echo "PublicAuthentification on" >> /etc/ssh/ssh_config
fi

systemctl restart sshd

#6. Создадим нового пользователя
useradd -m -d /home/admin -p qwerty admin

#7. Добавим админа в sudoers
usermod -aG sudo admin

#8. Настроим DNS Яндекса
"nameserver 77.88.8.8" >> /etc/resolv.conf

#9. Поставим RDP, FTP
apt install -y xrdp 
apt install -y vsftpd

#10. Отобразим IP
echo "======================================"
curl ifconfig.co

#11. Поменяем оболочку админу на zsh (предварительно её установив)
apt install -y zsh 
sed -n '/admin/p' /etc/passwd |awk -F ":" '{print$1}' | xargs -n 1 chsh -s /bin/zsh 
