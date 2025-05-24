![GitHub last commit](https://img.shields.io/github/last-commit/stefanv2/ansible-project)
![GitHub repo size](https://img.shields.io/github/repo-size/stefanv2/ansible-project)

# 👋 Over mij
Hi! Ik ben Stefan — een Oracle DBA met ruim 20 jaar ervaring in databases, infrastructuur en automatisering. Naast mijn werk vind ik het leuk om te experimenteren met Ansible, Docker, en PostgreSQL in zelfgebouwde labomgevingen op ESXi.
Ik gebruik dit GitHub-account om mijn projecten, scripts en playbooks te documenteren en te delen — zodat ik er zelf van leer, en anderen hopelijk ook.

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
├── create_ubuntu.sh              # Shellscript om containers te starten
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

## 🙌 Credits

Gebouwd en beheerd door **Stefan** – met plezier, foutopsporing en een vleugje automatiseringsmagie. ✨

---

> “Automating a task once is fun. Automating it forever is DevOps.” 😉


