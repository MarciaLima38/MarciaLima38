# 🔐 AMM Cybersecurity Lab

Infraestrutura completa de cibersegurança desenvolvida no âmbito do curso CET103.

---

## 🧠 Overview

Este projeto simula um ambiente empresarial com múltiplas camadas de segurança:

* Segmentação de rede (VLANs)
* Firewalls (pfSense + OPNsense)
* SIEM (Wazuh)
* IDS/IPS (Suricata, Snort)
* VPNs seguras
* Ataques controlados (Red Team)

---

## 🏗️ Arquitetura

* 🔴 RED – Ataques (Kali Linux)
* 🟠 ORANGE – DMZ (Web + WAF)
* 🟢 GREEN – Rede interna (AD, SIEM)
* 🔵 GESTÃO – Administração segura

---

## ⚙️ AMM Attack Tool

Script de automação de ataques:

📂 `scripts/ataques_AMM.sh`

### 🔥 Funcionalidades

* Menu interativo
* Argumentos CLI
* Port scanning (Nmap)
* SYN Flood (hping3)
* Logs automáticos (`attack.log`)
* Verificação de bloqueio

---

## ▶️ Uso

```bash
chmod +x scripts/ataques_AMM.sh
./scripts/ataques_AMM.sh --menu
```

### Exemplos

```bash
./scripts/ataques_AMM.sh --venus-scan
./scripts/ataques_AMM.sh --marte-flood
```

---

## 🔴 Red Team

* Port scanning
* DoS attacks
* Automação de ataques
* Validação de deteção (Wazuh + Suricata)

---

## 🟠 DMZ (Zona Orange)

* Apache / Nginx
* WAF (ModSecurity)
* IIS (Windows Core)

---

## 🟢 Monitorização

* Wazuh SIEM
* Syslog centralizado
* Deteção em tempo real

---

## ⚠️ Nota

O script foi reconstruído com base na documentação do projeto original.

---

## 👨‍💻 Autores

* António Silva
* Márcia Lima
* Mateus Silva

---

## 🎯 Objetivo

Simular um ambiente real de cibersegurança com:

* Ataque
* Defesa
* Deteção
* Resposta

---







# 🛡️ CET103 — Projeto Final: Infraestrutura de Cibersegurança

> **Curso:** Técnico Especialista em Cibersegurança — Nível 5 (CET103)  
> **Unidade de Formação:** UF9197 — Wargaming  
> **Instituição:** CINEL — Centro de Formação Profissional da Indústria Electrónica, Energia, Telecomunicações e Tecnologias da Informação (Polo de Lisboa)  
> **Data:** Março 2026  
> **Grupo AMM:** António · Márcia · Mateus 

---

## 📋 Descrição do Projeto

Este projeto consiste na **conceção, implementação e documentação de uma infraestrutura de segurança de redes completa**, simulando um ambiente empresarial real em contexto virtualizado.

A infraestrutura foi construída sobre uma rede física com um router Cisco 4300 e dois switches Huawei S5720S, sobre a qual foram implementadas múltiplas zonas de segurança segmentadas por VLANs. O projeto foi desenvolvido segundo os princípios de **defense in depth**, **menor privilégio** e **segmentação de rede**.

---

## 🏗️ Arquitetura Global

```
                    ┌─────────────────────────────────────┐
                    │          Rede Centro (WAN)           │
                    └────────────────┬────────────────────┘
                                     │
                              Router Cisco 4300
                                     │
              ┌──────────────────────┴──────────────────────┐
              │              VyOS (Pré-Produção)            │
              └───┬──────────────┬──────────────┬──────────┘
                  │              │              │
           VLAN 10 (Red)  VLAN 20 (Venus)  VLAN 30 (Marte)
           Kali Linux      pfSense          OPNsense
                           │                │
                    ┌──────┴──────┐  ┌──────┴──────┐
                    │   Orange    │  │   Orange    │
                    │  CentOS 7   │  │  WAF+IIS   │
                    └──────┬──────┘  └──────┬──────┘
                    ┌──────┴──────┐  ┌──────┴──────┐
                    │    Green    │  │    Green    │
                    │  AD + Win11 │  │  AD + Win  │
                    └─────────────┘  └─────────────┘
```

### Zonas de Segurança (VLANs)

