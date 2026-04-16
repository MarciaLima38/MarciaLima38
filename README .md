# 🛡️ AMM-Cybersecurity-Lab

Projeto de cibersegurança que simula uma infraestrutura empresarial completa com capacidades de ataque, defesa, deteção e resposta.

---

## 🧠 Overview

Este laboratório foi desenvolvido no âmbito do curso CET103 e inclui:

* Segmentação de rede (VLANs)
* Firewalls (pfSense + OPNsense)
* SIEM (Wazuh)
* IDS/IPS (Suricata, Snort)
* VPNs seguras
* Simulação de ataques reais

---

Bem-vindo ao meu projeto final de Cybersecurity. Este repositório contém ferramentas de automação para testes de segurança.

## 📂 Estrutura do Repositório

* **[scripts/](./scripts/)**: Aqui você encontra o script principal `ataques_AMM.sh`.
* **docs/**: Documentação e prints da arquitetura (em breve).

## 🚀 Como testar o script

Para rodar o script de ataques automatizados, siga os comandos abaixo no seu terminal Linux:

1. **Acesse a pasta:**
   ```bash
   cd scripts

## 🏗️ Arquitetura

Ambiente segmentado em 4 zonas:

* 🔴 RED – Ataques (Kali Linux)
* 🟠 ORANGE – DMZ (Web + WAF)
* 🟢 GREEN – Rede interna (AD, clientes)
* 🔵 GESTÃO – Administração segura

---

## 🔴 Red Team (Ataques)

Simulação de ataques reais a partir de Kali Linux:

* Port scanning (Nmap)
* DoS SYN Flood (hping3)
* Exploração de vulnerabilidades web
* Reverse shell em sistemas Windows
* Movimento lateral via VPN
* Validação de deteção em Wazuh

---

## ⚙️ AMM Attack Tool

📂 `scripts/ataques_AMM.sh`

Ferramenta desenvolvida para automatizar ataques.

### Funcionalidades

* Interface interativa + argumentos CLI
* Port scanning automatizado
* SYN Flood
* Logs de ataques (`attack.log`)
* Verificação de bloqueio pós-ataque

### Uso

```bash
chmod +x scripts/ataques_AMM.sh
./scripts/ataques_AMM.sh --menu
```

---

## 🟠 DMZ (Zona Orange)

Implementação de serviços expostos protegidos:

* Apache / Nginx (CentOS)
* WAF (ModSecurity + OWASP rules)
* Reverse proxy (Nginx)
* IIS (Windows Server Core)
* Sistema de autenticação com base de dados

### Objetivo

Simular aplicações reais e testar mecanismos de defesa.

---

## 🟢 Deteção e Monitorização

* Wazuh (SIEM)
* Suricata / Snort (IDS/IPS)
* Logging centralizado

### Capacidades

* Deteção em tempo real
* Correlação de eventos
* Resposta automática

---

## 🌐 Infraestrutura

* Router Cisco 4300
* Switches Huawei (VLANs)
* 2 Firewalls:

  * pfSense
  * OPNsense

---

## 🎯 Objetivo

Criar um ambiente capaz de:

* Simular ataques reais
* Detetar intrusões
* Correlacionar eventos
* Responder automaticamente

---

## ⚠️ Nota

O script de ataques foi reconstruído com base na documentação do projeto original.

---

## 👨‍💻 Autores

* António Silva
* Márcia Lima
* Mateus Silva

---

## 🎓 Contexto

Curso: CET103 – Técnico Especialista em Cibersegurança
Módulo: Wargaming
Instituição: CINEL (Lisboa)

---
