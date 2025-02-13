# GitOps Repository

## Версия
1.3.8

## Описание
Монорепозиторий для управления Kubernetes-инфраструктурой и приложениями.

## Последние изменения
- Добавлена поддержка локального DNS-резолвинга
- Настроена маршрутизация для сервисов ollama и open-webui

## Структура репозитория
- /helm-charts - Helm чарты для приложений
- /tools - Инструменты для управления кластером
    - /k8s-kind-setup - Скрипты настройки локального кластера
    - /helm-deployer - Инструменты для деплоя

## Использование
1. Настройка кластера:
```bash
./tools/k8s-kind-setup/setup-ingress.sh
```

2. Проверка DNS:
```bash
ping ollama.prod.local
ping webui.prod.local
```
