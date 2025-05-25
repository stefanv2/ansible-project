![GitHub last commit](https://img.shields.io/github/last-commit/stefanv2/ansible-project)
![GitHub repo size](https://img.shields.io/github/repo-size/stefanv2/ansible-project)

# 👋 Over mij
Hi! Ik ben Stefan — een Oracle DBA met ruim 20 jaar ervaring in databases, infrastructuur en automatisering. Naast mijn werk vind ik het leuk om te experimenteren met Ansible, Docker, en PostgreSQL in zelfgebouwde labomgevingen op ESXi.
Ik gebruik dit GitHub-account om mijn projecten, scripts en playbooks te documenteren en te delen — zodat ik er zelf van leer, en anderen hopelijk ook.

---

<p align="center">
<img src="images/Ansible_logo.svg" alt="BTOP" width="200" height="150"/>
<img src="images/Docker-Emblem.png" alt="BTOP" width="150" height="100"/>  
<img src="images/postgresSQL.jpg" alt="BTOP" width="150" height="100"/>  
</p>
  
---

# 🚀 Ansible-Docker Project op ESXi – door Stefan

Welkom bij dit project! Dit is een persoonlijke infrastructuur-automatisering gebouwd door **Stefan**, waarin **Docker**, **ESXi** en **Ansible** samenkomen om een krachtige, schaalbare en volledig scriptbare testomgeving te vormen.

---

## 🧱 Over dit project

In dit project is een virtuele Ubuntu-machine op een **VMware ESXi-host** opgezet als een Docker-host. Binnen deze Docker-omgeving zijn meerdere Ubuntu-containers uitgerold, elk ingericht als een individuele server.

Met behulp van **Ansible** worden deze containers automatisch geconfigureerd, voorzien van standaardtools, een beheerder (`ansible`) en één container zelfs ingericht als een webserver met **nginx**.

---

## 🔧 Wat doet dit project?

- 🔨 Start 5 Ubuntu-servers in Docker met vaste IP’s en SSH-toegang
- 🔑 Automatiseert SSH key-authenticatie en sudo-rechten voor de gebruiker `ansible`
- 📦 Installeert standaard tools (vim, htop, curl, ping, enz.)
- 🌐 Installeert NGINX op één container (`ubuntu05`)
- 🖥️ Deployt een eigen HTML-pagina via Ansible (met een raketje natuurlijk 🚀)
- 🐘 Installeert PostgreSQL op een specifieke container (`ubuntu03`)
- 🧑‍💻 Maakt automatisch een databasegebruiker (`appuser`) en een database (`appdb`)
- 🧩 Alle configuratie gebeurt via een eigen Ansible-rol `postgres`, geschikt voor gebruik in Docker-containers

---

## 💡 Waarom?

Dit project is bedoeld om:

- Te oefenen met Ansible playbooks en rollen
- Infrastructure-as-Code hands-on toe te passen
- Containers als mini-VM’s te beheren
- Een solide testlab op te bouwen voor verdere automatisering

---

### 📁 Projectstructuur

```plaintext

mijn_ansible1/
├── ansible.cfg                    # Ansible configuratiebestand
├── basic-setup.yml               # Hoofdplaybook met alle rollen
├── create_ubuntu.sh              # Shellscript om containers aan te maken. 
├── hosts.ini                     # Inventory met groepen en IP-adressen
├── restart.sh                    # Script om containers opnieuw op te starten
├── README.md                     # Documentatie van het project
├── .gitignore                    # Bestand om ongewenste bestanden uit Git te houden
├── roles/
│   ├── common/                   # Basisinstallatie (curl, ping, vim, etc.)
│   │   └── tasks/
│   │       └── main.yml
│   ├── user/                     # Rol voor het aanmaken van de gebruiker 'demo'
│   │   ├── tasks/
│   │   │   └── main.yml
│   │   └── files/                # (optioneel) extra SSH keys of configs
│   └── apps/                     # Groepering van applicatie-specifieke rollen
│       ├── nginx/                # Rol voor NGINX-webserver
│       │   ├── tasks/
│       │   │   └── main.yml
│       │   └── templates/
│       │       └── index.html.j2
│       └── postgres/             # Rol voor PostgreSQL-database
│           ├── tasks/
│           │   └── main.yml
│           ├── handlers/
│           │   └── main.yml
│           ├── defaults/
│           │   └── main.yml      # (optioneel) standaardvariabelen
│           └── meta/
│               └── main.yml      # Metadata voor Ansible Galaxy (optioneel)

```
---

## 📦 Vereisten

- Ubuntu VM met Docker
- ESXi-host (bijv. 2 vCPU, 16 GB RAM)
- Ansible geïnstalleerd
- SSH-sleutels geconfigureerd

---

## 🐳 Container Initialisatie met create_ubuntu.sh
Dit shellscript automatiseert het aanmaken van een nieuwe Ubuntu-container binnen het ansible-net Docker-netwerk. Het script zorgt ervoor dat je container direct SSH-ready is en toegankelijk is voor je Ansible-playbooks.

📂 Locatie
Bestand: create_ubuntu.sh

🔧 Functionaliteit
Start een Ubuntu 20.04-container met een statisch IP in je Docker-bridge netwerk.

Installeert direct tools zoals vim, curl, ping, net-tools en openssh-server.

Maakt de gebruiker ansible aan en voegt je eigen SSH-sleutel toe aan ~/.ssh/authorized_keys.

Zet permissies goed en start de SSH-service.

Verwijdert eventuele oude known_hosts-entries om SSH-fouten te voorkomen.

Forceert een eerste SSH-connectie om host key-checks automatisch te accepteren.

▶️ Voorbeeldgebruik
sudo ./create_ubuntu.sh ubuntu03 172.16.0.4 5432:5432
ubuntu03: de naam van de container (en hostname).
```plaintext
172.16.0.4: IP-adres binnen het ansible-net netwerk.

5432:5432: optionele poortmapping, bijv. voor PostgreSQL (standaard = 8080:80).
```
⚠️ Vooraf: Docker-netwerk ansible-net aanmaken
Voordat je de containers aanmaakt met create_ubuntu.sh, moet je een dedicated Docker-netwerk aanmaken met een vast IP-bereik. Dit netwerk zorgt ervoor dat alle containers in hetzelfde netwerksegment zitten en gemakkelijk via Ansible beheerd kunnen worden.

✅ Waarom is dit nodig?
Containers moeten elkaar kunnen bereiken via een vast IP-adres

Ansible gebruikt deze IP’s in hosts.ini

Port forwarding naar de host werkt stabieler met een vooraf gedefinieerd netwerk

```plaintext
🛠️ Eénmalig uitvoeren:
docker network create \
  --driver=bridge \
  --subnet=172.16.0.0/24 \
  ansible-net

🔍 Controle:
docker network ls

Je zou een regel moeten zien zoals:
NETWORK ID     NAME           DRIVER    SCOPE
abcd12345678   ansible-net    bridge    local

```
Je publieke sleutel moet staan in: /home/stefan/.ssh/id_rsa.pub.

Het script moet met sudo worden uitgevoerd zodat ssh-keygen -R en docker correct werken.

---

## 🌍 Webpagina bekijken

Bezoek `http://<docker-host-ip>:8080` om de uitgerolde NGINX-pagina te zien.

---

## 🐘 PostgreSQL-rol gebruiken
De rol postgres installeert PostgreSQL, start de server handmatig (geschikt voor Docker zonder systemd) en maakt een database demo_db, gebruiker appuser, en database appdb.

Je kunt deze rol eenvoudig hergebruiken of aanpassen door variabelen toe te voegen in defaults/main.yml.

---

## 🔁 Herstel containers & SSH na reboot

In het geval van een herstart van de Docker-host (bijv. je ESXi-server), kunnen sommige containers uitgeschakeld zijn of ontbreekt de SSH-service binnenin.

Gebruik in dat geval het meegeleverde herstartscript:

./restart.sh
🛠 Wat doet dit script?
Start gestopte containers opnieuw (ubuntu01 t/m ubuntu05)

Start of herstart de SSH-server binnenin elke container

Zorgt ervoor dat Ansible weer verbinding kan maken met alle nodes

💡 Tip
Zorg dat je containers zijn gestart met de vlag --restart unless-stopped, zodat ze automatisch opstarten bij reboot van de host.

Voorbeeld uit create_ubuntu.sh:

docker run -dit \
  --name "$CONTAINER_NAME" \
  --restart unless-stopped \
  ...
Zo voorkom je dat je containers handmatig hoeft te starten na een reboot.

---

## 📊 Btop monitoring via Ansible
De tool btop is een moderne systeembelastingmonitor (de opvolger van htop) en is opgenomen in de common role van dit project.

Kenmerken:
- Wordt geïnstalleerd op alle hosts via broncode (tar.bz2).
- Automatisch gedownload en geïnstalleerd via install.sh.
- Locale instellingen (UTF-8) worden automatisch gezet zodat btop werkt binnen Docker.
- Werkt in containers via docker exec -it ubuntuXX btop.
- Ansible-taken binnen roles/common/tasks/main.yml:

---
## 📦 Bestanden Deployen via Zip

  - Kopieert een .zip-bestand naar targetservers.
  - Verwijdert bestaande map en pakt het zipbestand uit.
---
## 🧠 Tags per Role en Component

  - Taken zijn voorzien van tags zoals common, nginx, postgres, files, zip.
  - Maakt het mogelijk om specifieke onderdelen uit te voeren met --tags.
---
## 🧰 Makefile voor Handige Snelkoppelingen

    Bevat commando's zoals:

     make connect-ubuntu01
        make common
        make nginx
        make postgres
        make files
        make zip
        make list-tags
---

## 🙌 Credits

<p align="center">
<img src="images/red-lady-bug-md.png" alt="BTOP" width="50" height="50"/>
</p>

Gebouwd en beheerd door **Stefan** – met plezier, foutopsporing en een vleugje automatiseringsmagie. ✨

---

> “Automating a task once is fun. Automating it forever is DevOps.” 😉


