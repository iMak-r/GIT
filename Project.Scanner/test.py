# Импортируем необходимые библиотеки
import os
import argparse
import requests
import json

# Сканируем сеть
def do_ping_sweep(ip, num_of_host):
    ip_parts = ip.split('.') #Разбираем адрес на части
    network_ip = ip_parts[0] + '.' + ip_parts[1] + '.' + ip_parts[2] + '.' #Подсеть
 
    if int(ip_parts[3]) + num_of_host <=255:
        scanned_ip = network_ip + str(int(ip_parts[3]) + num_of_host) #Конечный адрес получаем сложением

        response = os.popen(f'ping -c 1 {scanned_ip}') #Опция -c требует административных привилегий, так что убрал
        print(response)
        res = response.readlines()

do_ping_sweep('192.168.1.1',2)