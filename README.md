```ascii
	 ______     _                      _    
	|___  /    | |                    | |   
	   / / __ _| |  _ _   ___     ___ | |  _
	  / / / _` | |/ / _`||  _ \ / _` || |/ /
	 / /_| (_| |  < by_Eberil| | (_| ||   < 
	/_____\__,_|_|\_\__,||_| |_|\__,_||_|\_\
  
	Should Harbour?				
```

# [Zakenak](https://dic.academic.ru/dic.nsf/dic_synonims/390396/%D1%87%D0%B0%D0%BA%D0%B0%D0%BD%D0%B0%D0%BAчаканак "др.-чув. чӑканӑк — бухта, залив")
[![Go Report Card](https://goreportcard.com/badge/github.com/i8megabit/zakenak)](https://goreportcard.com/report/github.com/i8megabit/zakenak)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![Release](https://img.shields.io/github/v/release/i8megabit/zakenak)][def]

## О проекте
Zakenak — это инновационный инструмент для GitOps и деплоя, специально разработанный для эффективной Helm-оркестрации кластеров Kubernetes с поддержкой GPU.

### Ключевые особенности
- 🚀 **Единый бинарный файл** без внешних зависимостей
- 🔄 **Встроенная поддержка GitOps** и конвергенции
- 🐳 **Интеграция с container registry**
- 🖥️ **Нативная поддержка WSL2** и NVIDIA GPU
- 📝 **Упрощенная но мощная** система шаблонизации

## Системные требования
- Go 1.21+
- WSL2 (Ubuntu 22.04 LTS)
- Docker с поддержкой NVIDIA Container Runtime
- NVIDIA GPU + драйверы (версия 535 или выше)
- CUDA Toolkit 12.8
- Kind v0.20.0+
- Helm 3.0+

## Быстрый старт

### Установка из исходного кода
```bash
# Клонирование репозитория
git clone https://github.com/i8megabit/zakenak
cd zakenak

# Сборка
make build

# Установка
sudo make install
```

### Базовая конфигурация
```yaml
project: myapp
environment: prod

deploy:
  namespace: prod
  charts:
    - ./helm/myapp
```

### Основные команды
```bash
# Конвергенция состояния
zakenak converge

# Сборка образов
zakenak build

# Деплой в кластер
zakenak deploy
```
## Использование Docker образа
```bash
# Получение образа
docker pull ghcr.io/i8megabit/zakenak:latest

# Базовое использование
docker run -v $(pwd):/workspace \
    -v ~/.kube:/root/.kube \
    ghcr.io/i8megabit/zakenak:latest converge

# Использование с GPU
docker run --gpus all \
    -v $(pwd):/workspace \
    -v ~/.kube:/root/.kube \
    -e NVIDIA_VISIBLE_DEVICES=all \
    -e NVIDIA_DRIVER_CAPABILITIES=compute,utility \
    ghcr.io/i8megabit/zakenak:latest converge
```

## Базовая конфигурация
```bash
project: myapp
environment: prod

registry:
    url: registry.local
    username: ${REGISTRY_USER}
    password: ${REGISTRY_PASS}

deploy:
    namespace: prod
    charts:
        - ./helm-charts/cert-manager
        - ./helm-charts/local-ca
        - ./helm-charts/ollama
        - ./helm-charts/open-webui
    values:
        - values.yaml
        - values-prod.yaml

build:
    context: .
    dockerfile: Dockerfile
    args:
        VERSION: v1.0.0
    gpu:
        enabled: true
        runtime: nvidia
        memory: "8Gi"
        devices: "all"
```

## Основные команды
```bash
# Конвергенция состояния
zakenak converge

# Сборка образов
zakenak build

# Деплой в кластер
zakenak deploy
```

## Переменные окружения

Переменные окружения
Переменная	Описание	По умолчанию
KUBECONFIG	Путь к kubeconfig	~/.kube/config
ZAKENAK_DEBUG	Включение отладки	false
NVIDIA_VISIBLE_DEVICES	GPU устройства	all
REGISTRY_USER	Пользователь registry	-
REGISTRY_PASS	Пароль registry	-
## Архитектура
```mermaid
graph TD
    A[Git Repository] --> B[Ƶakanak]
    B --> C[Container Registry]
    B --> D[Kubernetes Cluster]
    B --> E[State Manager]
```

## Компоненты
- 💫 **State Manager**: Управление состоянием кластера
- 🔧 **Build System**: Сборка с поддержкой GPU
- 🎯 **Deploy Engine**: Умный деплой в Kubernetes
- 🔄 **GitOps Controller**: Синхронизация с Git
- 🎮 **CLI Interface**: Удобное управление

## Безопасность
- 🔒 Защита интеллектуальной собственности
- 🛡️ Встроенная поддержка RBAC
- 🔐 Безопасное хранение креденшелов
- ✅ Валидация конфигураций

## Лицензирование
Zakenak распространяется под модифицированной MIT лицензией с защитой торговой марки. Использование названия "Zakenak" требует письменного разрешения владельца.

## Поддержка
- 📚 [Документация](docs/)
- 💡 [Примеры](examples/)
- 🔧 [Устранение неполадок](docs/troubleshooting.md)
- 📖 [API Reference](docs/api.md)

## Авторы
- [@eberil](https://github.com/eberil) - Основной разработчик

## Благодарности
- Команде Werf за вдохновение
- Сообществу Kubernetes
- Всем контрибьюторам

[def]: https://github.com/i8megabit/zakenak/releases
