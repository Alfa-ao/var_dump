# var_dump

Инструмент отладки для вывода структурированной информации о переменных: содержимое, типы данных и вложенная структура. Поддерживает передачу нескольких аргументов.

```lua
var_dump( value: any, ... )
```

Для вывода информации должна быть включена запись в mods.txt.

`Меню` - `Интерфейс` - `Общие настройки` - `Запись ошибок пользовательских дополнений`

Аллоды Онлайн\Personal\Logs\mods.txt

**Ограничения:**

```lua
common.LogInfo( "common", info ) -- Ограничение 64000 символов.
```

**Стандартные настройки:**

```lua
local __CONFIG_VAR_DUMP = {
    DEBUG = {
        depth = 10 -- Максимальная глубина рекурсии. table(...) { 1 => table(...) { 1 => И т.д.. } }
    },
    WIDGET = {
        GetPlacementPlain = true,
        GetSmartPlacementPlain = false,
        GetRealRect = false,
        GetNamedChildren = false, -- false: Использовать только имена, иначе может забить весь лог до ограничения
        IsEnabled = true,
        IsEnabledEx = true,
        IsVisible = true,
        IsVisibleEx = true,
    },
    RESOURCE_ID = {
        GetOnlyInfo = false, -- true: Использовать только метод ResourceId:GetInfo
    },
    USERDATA = {
        hexadecimal = false, -- Показывать адрес хранения #0x0f810b80. userdata(name)#0x0f810b80 = { ... }
    },
    TABLE = {
        tableIdentification = true, -- Распознать таблицу и присвоить ей имя. table (Color) { ... }
    },
}
```

---

## Идентификация статических таблиц

```lua
-- table(WidgetPlacementLua:N) { ... }
-- table(Color:N) { ... }
var_dump( widget:GetPlacementPlain(), { r = 1, g = 0, b = 0, a = 0.2 } )
```

```lua
======================BEGIN======================
table(WidgetPlacementLua:10) {
    ["alignX"] => number(WIDGET_ALIGN_BOTH(3))
    ["alignY"] => number(WIDGET_ALIGN_BOTH(3))
    ["highPosX"] => number(0)
    ["highPosY"] => number(0)
    ["posX"] => number(0)
    ["posY"] => number(0)
    ["sizeX"] => number(0)
    ["sizeY"] => number(0)
    ["sizingX"] => number(WIDGET_SIZING_DEFAULT(0))
    ["sizingY"] => number(WIDGET_SIZING_DEFAULT(0))
}
----------------------
table(Color:4) {
    ["a"] => number(0.2)
    ["b"] => number(0)
    ["g"] => number(0)
    ["r"] => number(1)
}
=======================END=======================
```

---

## Стандартный дебаг

```lua
var_dump( avatar.GetAlchemyInfo() )
```

