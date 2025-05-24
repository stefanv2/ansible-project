![GitHub last commit](https://img.shields.io/github/last-commit/stefanv2/ansible-project)
![GitHub repo size](https://img.shields.io/github/repo-size/stefanv2/ansible-project)

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

---

## 💡 Waarom?

Dit project is bedoeld om:

- Te oefenen met Ansible playbooks en rollen
- Infrastructure-as-Code hands-on toe te passen
- Containers als mini-VM’s te beheren
- Een solide testlab op te bouwen voor verdere automatisering

---

## 📂 Structuur


ansible-project/
├── hosts.ini
├── basic-setup.yml
├── ansible.cfg
├── roles/
│ ├── common/
│ ├── user/
│ └── nginx/
└── create_ubuntu.sh


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

## 🙌 Credits

Gebouwd en beheerd door **Stefan** – met plezier, foutopsporing en een vleugje automatiseringsmagie. ✨

---

> “Automating a task once is fun. Automating it forever is DevOps.” 😉