| VLAN | Nome | Rede | Função |
|------|------|------|--------|
| 10 | **Red** | 10.10.50.65/29 | Auditoria e pentesting (Kali Linux) |
| 20 | VenusSuf | 10.20.50.97/29 | Trânsito para Firewall pfSense |
| 30 | MarteSuf | 10.30.50.129/29 | Trânsito para Firewall OPNsense |
| 103 | Gestão | 10.103.50.1/24 | Administração segura via SSH (isolada) |

---

## 📦 Componentes do Projeto

### Capítulo 1 — Introdução e Arquitectura de Rede
- Diagrama de rede global do Grupo AMM
- Tabela completa de endereços IP
- Ambiente de pré-produção com simulação VyOS

### Capítulo 2 — Infraestrutura de Rede (AMM)
- Configuração do Router Cisco 4300 (routing inter-VLAN, NAT/PAT, DHCP, ACLs)
- Comutação com Switches Huawei S5720S (SW1_AMM e SW2_AMM)
- Gestão e administração remota via SSH restrito à VLAN de gestão

### Capítulo 3 — Segurança Perimetral (OPNsense – MarteSuf)
- Instalação e configuração do OPNsense
- Criação de Autoridade de Certificação (CA) e certificados
- Configuração do Suricata como IDS/IPS

### Capítulo 4 — SIEM com Wazuh
- Instalação do Wazuh Manager no Linux Mint
- Agentes Wazuh em Windows Server, Ubuntu (Nessus), Win Core e Debian (WAF)
- Integração Suricata → Wazuh com decodificadores e regras de alerta personalizadas
- Respostas ativas automáticas

### Capítulo 5 — Active Directory (Windows Server)
- Instalação e promoção do servidor AD DS
- Configuração de utilizadores, grupos e OUs por departamento e localização geográfica
- Group Policy Objects (GPOs), Network Policies e permissões de rede

### Capítulo 6 — Cliente Windows 11 (Zona Green)
- Instalação e integração no domínio (Domain Join)
- Gestão de objetos de computador no Active Directory

### Capítulos 7 & 8 — Logging Centralizado
- Agente NXLog no Windows Server Core
- Rsyslog no WAF (Debian)
- Stack: syslog-ng + Loki + Promtail + Grafana

### Capítulo 9 — pfSense (VenusSuf) e Clientes
- Configuração pfSense e zonas Green/Orange Venus
- Windows 10 Client e Ubuntu 22.04 LTS

### Capítulo 10 — Análise de Vulnerabilidades e IDS
- Instalação e scan com Nessus (todas as VMs)
- Instalação e configuração do Snort

### Capítulo 11 — VPNs
- **WireGuard Roadwarrior** (VenusSuf/pfSense)
- **OpenVPN Roadwarrior** com autenticação RADIUS via Active Directory
- **IPSec Site-to-Site** entre VenusSuf e MarteSuf

---

## 🟠 Zona Orange — DMZ (Minha Contribuição)

> A Zona Orange corresponde à **DMZ (Demilitarized Zone)** — a camada de serviços expostos ao exterior, protegida por regras de firewall rigorosas.

### Arquitectura da Zona Orange

Foram implementadas **duas DMZs independentes**, uma por firewall:

```
pfSense (VenusSuf)              OPNsense (MarteSuf)
┌─────────────────────┐         ┌─────────────────────────────────┐
│  Orange VenusAMM    │         │      Orange MarteAMM            │
│                     │         │                                 │
│  CentOS 7           │         │  WAF (Debian + ModSecurity)     │
│  ├─ Apache          │         │  └─ Nginx como reverse proxy    │
│  ├─ Nginx           │         │                                 │
│  └─ 3 sites web     │         │  Windows Server Core 2022       │
│     (vulneráveis)   │         │  └─ IIS + MySQL (autenticação) │
└─────────────────────┘         └─────────────────────────────────┘
```

### Capítulo 12–13 — Orange VenusAMM (pfSense + CentOS)

**Servidor CentOS 7** com serviços Apache e Nginx alojando **3 sites web**:
- Configuração das regras WAN na firewall pfSense para expor os serviços
- Implementação dos 3 sites com diferentes configurações
- Validação de acessos externos aos sites

### Capítulo 14 — Orange MarteAMM (OPNsense + WAF + Windows Core IIS)

