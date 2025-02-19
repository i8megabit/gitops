# WSL2 Setup Tool для Zakenak

## Версия
1.0.0

## Описание
Инструмент для автоматической настройки WSL2 окружения с поддержкой NVIDIA GPU для Kubernetes кластера Kind.

## Особенности
- 🚀 Автоматическая настройка WSL2
- 🎮 Установка и настройка CUDA
- 🔧 Установка Docker с NVIDIA Container Runtime
- 📊 Проверка системных требований
- ⚡ Оптимизация конфигурации

## Системные требования

### Hardware
- NVIDIA GPU (Compute Capability 7.0+)
- Минимум 16GB RAM
- SSD хранилище
- PCIe x16 слот

### Software
- Windows 11 с WSL2
- Ubuntu 22.04 LTS
- NVIDIA Driver 535.104.05+

## Структура
```
.
├── src/                 # Исходный код
│   └── setup-wsl.sh    # Основной скрипт
├── tests/              # Тесты
├── README.md           # Документация
└── CHANGELOG.md        # История версий
```

## Использование
```bash
# Базовое использование
./src/setup-wsl.sh

# С дополнительными опциями
./src/setup-wsl.sh --cuda-version 12.8 --memory 32
```

## Переменные окружения
| Переменная | Описание | По умолчанию |
|------------|----------|--------------|
| `CUDA_VERSION` | Версия CUDA | `12.8` |
| `REQUIRED_MEMORY` | Минимальный объем RAM (GB) | `16` |
| `WSL_DISTRO` | Дистрибутив WSL | `Ubuntu-22.04` |

## Проверки
- Наличие WSL2
- Версия драйвера NVIDIA
- Доступная память
- Наличие GPU

## Логирование
Все операции логируются в стандартный вывод с указанием этапа выполнения.

## Обработка ошибок
- Проверка результатов каждой операции
- Информативные сообщения об ошибках
- Безопасное завершение при сбоях

## Поддержка
- Email: i8megabit@gmail.com
- GitHub Issues: [Создать issue](https://github.com/i8megabit/zakenak/issues)
- Документация: [Руководство пользователя](../../../docs/)

## Лицензия
```plain text
Copyright (c) 2023-2025 Mikhail Eberil (@eberil)
Released under MIT License
```