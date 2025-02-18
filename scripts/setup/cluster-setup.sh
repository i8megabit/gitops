#!/bin/bash
#  _  _____ ____  
# | |/ / _ \___ \ 
# | ' / (_) |__) |
# | . \> _ </ __/ 
# |_|\_\___/_____|
#            by @eberil
#
# Copyright (c) 2023-2025 Mikhail Eberil (@eberil)
# This code is free! Share it, spread peace and technology!

# Определение пути к директории скрипта и корню репозитория
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/../.." && pwd)"

# Загрузка общих переменных и баннеров
source "${SCRIPT_DIR}/env.sh"
source "${SCRIPT_DIR}/ascii_banners.sh"

# Функция очистки при ошибках
cleanup() {
    echo -e "${RED}Произошла ошибка, выполняем очистку...${NC}"
    
    # Удаление манифестов
    rm -f "${REPO_ROOT}/helm-charts/manifests/etcd.yaml" \
          "${REPO_ROOT}/helm-charts/manifests/kube-apiserver.yaml" \
          "${REPO_ROOT}/helm-charts/manifests/kube-controller-manager.yaml" \
          "${REPO_ROOT}/helm-charts/manifests/kube-scheduler.yaml"
    
    # Удаление конфигурационных файлов
    rm -f "${REPO_ROOT}/kind-config.yaml" \
          "${REPO_ROOT}/kubeconfig.yaml"
    
    # Удаление кластера если он был создан
    if kind get clusters 2>/dev/null | grep -q "^${CLUSTER_NAME}$"; then
        echo -e "${YELLOW}Удаляем кластер ${CLUSTER_NAME}...${NC}"
        kind delete cluster --name "${CLUSTER_NAME}"
    fi
    
    # Очистка Docker
    echo -e "${YELLOW}Очистка Docker ресурсов...${NC}"
    docker system prune -f
    
    error_banner
    echo -e "${RED}Установка прервана. Проверьте логи для деталей.${NC}"
    exit 1
}

# Установка trap для перехвата ошибок
trap cleanup ERR

# Функция проверки ошибок
check_error() {
    if [ $? -ne 0 ]; then
        echo -e "${RED}Ошибка: $1${NC}"
        cleanup
    fi
}

# Функция проверки зависимостей
check_dependencies() {
    echo -e "${CYAN}Проверка зависимостей...${NC}"
    
    # Проверка Docker
    if ! command -v docker &> /dev/null; then
        echo -e "${RED}Docker не установлен${NC}"
        exit 1
    fi
    
    # Проверка nvidia-smi
    if ! command -v nvidia-smi &> /dev/null; then
        echo -e "${RED}NVIDIA драйверы не установлены${NC}"
        exit 1
    fi

    # Проверка kind
    if ! command -v kind &> /dev/null; then
        echo -e "${YELLOW}Kind не установлен, устанавливаем...${NC}"
        go install sigs.k8s.io/kind@latest
    fi
}

# Функция настройки Docker и NVIDIA
setup_docker_nvidia() {
    echo -e "${CYAN}Настройка Docker и NVIDIA...${NC}"
    
    # Запуск скрипта настройки Docker
    sudo "${SCRIPT_DIR}/docker-setup.sh"
    check_error "Ошибка настройки Docker"
}

# Функция загрузки zakenak
setup_zakenak() {
    echo -e "${CYAN}Загрузка Zakenak...${NC}"
    
    # Загрузка последней версии образа
    docker pull ghcr.io/i8megabit/zakenak:latest
    check_error "Ошибка загрузки образа Zakenak"
}

# Функция создания кластера
setup_cluster() {
    echo -e "${CYAN}Создание кластера...${NC}"
    
    # Генерация конфигурации кластера
    "${SCRIPT_DIR}/generate-kubeconfig.sh"
    check_error "Ошибка генерации конфигурации кластера"
    
    # Проверка существующего кластера
    if kind get clusters 2>/dev/null | grep -q "^${CLUSTER_NAME}$"; then
        echo -e "${YELLOW}Обнаружен существующий кластер '${CLUSTER_NAME}'. Удаляем...${NC}"
        kind delete cluster --name "${CLUSTER_NAME}"
        check_error "Не удалось удалить существующий кластер"
        sleep 5
    fi
    
    # Создание нового кластера
    kind create cluster --name "${CLUSTER_NAME}" --config "${REPO_ROOT}/kind-config.yaml"
    check_error "Ошибка создания кластера"
    
    # Ожидание готовности узлов
    echo -e "${CYAN}Ожидание готовности узлов кластера...${NC}"
    kubectl wait --for=condition=Ready nodes --all --timeout=300s
    check_error "Узлы кластера не готовы"

    # Обновление kubeconfig правильными данными
    kind get kubeconfig --name "${CLUSTER_NAME}" > "${REPO_ROOT}/kubeconfig.yaml"
    check_error "Ошибка обновления kubeconfig"
}

# Функция установки компонентов
install_components() {
    echo -e "${CYAN}Установка компонентов...${NC}"
    
    # Создание namespace
    kubectl create namespace prod --dry-run=client -o yaml | kubectl apply -f -
    
    # Подготовка монтирования для Docker
    MOUNT_FLAGS=(
        -v "$(pwd):/workspace"
        -v "${HOME}/.kube:/root/.kube"
        -v "${HOME}/.cache/zakenak:/root/.cache/zakenak"
        --network host
    )

    # Установка компонентов через zakenak в Docker
    echo -e "${CYAN}Запуск конвергентного развертывания через zakenak...${NC}"
    docker run --gpus all \
        "${MOUNT_FLAGS[@]}" \
        -e NVIDIA_VISIBLE_DEVICES=all \
        -e NVIDIA_DRIVER_CAPABILITIES=compute,utility \
        ghcr.io/i8megabit/zakenak:latest \
        converge \
        --config /workspace/zakenak.yaml
    check_error "Ошибка развертывания компонентов"

    # Проверка статуса развертывания
    echo -e "${CYAN}Проверка статуса компонентов...${NC}"
    docker run --gpus all \
        "${MOUNT_FLAGS[@]}" \
        ghcr.io/i8megabit/zakenak:latest \
        status
    check_error "Ошибка проверки статуса компонентов"

    # Ожидание готовности всех компонентов
    echo -e "${CYAN}Ожидание готовности всех компонентов...${NC}"
    kubectl wait --for=condition=Ready pods --all -n prod --timeout=300s
    check_error "Компоненты не готовы"
}


# Функция проверки установки
verify_installation() {
    echo -e "${CYAN}Проверка установки...${NC}"
    
    # Проверка узлов
    kubectl get nodes
    check_error "Ошибка получения списка узлов"
    
    # Проверка подов
    kubectl get pods -n prod
    check_error "Ошибка получения списка подов"
    
    # Проверка GPU
    kubectl exec -it -n prod deployment/ollama -- nvidia-smi
    check_error "Ошибка проверки GPU"
}

# Основная функция
main() {
    # Отображение баннера
    k8s_banner
    echo ""
    
    echo -e "${YELLOW}Начинаем установку кластера...${NC}"
    
    # Выполнение шагов установки
    check_dependencies
    setup_docker_nvidia
    setup_zakenak
    setup_cluster
    install_components
    verify_installation
    
    echo -e "\n"
    success_banner
    echo -e "\n${GREEN}Установка кластера успешно завершена!${NC}"
}

# Запуск установки
main
