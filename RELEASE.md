# Релизы Ƶakenak™®
```ascii
 ______     _                      _    
|___  /    | |                    | |   
   / / __ _| |  _ _   ___     ___ | |  _
  / / / _` | |/ / _`||  _ \ / _` || |/ /
 / /_| (_| |  < by_Eberil| | (_| ||   < 
/_____\__,_|_|\_\__,||_| |_|\__,_||_|\_\

Should Harbour?	No.
```
## [1.0.0] - 2024-01-20

### 🎉 Первый стабильный релиз

Мы рады представить первый стабильный релиз Ƶakenak™® - инновационного инструмента для GitOps и деплоя, специально разработанного для эффективной Helm-оркестрации кластеров Kubernetes с поддержкой GPU.

### ✨ Основные возможности

#### Core Services
- Полная поддержка cert-manager для управления TLS сертификатами
- Интегрированный local-ca для локального центра сертификации
- Система инжекции TLS прокси (sidecar-injector)

#### AI Services
- Интеграция с Ollama для LLM с GPU-ускорением
- Поддержка open-webui для управления моделями
- Оптимизированная работа с NVIDIA GPU в WSL2

#### Infrastructure
- Нативная поддержка NVIDIA device plugin
- Настроенная CoreDNS конфигурация
- Встроенный Ingress контроллер с TLS

#### Security
- Комплексная система Network Policies
- Предустановленная RBAC конфигурация
- Безопасное хранение креденшелов

### 🔧 Системные требования
- Go 1.21+
- WSL2 (Ubuntu 22.04 LTS)
- Docker с NVIDIA Container Runtime
- NVIDIA GPU + драйверы 535.104.05+
- CUDA Toolkit 12.8
- Kind v0.20.0+
- Helm 3.0+

### 📝 Изменения

#### Added
- Единый бинарный файл без внешних зависимостей
- Встроенная поддержка GitOps и конвергенции
- Интеграция с container registry
- Нативная поддержка WSL2 и NVIDIA GPU
- Система шаблонизации конфигураций
- Полная документация и примеры использования

#### Security
- Встроенная поддержка RBAC
- Безопасное хранение креденшелов
- Валидация конфигураций
- TLS для всех сервисов

### 🐛 Известные проблемы
- При использовании WSL2 может потребоваться дополнительная настройка NVIDIA драйверов
- Ограничения на одновременное использование нескольких GPU в режиме shared

### 📚 Документация
- Полное руководство пользователя доступно в [docs/](docs/)
- Примеры конфигураций в [examples/](examples/)
- API Reference в [docs/api.md](docs/api.md)

[1.0.0]: https://github.com/i8megabit/zakenak/releases/tag/v1.0.0

```plain text
Copyright (c) 2024 Mikhail Eberil

This file is part of Zakenak project and is released under the terms of the MIT License. See LICENSE file in the project root for full license information.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.

The name "Zakenak" and associated branding are trademarks of @eberil and may not be used without express written permission.
```