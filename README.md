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
├── ansible.cfg                # Ansible config (incl. remote_tmp)
├── basic-setup.yml           # Hoofdplaybook met alle rollen
├── create_ubuntu.sh          # Script om containers aan te maken
├── hosts.ini                 # Inventarisbestand
├── README.md                 # Projectdocumentatie
├── roles/
│   ├── common/
│   │   └── tasks/
│   │       └── main.yml      # Installeert standaardtools
│
│   ├── user/
│   │   ├── tasks/
│   │   │   └── main.yml      # Maakt gebruiker 'demo' aan
│   │   └── files/            # Optionele SSH-keys
│
│   ├── nginx/
│   │   ├── tasks/
│   │   │   └── main.yml      # Installeert nginx, plaatst template
│   │   └── templates/
│   │       └── index.html.j2 # Dynamische webpagina (met raket 🚀)
│
│   └── postgres/
│       ├── tasks/
│       │   └── main.yml      # Installeert PostgreSQL, maakt user/db aan
│       ├── defaults/
│       │   └── main.yml      # Variabelen (bijv. db_name, db_user)
│       └── meta/
│           └── main.yml      # Galaxy metadata

```
---

## 📦 Vereisten

- Ubuntu VM met Docker
- ESXi-host (bijv. 2 vCPU, 8 GB RAM)
- Ansible geïnstalleerd
- SSH-sleutels geconfigureerd

---

## 🌍 Webpagina bekijken

Bezoek `http://<docker-host-ip>:8080` om de uitgerolde NGINX-pagina te zien.

---

🐘 PostgreSQL-rol gebruiken
De rol postgres installeert PostgreSQL, start de server handmatig (geschikt voor Docker zonder systemd) en maakt een database demo_db, gebruiker appuser, en database appdb.

Je kunt deze rol eenvoudig hergebruiken of aanpassen door variabelen toe te voegen in defaults/main.yml.

---

## 🙌 Credits

Gebouwd en beheerd door **Stefan** – met plezier, foutopsporing en een vleugje automatiseringsmagie. ✨

---

> “Automating a task once is fun. Automating it forever is DevOps.” 😉