```lua
======================BEGIN======================
table(12) {
    ["active"] => boolean(false)
    ["correctionCount"] => number(4)
    ["defaultResultCount"] => number(1)
    ["drumSize"] => number(24)
    ["drumsCount"] => number(0)
    ["finished"] => boolean(false)
    ["id"] => userdata(SkillId)#0x3bb5b280 = {
        GetInfo = table(7) {
            ["description"] => WString(261) "Ремесло, которое позволяет создавать зелья различного действия. С их помощью на некоторое время можно улучшить характеристики персонажа, восстановить здоровье, защититься от урона или злых чар противника, увеличить наносимый урон или наложить негативный эффект."
            ["image"] => userdata(UITextureId)#0x3bbb2288 = {}
            ["name"] => WString(7) "Алхимия"
            ["sysName"] => string(7) "Alchemy"
            ["sysType"] => string(22) "ENUM_SkillType_Alchemy"
            ["type"] => number(1)
            ["useLevels"] => boolean(true)
        }
    }
    ["perComponentBonus"] => number(0)
    ["perfectBonus"] => number(0)
    ["reactionInited"] => boolean(false)
    ["recipes"] => table(250) {
        [0] => userdata(RecipeId)#0x3bb5a1a0 = {
            avatar.GetRecipeInfo = table(12) {
                ["bindResult"] => boolean(false)
                ["components"] => table(5) {
                    [0] => userdata(ComponentPropertyId)#0x3bbbd4c8 = {
                        avatar.GetComponentInfo = table(4) {
                            ["description"] => WString(0) ""
                            ["id"] => userdata(ComponentPropertyId) = *RECURSION*
                            ["image"] => userdata(UITextureId)#0x3bbbf188 = {}
                            ["name"] => WString(8) "Скорость"
                        }
                    }
                    [1] => userdata(ComponentPropertyId)#0x3bbbd508 = {
                        avatar.GetComponentInfo = table(4) {
                            ["description"] => WString(0) ""
                            ["id"] => userdata(ComponentPropertyId) = *RECURSION*
                            ["image"] => userdata(UITextureId)#0x3bbc23d8 = {}
                            ["name"] => WString(14) "Жизненная сила"
                        }
                    }
                    [2] => userdata(ComponentPropertyId)#0x3bbbd548 = {
                        avatar.GetComponentInfo = table(4) {
                            ["description"] => WString(0) ""
                            ["id"] => userdata(ComponentPropertyId) = *RECURSION*
                            ["image"] => userdata(UITextureId)#0x3bbc49f8 = {}
                            ["name"] => WString(9) "Медитация"
                        }
                    }
                    [3] => userdata(ComponentPropertyId)#0x3bbbd588 = {
                        avatar.GetComponentInfo = table(4) {
                            ["description"] => WString(0) ""
                            ["id"] => userdata(ComponentPropertyId) = *RECURSION*
                            ["image"] => userdata(UITextureId)#0x3bbc6fc8 = {}
                            ["name"] => WString(5) "Пламя"
                        }
                    }
                    [4] => userdata(ComponentPropertyId)#0x3bbbd5f8 = {
                        avatar.GetComponentInfo = table(4) {
                            ["description"] => WString(0) ""
                            ["id"] => userdata(ComponentPropertyId) = *RECURSION*
                            ["image"] => userdata(UITextureId)#0x3bbc9610 = {}
                            ["name"] => WString(11) "Жар пустыни"
                        }
                    }
                }
                ["defaultItem"] => number(276580)
                ["description"] => userdata(ValuedText)#0x3bbbd2c8 = {
                    ToWString = WString(116) "Увеличивает скорость передвижения в мирной обстановке. Имеет общее время восстановления со вспомогательными зельями."
                }
                ["id"] => userdata(RecipeId) = *RECURSION*
                ["image"] => userdata(UITextureId)#0x3bbbd308 = {}
                ["name"] => WString(27) "Джиннский эликсир марафонца"
                ["nextRecipePoints"] => number(0)
                ["resultItems"] => table(1) {
                    [0] => number(276580)
                }
                ["resultQuantity"] => number(1)
                ["score"] => number(93)
                ["skillId"] => userdata(SkillId)#0x3bbbd410 = {
                    GetInfo = table(7) {
                        ["description"] => WString(261) "Ремесло, которое позволяет создавать зелья различного действия. С их помощью на некоторое время можно улучшить характеристики персонажа, восстановить здоровье, защититься от урона или злых чар противника, увеличить наносимый урон или наложить негативный эффект."
                        ["image"] => userdata(UITextureId)#0x3bbd1228 = {}
                        ["name"] => WString(7) "Алхимия"
                        ["sysName"] => string(7) "Alchemy"
                        ["sysType"] => string(22) "ENUM_SkillType_Alchemy"
                        ["type"] => number(1)
                        ["useLevels"] => boolean(true)
                    }
                }
            }
        }
        
        ...
    }
}
```

---

## Обнаружение рекурсий

```lua
local a = { w = userMods.ToWString( "rrr" ), d = nil}
local b = { c = a.w, a = a }
a.d = b
var_dump( a )
```

Исключение введено для пользовательского типа `WString`. Тип имеет конечную структуру.

```lua
======================BEGIN======================
table(2) {
    ["d"] => table(2) {
        ["a"] => table(0) = *RECURSION*
        ["c"] => WString(3) "rrr"
    }
    ["w"] => WString(3) "rrr" -- Тут могла бы быть *RECURSION*
}
=======================END=======================
```

---

## Информация по виджету

```lua
var_dump( common.GetAddonMainForm( "UserAddon/LibreAlchemyV2" ) )
```