**WAF (Web Application Firewall)** em Debian Linux com **Nginx + ModSecurity**:
- Instalação e configuração do Debian como WAF
- Configuração do Nginx como reverse proxy
- Instalação do ModSecurity com ruleset OWASP
- **Testes de Bloqueio e Intrusão** para validação do WAF

### Capítulo 15 — Windows Server Core + IIS

**Windows Server Core 2022** como servidor web IIS:
- Instalação e configuração do Windows Server Core (headless)
- Configuração do IIS
- **Sistema de Autenticação com Base de Dados MySQL** integrado
- Interface web funcional com autenticação por formulário

---

## 🔴 Zona Red — Equipa Ofensiva (Minha Contribuição)

> A Zona Red representa a **componente ofensiva** do projeto — ataques controlados a partir da VLAN 10 para validação de todos os sistemas defensivos implementados.

### Capítulo 16 — Zona RED (Kali Linux)

**Plataforma:** Kali Linux na VLAN 10 (10.10.50.65/29)

#### Ferramentas Configuradas
- Nmap, Metasploit, hping3, Hydra, Burp Suite, Wireshark, entre outras

#### 1. Ataques Manuais e Exploração de Vulnerabilidades
- **Port Scan com Nmap** — enumeração de serviços e portos abertos em toda a infraestrutura
- **Análise dos sites vulneráveis** do servidor CentOS (Zona Orange VenusAMM)
- **Criação de Reverse Shell** sobre sistema Windows atualizado
- **Escalada de acesso via VPN OpenVPN** até à rede interna da MarteSuf (movimento lateral)
- **Análise de Movimento Lateral** do Kali até ao Windows Server

#### 2. Testes de VPN WireGuard (Site-to-Client)
- Implementação e teste da VPN WireGuard a partir da Zona Red
- Teste de conformidade: restrição de acesso para utilizadores comuns

#### 3. Ataques de Rede
- **Port Scan (Nmap)** — validação das regras de firewall e deteção por Snort/Suricata
- **DoS SYN Flood com hping3** — teste dos sistemas de deteção em tempo real
- **Ataques automatizados por Script** — Port Scan e SYN Flood encadeados

#### 4. Integração com SIEM (Wazuh)
- Todos os ataques foram monitorizados e validados no Wazuh em tempo real
- Confirmação de alertas Suricata integrados com dashboards Wazuh
- Validação de respostas ativas automáticas

---

## 🧰 Stack Tecnológica

| Categoria | Tecnologias |
|-----------|-------------|
| **Rede Física** | Cisco 4300, Huawei S5720S, VyOS |
| **Firewalls** | pfSense, OPNsense |
| **IDS/IPS** | Snort (pfSense), Suricata (OPNsense) |
| **SIEM** | Wazuh (Manager + Agentes) |
| **Logging** | NXLog, Rsyslog, syslog-ng, Loki, Promtail, Grafana |
| **Servidores Web** | Apache, Nginx, IIS (Windows Core) |
| **WAF** | ModSecurity + OWASP Ruleset |
| **VPNs** | WireGuard, OpenVPN (RADIUS/AD), IPSec |
| **Active Directory** | Windows Server 2022, AD DS, GPOs |
| **Vulnerabilidades** | Nessus |
| **Ofensivo (Red)** | Kali Linux, Nmap, hping3, Metasploit |
| **Base de Dados** | MySQL |
| **Sistemas Operativos** | Windows Server Core 2022, Windows 11, CentOS 7, Debian, Ubuntu, Linux Mint, Fedora |

---

## 📊 Dimensão do Projeto

- **452 páginas** de documentação técnica
- **17 capítulos** cobrindo todas as camadas da infraestrutura
- **2 firewalls** com arquiteturas distintas (pfSense + OPNsense)
- **4 zonas de segurança** (Red, Orange, Green, Gestão)
- **3 VPNs** implementadas (WireGuard, OpenVPN, IPSec)
- **SIEM** integrado com todos os componentes

---

## 🎓 Contexto Académico

Projeto desenvolvido no âmbito do curso **CET103 — Técnico Especialista em Cibersegurança (Nível 5)**, na unidade de formação **UF9197 — Wargaming**, sob orientação do Professor Fernando Ruela no CINEL — Polo de Lisboa.

---

*Documentação completa disponível em [`CET103_UF9197.pdf`](./CET103_UF9197.pdf)*
