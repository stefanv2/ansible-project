![GitHub last commit](https://img.shields.io/github/last-commit/stefanv2/ansible-project)
![GitHub repo size](https://img.shields.io/github/repo-size/stefanv2/ansible-project)

# 🚀 Ansible-Docker Project on ESXi – by Stefan

Welcome to this personal automation project! Built by **Stefan**, this setup combines **Docker**, **ESXi**, and **Ansible** to create a robust, scalable, and fully scripted test environment.

---

## 🧱 About this project

A virtual Ubuntu machine running on **VMware ESXi** is configured as a Docker host. Inside this Docker environment, multiple Ubuntu containers are launched, each simulating a separate server.

Using **Ansible**, all containers are automatically configured with essential tools, a management user (`ansible`), and one container is set up as a webserver using **nginx**.

---

## 🔧 What does this setup do?

- 🔨 Launches 5 Ubuntu containers with fixed IPs and SSH access
- 🔑 Automates SSH key authentication and sudo access for user `ansible`
- 📦 Installs common tools (vim, htop, curl, ping, etc.)
- 🌐 Installs NGINX on `ubuntu05`
- 🖥️ Deploys a custom HTML page via Ansible (yes, with a rocket 🚀)

---

## 💡 Why?

This project was built to:

- Practice Ansible roles and playbooks
- Apply Infrastructure-as-Code principles
- Treat containers like minimal VMs
- Build a strong personal automation lab

---

## 📂 Project structure

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

## 📦 Requirements

- Ubuntu VM with Docker
- ESXi host (e.g. 2 vCPU, 8 GB RAM)
- Ansible installed
- SSH keys set up

---

## 🌍 Access the web page

Visit: `http://<docker-host-ip>:8080`  
You’ll see the deployed nginx page from `ubuntu05`.

---

## 🙌 Credits

Built and maintained by **Stefan** — with curiosity, trial and error, and a touch of automation magic. ✨

---

> “Automating a task once is fun. Automating it forever is DevOps.” 😉

