FROM ubuntu:latest

RUN apt-get update && apt-get upgrade -y
RUN apt-get install python3 -y
RUN apt-get install python3-pip -y
RUN pip3 install numpy pandas
RUN apt-get install -y iputils-ping

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt
RUN sysctl -w net.ipv6.conf.all.disable_ipv6=1 
RUN sysctl -w net.ipv6.conf.default.disable_ipv6=1

COPY scanner.py ./
COPY test.py ./

ENV task=$task
ENV ip=$ip
ENV num=$num
ENV target=$target
ENV met=$met
ENV hd=$hd

ENTRYPOINT ["python3", "-u", "scanner.py"]