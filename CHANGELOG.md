# Changelog

Все перечисленные изменения в релизе.

## [v1.5.1](https://github.com/Alfa-ao/var_dump/releases/tag/v1.5.1)

### Added

- Добавлен дамп значения через `userMods.FromValuedText` для `userdata` типа `ValuedText`.

### Changed

- Исправлена ошибка `attempt to concatenate a nil value` при извлечении hex-адреса `tostring():match( "0x(%x+)" )` для `userdata`.

- Изменен fallback-формат вывода для неизвестных `userdata`: теперь используется `header_indent .. string.format( "userdata(%s)%s", type_str, address )` вместо `string.format( "%s(%s)%s", prefix, tostring( value ) )`.
    - Исправлена ошибка в формате.

- Рефакторинг публичной функции `var_dump(...)`: обработка аргументов переписана с использования `select('#', ...)` на упаковку в таблицу `{ ... }`.