```lua
======================BEGIN======================
userdata(WidgetForm)#0x3bb59ed8 = {
    GetDebugInfo = string(136) "[192735][WidgetForm]: (UserAddon/LibreAlchemyV2)->mainForm, Resource: Mods/Addons/LibreAlchemyV2/Widgets/LibreAlchemyV2.(WidgetForm).xdb"
    GetAddonType = number(ENUM_ADDON_TYPE_USER(1))
    GetId = number(192735)
    GetAddonName = string(24) "UserAddon/LibreAlchemyV2"
    GetName = string(14) "LibreAlchemyV2"
    GetPriority = number(10000)
    GetNamedChildren = table(1) {
        [1] => userdata(WidgetPanel)#0x3bb689d8 = {
            GetDebugInfo = string(137) "[192736][WidgetPanel]: (UserAddon/LibreAlchemyV2)->mainForm.wtPanel, Resource: Mods/Addons/LibreAlchemyV2/Widgets/Panel.(WidgetPanel).xdb"
            GetAddonType = number(ENUM_ADDON_TYPE_USER(1))
            GetId = number(192736)
            GetAddonName = string(24) "UserAddon/LibreAlchemyV2"
            GetName = string(5) "Panel"
            GetPriority = number(0)
            GetBackgroundColor = table(Color:4) {
                ["a"] => number(1)
                ["b"] => number(1)
                ["g"] => number(1)
                ["r"] => number(1)
            }
            GetBackgroundTexture = table(TextureInfo:5) {
                ["binaryFile"] => string(72) "Mods/Addons/LibreAlchemyV2/Widgets/Text/Textures/Tooltip.(UITexture).bin"
                ["realHeight"] => number(84)
                ["realWidth"] => number(84)
                ["type"] => number(DXT5:2)
                ["xdbFile"] => string(72) "Mods/Addons/LibreAlchemyV2/Widgets/Text/Textures/Tooltip.(UITexture).xdb"
            }
            GetNamedChildren = table(1) {
                [1] => userdata(WidgetTextContainer)#0x3b989ae8 = {
                    GetDebugInfo = string(168) "[192737][WidgetTextContainer]: (UserAddon/LibreAlchemyV2)->mainForm.wtPanel.wtouText, Resource: Mods/Addons/LibreAlchemyV2/Widgets/Text/ouText.(WidgetTextContainer).xdb"
                    GetAddonType = number(ENUM_ADDON_TYPE_USER(1))
                    GetId = number(192737)
                    GetAddonName = string(24) "UserAddon/LibreAlchemyV2"
                    GetName = string(6) "ouText"
                    GetPriority = number(0)
                    GetNamedChildren = table(1) {
                        [1] => userdata(WidgetPanel)#0x3bafe708 = {
                            GetDebugInfo = string(99) "[192738][RD]: (UserAddon/LibreAlchemyV2)->mainForm.wtPanel.wtouText.wt__Border, Resource: [Runtime]"
                            GetAddonType = number(ENUM_ADDON_TYPE_USER(1))
                            GetId = number(192738)
                            GetAddonName = string(24) "UserAddon/LibreAlchemyV2"
                            GetName = string(8) "__Border"
                            GetPriority = number(0)
                            GetNamedChildren = table(1) {
                                [1] => userdata(WidgetPanel)#0x3bbbbd08 = {
                                    GetDebugInfo = string(111) "[192739][RD]: (UserAddon/LibreAlchemyV2)->mainForm.wtPanel.wtouText.wt__Border.wt__Content, Resource: [Runtime]"
                                    GetAddonType = number(ENUM_ADDON_TYPE_USER(1))
                                    GetId = number(192739)
                                    GetAddonName = string(24) "UserAddon/LibreAlchemyV2"
                                    GetName = string(9) "__Content"
                                    GetPriority = number(0)
                                    GetParent = userdata(WidgetPanel)#0x3bbbdda0 = { GetName = "__Border" }
                                    IsEnabled = boolean(true)
                                    IsEnabledEx = boolean(true)
                                    IsVisible = boolean(true)
                                    IsVisibleEx = boolean(false)
                                    GetTransparentInput = boolean(false)
                                    GetPickChildrenOnly = boolean(true)
                                    GetFade = number(1)
                                    GetTabOrder = number(0)
                                    GetPlacementPlain = table(WidgetPlacementLua:10) {
                                        ["alignX"] => number(WIDGET_ALIGN_BOTH(3))
                                        ["alignY"] => number(WIDGET_ALIGN_LOW(0))
                                        ["highPosX"] => number(0)
                                        ["highPosY"] => number(0)
                                        ["posX"] => number(0)
                                        ["posY"] => number(0)
                                        ["sizeX"] => number(0)
                                        ["sizeY"] => number(0)
                                        ["sizingX"] => number(WIDGET_SIZING_DEFAULT(0))
                                        ["sizingY"] => number(WIDGET_SIZING_DEFAULT(0))
                                    }
                                }
                            }
                            GetParent = userdata(WidgetTextContainer)#0x3bbb3028 = { GetName = "ouText" }
                            IsEnabled = boolean(true)
                            IsEnabledEx = boolean(true)
                            IsVisible = boolean(true)
                            IsVisibleEx = boolean(false)
                            GetTransparentInput = boolean(false)
                            GetPickChildrenOnly = boolean(false)
                            GetFade = number(1)
                            GetTabOrder = number(0)
                            GetPlacementPlain = table(WidgetPlacementLua:10) {
                                ["alignX"] => number(WIDGET_ALIGN_BOTH(3))
                                ["alignY"] => number(WIDGET_ALIGN_BOTH(3))
                                ["highPosX"] => number(0)
                                ["highPosY"] => number(0)
                                ["posX"] => number(0)
                                ["posY"] => number(0)
                                ["sizeX"] => number(0)
                                ["sizeY"] => number(0)
                                ["sizingX"] => number(WIDGET_SIZING_DEFAULT(0))
                                ["sizingY"] => number(WIDGET_SIZING_DEFAULT(0))
                            }
                        }
                    }
                    GetParent = userdata(WidgetPanel)#0x3bbc2b88 = { GetName = "Panel" }
                    IsEnabled = boolean(true)
                    IsEnabledEx = boolean(true)
                    IsVisible = boolean(true)
                    IsVisibleEx = boolean(false)
                    GetTransparentInput = boolean(true)
                    GetPickChildrenOnly = boolean(true)
                    GetFade = number(1)
                    GetTabOrder = number(0)
                    GetPlacementPlain = table(WidgetPlacementLua:10) {
                        ["alignX"] => number(WIDGET_ALIGN_LOW(0))
                        ["alignY"] => number(WIDGET_ALIGN_LOW(0))
                        ["highPosX"] => number(0)
                        ["highPosY"] => number(0)
                        ["posX"] => number(15)
                        ["posY"] => number(15)
                        ["sizeX"] => number(570)
                        ["sizeY"] => number(0)
                        ["sizingX"] => number(WIDGET_SIZING_DEFAULT(0))
                        ["sizingY"] => number(WIDGET_SIZING_INTERNAL(1))
                    }
                }
            }
            GetParent = userdata(WidgetForm)#0x3bbd6000 = { GetName = "LibreAlchemyV2" }
            IsEnabled = boolean(true)
            IsEnabledEx = boolean(true)
            IsVisible = boolean(true)
            IsVisibleEx = boolean(false)
            GetTransparentInput = boolean(false)
            GetPickChildrenOnly = boolean(false)
            GetFade = number(1)
            GetTabOrder = number(0)
            GetPlacementPlain = table(WidgetPlacementLua:10) {
                ["alignX"] => number(WIDGET_ALIGN_LOW(0))
                ["alignY"] => number(WIDGET_ALIGN_LOW(0))
                ["highPosX"] => number(-639)
                ["highPosY"] => number(-967)
                ["posX"] => number(590)
                ["posY"] => number(922)
                ["sizeX"] => number(600)
                ["sizeY"] => number(100)
                ["sizingX"] => number(WIDGET_SIZING_DEFAULT(0))
                ["sizingY"] => number(WIDGET_SIZING_DEFAULT(0))
            }
        }
    }
    IsEnabled = boolean(true)
    IsEnabledEx = boolean(true)
    IsVisible = boolean(false)
    IsVisibleEx = boolean(false)
    GetTransparentInput = boolean(false)
    GetPickChildrenOnly = boolean(true)
    GetFade = number(1)
    GetTabOrder = number(0)
    GetPlacementPlain = table(WidgetPlacementLua:10) {
        ["alignX"] => number(WIDGET_ALIGN_BOTH(3))
        ["alignY"] => number(WIDGET_ALIGN_BOTH(3))
        ["highPosX"] => number(0)
        ["highPosY"] => number(0)
        ["posX"] => number(0)
        ["posY"] => number(0)
        ["sizeX"] => number(0)
        ["sizeY"] => number(0)
        ["sizingX"] => number(WIDGET_SIZING_DEFAULT(0))
        ["sizingY"] => number(WIDGET_SIZING_DEFAULT(0))
    }
}
=======================END=======================
```