// Package state предоставляет типы и функции для управления состоянием системы
package state

import (
    "time"
)

// StateManager определяет интерфейс для управления состоянием
type StateManager interface {
    Load() (*State, error)
    Save(*State) error
    Update(func(*State) error) error
}

// State представляет текущее состояние системы
type State struct {
    Version     string                 `json:"version"`     // Версия формата состояния
    LastUpdate  time.Time             `json:"lastUpdate"`  // Время последнего обновления
    Components  map[string]Component  `json:"components"`  // Карта компонентов системы
    Volumes     map[string]Volume     `json:"volumes"`     // Карта томов
    GPU         GPUState              `json:"gpu"`         // Состояние GPU
    Status      Status                `json:"status"`      // Текущий статус системы
}

// Status представляет текущий статус системы
type Status struct {
    Phase          Phase      `json:"phase"`          // Текущая фаза
    LastTransition time.Time  `json:"lastTransition"` // Время последнего перехода
    Message        string     `json:"message"`        // Дополнительное сообщение
}

// Phase представляет возможные фазы состояния системы
type Phase string

// Определение возможных фаз
const (
    PhaseInitializing Phase = "Initializing" // Система инициализируется
    PhaseRunning     Phase = "Running"      // Система работает
    PhaseStopping    Phase = "Stopping"     // Система останавливается
    PhaseStopped     Phase = "Stopped"      // Система остановлена
    PhaseError       Phase = "Error"        // Произошла ошибка
    PhaseDeploying   Phase = "Deploying"    // Система разворачивается
)

// Component представляет состояние отдельного компонента системы,
// включая его версию, статус и время последней синхронизации.
type Component struct {
    Name        string    `json:"name"`       // Имя компонента
    Version     string    `json:"version"`    // Версия компонента
    Status      Status    `json:"status"`     // Текущий статус
    LastSync    time.Time `json:"lastSync"`   // Время последней синхронизации
}

// Volume представляет информацию о томе в системе,
// включая его размер и связанные компоненты.
type Volume struct {
    Name        string    `json:"name"`       // Имя тома
    Path        string    `json:"path"`       // Путь монтирования
    Size        string    `json:"size"`       // Размер тома
    LastUsed    time.Time `json:"lastUsed"`   // Время последнего использования
    Components  []string  `json:"components"` // Список компонентов, использующих том
}

// GPUState представляет состояние GPU в системе,
// включая информацию о драйвере и устройствах.
type GPUState struct {
    Enabled     bool         `json:"enabled"`    // Флаг включения GPU
    Driver      string       `json:"driver"`     // Версия драйвера
    Memory      string       `json:"memory"`     // Доступная память
    Devices     []Device     `json:"devices"`    // Список GPU устройств
    Security    GPUSecurity  `json:"security"`   // Настройки безопасности GPU
}

// GPUSecurity определяет настройки безопасности для GPU
type GPUSecurity struct {
    Isolation      bool     `json:"isolation"`      // Изоляция GPU ресурсов
    MemoryLimit    string   `json:"memoryLimit"`    // Лимит памяти на контейнер
    TimeSlice      int      `json:"timeSlice"`      // Временной слот для GPU (мс)
    AllowedDevices []string `json:"allowedDevices"` // Разрешенные GPU устройства
    Capabilities   []string `json:"capabilities"`    // Разрешенные возможности
}

// Device представляет отдельное GPU устройство в системе.
type Device struct {
    ID          string    `json:"id"`         // Идентификатор устройства
    Name        string    `json:"name"`       // Название устройства
    Memory      string    `json:"memory"`     // Память устройства
    InUse       bool      `json:"inUse"`      // Флаг использования
}



