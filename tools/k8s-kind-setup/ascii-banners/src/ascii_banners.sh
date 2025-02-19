#!/usr/bin/bash
#  _    _ _    _ _          _  __      _    _ _    _ _          _  __ 
# | |  | | |  | | |   /\   | |/ /     | |  | | |  | | |   /\   | |/ / 
# | |__| | |  | | |  /  \  | ' /      | |__| | |  | | |  /  \  | ' / 
# |  __  | |  | | | / /\ \ |  <       |  __  | |  | | | / /\ \ |  <  
# | |  | | |__| | |/ ____ \| . \      | |  | | |__| | |/ ____ \| . \ 
# |_|  |_|\____/|_/_/    \_\_|\_\     |_|  |_|\____/|_/_/    \_\_|\_\
#                                                           by @eberil
#
# Copyright (c) 2023-2025 Mikhail Eberil (@eberil)
# This code is free! Share it, spread peace and technology!

# Определение цветов
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

# DevOps Banner
devops_banner() {
	echo -e "${BLUE}"
	cat << "EOF"
#  ____             ___              
# |  _ \  _____   _/ _ \ _ __  ___  
# | | | |/ _ \ \ / / | | | '_ \/ __| 
# | |_| |  __/\ V /| |_| | |_) \__ \ 
# |____/ \___| \_/  \___/| .__/|___/ 
#                        |_|          
EOF
	echo -e "${NC}"
	echo "Copyright (c) 2023-2025 Mikhail Eberil (@eberil)"
	echo "This code is free! Share it, spread peace and technology!"
	echo '"Because DevOps is about sharing and caring"'
}

# Функция проверки поддержки цвета терминалом
check_color_support() {
	if ! test -t 1; then
		# Терминал не поддерживает цвет или это не терминал
		RED=''
		GREEN=''
		YELLOW=''
		BLUE=''
		CYAN=''
		NC=''
	fi
}

# Инициализация
check_color_support

# Ingress Banner
ingress_banner() {
	echo -e "${BLUE}"
	cat << "EOF"
  ___                              
 |_ _|_ __   __ _ _ __ ___  ___ ___
  | || '_ \ / _` | '__/ _ \/ __/ __|
  | || | | | (_| | | |  __/\__ \__ \
 |___|_| |_|\__, |_|  \___||___/___/
			|___/                    
							  by @eberil
EOF
	echo -e "${NC}"
}

# DNS Banner
dns_banner() {
	echo -e "${BLUE}"
	cat << "EOF"
  ____  _   _ ____  
 |  _ \| \ | / ___| 
 | | | |  \| \___ \ 
 | |_| | |\  |___) |
 |____/|_| \_|____/ 
            by @eberil
EOF
	echo -e "${NC}"
}

# Cert Manager Banner
cert_manager_banner() {
	echo -e "${BLUE}"
	cat << "EOF"
   ____ _____ ____ _____ 
  / ___|  ___| __ )_   _|
 | |   | |_  |  _ \ | |  
 | |___|  _| | |_) || |  
\____|_|   |____/ |_|  
							by @eberil
EOF
	echo -e "${NC}"
}

# Dashboard Banner
dashboard_banner() {
	echo -e "${BLUE}"
	cat << "EOF"
  ____            _     _                         _ 
 |  _ \  __ _ ___| |__ | |__   ___   __ _ _ __ | |
 | | | |/ _` / __| '_ \| '_ \ / _ \ / _` | '_ \| |
 | |_| | (_| \__ \ | | | |_) | (_) | (_| | | | | |
 |____/ \__,_|___/_| |_|_.__/ \___/ \__,_|_| |_|_|
										 by @eberil
EOF
	echo -e "${NC}"
}

# K8s Banner
k8s_banner() {
    echo -e "${BLUE}"
    cat << "EOF"
  _  __    ___  ____  
 | |/ /   ( _ )/ ___| 
 | ' /    / _ \\___ \ 
 | . \   | (_) |___) |
 |_|\_\   \___/|____/ 
                by @eberil
EOF
    echo -e "${NC}"