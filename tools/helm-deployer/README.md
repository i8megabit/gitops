# Helm Deployer для Zakenak
```ascii
     ______     _                      _    
    |___  /    | |                    | |   
       / / __ _| |  _ _   ___     ___ | |  _
      / / / _` | |/ / _`||  _ \ / _` || |/ /
     / /_| (_| |  < by_Eberil| | (_| ||   < 
    /_____\__,_|_|\_\__,||_| |_|\__,_||_|\_\
  
    Should Harbour?	No.

## Версия
1.1.0

## Описание
Универсальный инструмент для деплоя Helm чартов с поддержкой GPU-ускоренных сервисов в среде WSL2. Обеспечивает автоматическое развертывание и управление компонентами Zakenak.

## Особенности
- 🚀 Автоматическое определение зависимостей чартов
- 🔄 Поддержка различных окружений (dev, stage, prod)
- 🎮 Интеграция с NVIDIA GPU в WSL2
- 🔒 Автоматическая настройка RBAC и безопасности
- 📊 Встроенный мониторинг развертывания

## Системные требования

### Hardware
- NVIDIA GPU с поддержкой CUDA (Compute Capability 7.0+)
- Минимум 16GB RAM
- SSD хранилище

### Software
- WSL2 (Ubuntu 22.04 LTS)
- Helm 3.x
- Kubernetes 1.25+
- NVIDIA Driver 535.104.05+
- CUDA Toolkit 12.8
- Docker с NVIDIA Container Runtime

## Установка
```bash
# Сделать скрипт исполняемым
chmod +x deploy-chart.sh

# Проверка GPU доступности
nvidia-smi

# Проверка CUDA
nvcc --version
```

## Конфигурация

### Базовая структура values
```yaml
global:
	environment: prod
	gpu:
		enabled: true
		runtime: nvidia
		memory: "8Gi"
		devices: "all"

deployment:
	namespace: prod
	charts:
		- name: ollama
			version: 0.1.0
			values:
				- values.yaml
				- values-prod.yaml
```

### Переменные окружения
```bash
# GPU конфигурация
export NVIDIA_VISIBLE_DEVICES=all
export NVIDIA_DRIVER_CAPABILITIES=compute,utility
export CUDA_VISIBLE_DEVICES=0
```

## Использование

### Базовый деплой
```bash
./deploy-chart.sh -e prod -c ./helm-charts/ollama
```

### Деплой с GPU
```bash
./deploy-chart.sh -e prod -c ./helm-charts/ollama --gpu-enabled
```

### Отладочный режим
```bash
./deploy-chart.sh -e dev --debug
```

## Структура проекта
```
helm-deployer/
├── deploy-chart.sh     # Основной скрипт
├── lib/                # Вспомогательные функции
│   ├── gpu.sh         # GPU утилиты
│   ├── helm.sh        # Helm утилиты
│   └── validate.sh    # Валидация
├── templates/          # Шаблоны values
└── examples/          # Примеры конфигураций
```

## Мониторинг

### GPU метрики
```bash
# Проверка GPU статуса
nvidia-smi

# Мониторинг использования
nvidia-smi dmon
```

### Helm статус
```bash
# Проверка релизов
helm ls -n prod

# История релиза
helm history ollama -n prod
```

## Безопасность
- Автоматическая настройка RBAC
- Изоляция ресурсов GPU
- Валидация конфигураций
- Безопасное хранение креденшелов

## Устранение неполадок

### GPU проблемы
```bash
# Проверка драйверов
nvidia-smi

# Проверка CUDA
nvcc --version

# Проверка Docker runtime
docker info | grep -i runtime
```

### Helm проблемы
```bash
# Проверка чарта
helm lint ./helm-charts/ollama

# Отладка установки
helm install --dry-run --debug
```

## Поддержка
- Email: i8megabit@gmail.com
- GitHub Issues: [Создать issue](https://github.com/i8megabit/zakenak/issues)
- Документация: [Руководство пользователя](docs/)

```plain text
Copyright (c) 2023-2025 Mikhail Eberil (@eberil)

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```