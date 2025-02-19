# ASCII Banners Tool

## Версия
1.0.0

## Описание
Инструмент для генерации ASCII баннеров в скриптах развертывания Zakenak. Предоставляет единый стиль и брендинг для всех компонентов системы.

## Особенности
- 🎨 Единый стиль для всех компонентов
- 📦 Готовые баннеры для разных сценариев
- 🔄 Простая интеграция в скрипты
- 🛠 Поддержка цветного вывода
- 📝 Встроенные копирайты

## Использование
```bash
# Загрузка баннеров
source ascii_banners.sh

# Использование баннеров
devops_banner    # DevOps баннер
deploy_banner    # Deploy баннер
k8s_banner       # Kubernetes баннер
production_banner # Production баннер
error_banner     # Error баннер
success_banner   # Success баннер
```

## Доступные баннеры
| Баннер | Описание | Использование |
|--------|-----------|--------------|
| devops_banner | DevOps операции | Общие DevOps скрипты |
| deploy_banner | Развертывание | Скрипты деплоя |
| k8s_banner | Kubernetes | K8s операции |
| production_banner | Production | Продакшн деплои |
| error_banner | Ошибки | Сообщения об ошибках |
| success_banner | Успех | Успешные операции |
| charts_banner | Helm Charts | Операции с чартами |
| eberil_banner | Брендинг | Общий брендинг |
| coffee_banner | Перерыв | Длительные операции |
| debug_banner | Отладка | Режим отладки |
| yaml_banner | YAML | Операции с YAML |
| devops_life_banner | DevOps Life | Общие сообщения |
| panic_banner | Паника | Критические ошибки |
| dns_banner | DNS | DNS операции |
| check_banner | Проверки | Проверка статуса |

## Интеграция
1. Добавьте source в ваш скрипт:
```bash
source "${SCRIPT_DIR}/ascii_banners.sh"
```

2. Используйте баннеры:
```bash
production_banner
echo "Starting deployment..."
```

## Зависимости
- Bash 4.0+
- Unicode поддержка терминала
- Цветной вывод терминала

## Поддержка
- [GitHub Issues](https://github.com/i8megabit/zakenak/issues)
- [Документация](../../docs/)