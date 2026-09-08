# var_dump

Функция выводит структурированную информацию о переменной или нескольких входных данных, что содержится, какие типы, какова структура.

```lua
var_dump( value: any, ... )
```

Для вывода информации должна быть включена запись в mods.txt.

`Меню` - `Интерфейс` - `Общие настройки` - `Запись ошибок пользовательских дополнений`

Аллоды Онлайн\Personal\Logs\mods.txt

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

## Определение статических таблиц

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
    ["id"] => userdata(SkillId)#0x269f4a08 = {
        GetInfo = table(7) {
            ["description"] => WString(261) "Ремесло, которое позволяет создавать зелья различного действия. С их помощью на некоторое время можно улучшить характеристики персонажа, восстановить здоровье, защититься от урона или злых чар противника, увеличить наносимый урон или наложить негативный эффект."
            ["image"] => userdata(UITextureId)#0x269cd3a8 = {}
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
        [0] => userdata(RecipeId)#0x269f8b58 = {
            avatar.GetRecipeInfo = table(12) {
                ["bindResult"] => boolean(false)
                ["components"] => table(5) {
                    [0] => userdata(ComponentPropertyId)#0x26a1bda8 = {
                        avatar.GetComponentInfo = table(4) {
                            ["description"] => WString(0) ""
                            ["id"] => userdata(ComponentPropertyId) = *RECURSION*
                            ["image"] => userdata(UITextureId)#0x26a1d508 = {}
                            ["name"] => WString(10) "Отравление"
                        }
                    }
                    [1] => userdata(ComponentPropertyId)#0x26a1bde8 = {
                        avatar.GetComponentInfo = table(4) {
                            ["description"] => WString(0) ""
                            ["id"] => userdata(ComponentPropertyId) = *RECURSION*
                            ["image"] => userdata(UITextureId)#0x26a20548 = {}
                            ["name"] => WString(6) "Распад"
                        }
                    }
                    [2] => userdata(ComponentPropertyId)#0x26a1be28 = {
                        avatar.GetComponentInfo = table(4) {
                            ["description"] => WString(0) ""
                            ["id"] => userdata(ComponentPropertyId) = *RECURSION*
                            ["image"] => userdata(UITextureId)#0x26a22748 = {}
                            ["name"] => WString(10) "Отравление"
                        }
                    }
                    [3] => userdata(ComponentPropertyId)#0x26a1be68 = {
                        avatar.GetComponentInfo = table(4) {
                            ["description"] => WString(0) ""
                            ["id"] => userdata(ComponentPropertyId) = *RECURSION*
                            ["image"] => userdata(UITextureId)#0x26a24848 = {}
                            ["name"] => WString(10) "Поднебесье"
                        }
                    }
                    [4] => userdata(ComponentPropertyId)#0x26a1bed8 = {
                        avatar.GetComponentInfo = table(4) {
                            ["description"] => WString(0) ""
                            ["id"] => userdata(ComponentPropertyId) = *RECURSION*
                            ["image"] => userdata(UITextureId)#0x26a26b40 = {}
                            ["name"] => WString(10) "Волшебство"
                        }
                    }
                }
                ["defaultItem"] => number(28216)
                ["description"] => userdata(ValuedText)#0x26a1bba8 = {
                    ToWString = WString(129) "Отравляет цель, нанося периодический урон ядом каждые 2 сек. в течение 8 сек. Имеет общее время восстановления с боевыми зельями."
                }
                ["id"] => userdata(RecipeId) = *RECURSION*
                ["image"] => userdata(UITextureId)#0x26a1bbe8 = {}
                ["name"] => WString(25) "Склянка с астральным ядом"
                ["nextRecipePoints"] => number(0)
                ["resultItems"] => table(1) {
                    [0] => number(28216)
                }
                ["resultQuantity"] => number(5)
                ["score"] => number(67)
                ["skillId"] => userdata(SkillId)#0x26a1bcf0 = {
                    GetInfo = table(7) {
                        ["description"] => WString(261) "Ремесло, которое позволяет создавать зелья различного действия. С их помощью на некоторое время можно улучшить характеристики персонажа, восстановить здоровье, защититься от урона или злых чар противника, увеличить наносимый урон или наложить негативный эффект."
                        ["image"] => userdata(UITextureId)#0x26a2df40 = {}
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
userdata(WidgetForm)#0x26a18ba8 = {
    GetDebugInfo = string(136) "[114070][WidgetForm]: (UserAddon/LibreAlchemyV2)->mainForm, Resource: Mods/Addons/LibreAlchemyV2/Widgets/LibreAlchemyV2.(WidgetForm).xdb"
    GetAddonType = number(ENUM_ADDON_TYPE_USER(1))
    GetId = number(114070)
    GetAddonName = string(24) "UserAddon/LibreAlchemyV2"
    GetName = string(14) "LibreAlchemyV2"
    GetPriority = number(10000)
    GetNamedChildren = table(1) {
        [1] => userdata(WidgetPanel)#0x26a16068 = {
            GetDebugInfo = string(137) "[114071][WidgetPanel]: (UserAddon/LibreAlchemyV2)->mainForm.wtPanel, Resource: Mods/Addons/LibreAlchemyV2/Widgets/Panel.(WidgetPanel).xdb"
            GetAddonType = number(ENUM_ADDON_TYPE_USER(1))
            GetId = number(114071)
            GetAddonName = string(24) "UserAddon/LibreAlchemyV2"
            GetName = string(5) "Panel"
            GetPriority = number(0)
            GetBackgroundTexture = table(5) {
                ["binaryFile"] => string(72) "Mods/Addons/LibreAlchemyV2/Widgets/Text/Textures/Tooltip.(UITexture).bin"
                ["realHeight"] => number(84)
                ["realWidth"] => number(84)
                ["type"] => number(DXT5:2)
                ["xdbFile"] => string(72) "Mods/Addons/LibreAlchemyV2/Widgets/Text/Textures/Tooltip.(UITexture).xdb"
            }
            GetNamedChildren = table(1) {
                [1] => userdata(WidgetTextContainer)#0x26a18350 = {
                    GetDebugInfo = string(168) "[114072][WidgetTextContainer]: (UserAddon/LibreAlchemyV2)->mainForm.wtPanel.wtouText, Resource: Mods/Addons/LibreAlchemyV2/Widgets/Text/ouText.(WidgetTextContainer).xdb"
                    GetAddonType = number(ENUM_ADDON_TYPE_USER(1))
                    GetId = number(114072)
                    GetAddonName = string(24) "UserAddon/LibreAlchemyV2"
                    GetName = string(6) "ouText"
                    GetPriority = number(0)
                    GetNamedChildren = table(1) {
                        [1] => userdata(WidgetPanel)#0x269fdfe0 = {
                            GetDebugInfo = string(99) "[114073][RD]: (UserAddon/LibreAlchemyV2)->mainForm.wtPanel.wtouText.wt__Border, Resource: [Runtime]"
                            GetAddonType = number(ENUM_ADDON_TYPE_USER(1))
                            GetId = number(114073)
                            GetAddonName = string(24) "UserAddon/LibreAlchemyV2"
                            GetName = string(8) "__Border"
                            GetPriority = number(0)
                            GetNamedChildren = table(1) {
                                [1] => userdata(WidgetPanel)#0x269fe868 = {
                                    GetDebugInfo = string(111) "[114074][RD]: (UserAddon/LibreAlchemyV2)->mainForm.wtPanel.wtouText.wt__Border.wt__Content, Resource: [Runtime]"
                                    GetAddonType = number(ENUM_ADDON_TYPE_USER(1))
                                    GetId = number(114074)
                                    GetAddonName = string(24) "UserAddon/LibreAlchemyV2"
                                    GetName = string(9) "__Content"
                                    GetPriority = number(0)
                                    GetParent = userdata(WidgetPanel)#0x269fe868 = { GetName = "__Border" }
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
                            GetParent = userdata(WidgetTextContainer)#0x269fdfe0 = { GetName = "ouText" }
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
                    GetParent = userdata(WidgetPanel)#0x26a18350 = { GetName = "Panel" }
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
            GetParent = userdata(WidgetForm)#0x26a16068 = { GetName = "LibreAlchemyV2" }
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