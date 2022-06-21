## Server1 configuration

Network plan

![0_1](img/0_1.png)

Created VMs in Virtualbox

![0_2](img/0_2.png)

Server1 VM

![0_3](img/0_3.png)

Client1 VM

![0_4](img/0_4.png)

Client2 VM

![0_5](img/0_5.png)


### 1. На Server_1 налаштувати статичні адреси на всіх інтерфейсах.

```
$ sudo nano /etc/netplan/00-config.yaml 
$ sudo netplan apply
```

![1_1](img/1_1.png)

Config file

```
#/etc/netplan/00-config.yaml 
# This is the network config written by 'subiquity'
network:
  ethernets:
    enp0s3:
      dhcp4: no
      addresses:
        - 10.1.1.10/24
      gateway4: 10.1.1.1
      nameservers:
          addresses: [10.1.1.1]
    enp0s8:
      dhcp4: no
      addresses:
        - 10.83.3.1/24
    enp0s9:
      dhcp4: no
      addresses:
        - 10.1.83.1/24
  version: 2

```

Also for testing purposes were configured interfaces on Client1 (Ubuntu)

![1_3](img/1_3.png)

and Client2 (CentOS 7)

```
# cd /etc/sysconfig/network-scripts
# vi ifcfg-enp0s3
...
# systemstl restart network
```

![1_5](img/1_5.png)

### 2. На Server_1 налаштувати DHCP сервіс, який буде конфігурувати адреси Int1 Client_1 та Client_2
```
sudo apt install isc-dhcp-server
```
Enable for interfaces enp0s8, enp0s9
```
#/etc/default/isc-dhcp-server
INTERFACESv4="enp0s8 enp0s9"
INTERFACESv6=""
```
Enter configuration
```
#/etc/dhcp/dhcpd.conf 
authoritative;
option domain-name-servers 10.1.1.1;

subnet 10.83.3.0 netmask 255.255.255.0 {
  range 10.83.3.2 10.83.3.100;
}

subnet 10.1.83.0 netmask 255.255.255.0 {
  range 10.1.83.2 10.1.83.100;
}
```
Restart server
```
$ sudo systemctl restart isc-dhcp-server.service
```
![2_1](img/2_1.png)

Change Client1 enp0s3 settings to dhcp

![2_2](img/2_2.png)

![2_3](img/2_3.png)

and Client2 enp0s3 settings to dhcp

![2_4](img/2_4.png)

![2_5](img/2_5.png)

### 3. За допомогою команд ping та traceroute перевірити зв'язок між віртуальними машинами. Результат пояснити.

Увага! Для того, щоб з Client_1 та Client_2 проходили пакети в мережу Internet
(точніше щоб повертались з Internet на Client_1 та Client_2) на Wi-Fi Router необхідно
налаштувати статичні маршрути для мереж Net2 та Net3

Ping works from Server1 to Host PC, Client1, Client2, Router and Internet Router.

![3_1](img/3_1.png)

![3_2](img/3_2.png)

![3_3](img/3_3.png)

Configure Internet Router Static routes

![3_4](img/3_4.png)

Routes for Client1

![3_5](img/3_5.png)

![3_6](img/3_6.png)

![3_7](img/3_7.png)

Routes for Client2

![3_8](img/3_8.png)

![3_9](img/3_9.png)

![3_10](img/3_10.png)

### 4. На віртуальному інтерфейсу lo Client_1 призначити дві ІР адреси за таким правилом: 172.17.D+10.1/24 та 172.17.D+20.1/24. Налаштувати маршрутизацію таким чином, щоб трафік з Client_2 до 172.17.D+10.1 проходив через Server_1, а до 172.17.D+20.1 через Net4. Для перевірки використати traceroute.

![4_0](img/4_0.png)

![4_1](img/4_1.png)

![4_2](img/4_2.png)

### Part1. Налаштувати маршрутизацію таким чином, щоб трафік з Client_2 до 172.17.13.1 проходив через Server_1

Add route on Server1
```
$ sudo ip route add 172.17.13.0/24 dev enp0s8
```
![4_3](img/4_3.png)

As Client2 uses 10.1.83.1 as default gateway - all ips not in routes will be redirected to 10.1.83.1 (Server1) that knows 172.17.13.0/24 network

![4_5](img/4_5.png)

### Part2. Трафік з Client_2 до 172.17.23.1 через Net4

As network 172.17.23.0/24 is not at routes on Server1 all outgoing traffic to mentioned network will be redirected through defaout gateway (10.1.1.1) to internet provider router ....
![4_6](img/4_6.png)

So we add new route to network 172.17.23.0/24 through enp0s8 interface (Net4)

![4_7](img/4_7.png)

![4_8](img/4_8.png)

Ping an traceroute to 172.17.23.1

![4_9](img/4_9.png)

### 5. Розрахувати спільну адресу та маску (summarizing) адрес 172.17.D+10.1 та 172.17.D+20.1, при чому маска має бути максимально можливою. Видалити маршрути, встановлені на попередньому кроці та замінити їх об’єднаним маршрутом, якій має проходити через Server_1.

Summarized address and mask for networks 172.17.13.0/24 and 172.17.23.0/24
```
172.17.0.0/19
```

Remove old routes from Server2 and Client2 for networks 172.17.13.0/24 and 172.17.23.0/24. Add new route to 172.17.0.0/19 through enp0s8 device

![5_1](img/5_1.png)

![5_2](img/5_2.png)

Ping and traceroute from Client2

![5_3](img/5_3.png)

![5_4](img/5_4.png)

### 6. Налаштувати SSH сервіс таким чином, щоб Client_1 та Client_2 могли підключатись до Server_1 та один до одного.

#### Client1 SSH connection to Server1 via all interfaces

![6_1](img/6_1.png)

![6_2](img/6_2.png)

![6_3](img/6_3.png)

#### Client1 SSH connection to Client2 

![6_4](img/6_4.png)

#### Client2 SSH connection to Server1 via all interfaces

![6_5](img/6_5.png)

#### Client2 SSH connection to Client2 

![6_6](img/6_6.png)

#### Server1 SSH connection to Client1

![6_7](img/6_7.png)

#### Server1 SSH connection to Client2

![6_8](img/6_8.png)


### 7. Налаштуйте на Server_1 firewall таким чином:
#### • Дозволено підключатись через SSH з Client_1 та заборонено з Client_2
Allow ssh connections from host network (bridge connection)
```sudo ufw allow from 10.1.1.0/24 to any port 22```

![7_1](img/7_1.png)

Allow ssh connections from Client1 to 10.83.3.1 only
```sudo ufw allow proto tcp from 10.83.3.2 to 10.83.3.1 port 22```

![7_2](img/7_2.png)

Other connections are denied. And from Client2 also.

![7_3](img/7_3.png)

ufw status

![7_4](img/7_4.png)






