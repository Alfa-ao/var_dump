-- Маппинг для WidgetSafe:GetAddonType
local ENUM_ADDON_TYPE_MAP = {
    [ENUM_ADDON_TYPE_NONE] = "ENUM_ADDON_TYPE_NONE",
    [ENUM_ADDON_TYPE_USER] = "ENUM_ADDON_TYPE_USER",
    [ENUM_ADDON_TYPE_PROTECTED] = "ENUM_ADDON_TYPE_PROTECTED",
}

-- Маппинг для ValuedObject:GetType
local ENUM_VAL_OBJ_TYPE_MAP = {
    [VAL_OBJ_TYPE_UNKNOWN] = "VAL_OBJ_TYPE_UNKNOWN",
    [VAL_OBJ_TYPE_ITEM] = "VAL_OBJ_TYPE_ITEM",
    [VAL_OBJ_TYPE_SPELL] = "VAL_OBJ_TYPE_SPELL",
    [VAL_OBJ_TYPE_BUFF] = "VAL_OBJ_TYPE_BUFF",
    [VAL_OBJ_TYPE_ABILITY] = "VAL_OBJ_TYPE_ABILITY",
    [VAL_OBJ_TYPE_CREATURE] = "VAL_OBJ_TYPE_CREATURE",
    [VAL_OBJ_TYPE_PLAYER] = "VAL_OBJ_TYPE_PLAYER",
    [VAL_OBJ_TYPE_MOUNT] = "VAL_OBJ_TYPE_MOUNT",
    [VAL_OBJ_TYPE_CURRENCY] = "VAL_OBJ_TYPE_CURRENCY",
    [VAL_OBJ_TYPE_MEDAL] = "VAL_OBJ_TYPE_MEDAL",
    [VAL_OBJ_TYPE_POST_TYPE] = "VAL_OBJ_TYPE_POST_TYPE",
    [VAL_OBJ_TYPE_WISHMASTER] = "VAL_OBJ_TYPE_WISHMASTER",
    [VAL_OBJ_TYPE_QUEST] = "VAL_OBJ_TYPE_QUEST",
    [VAL_OBJ_TYPE_INSTANCED_EVENT] = "VAL_OBJ_TYPE_INSTANCED_EVENT",
    [VAL_OBJ_TYPE_DEVICE] = "VAL_OBJ_TYPE_DEVICE",
    [VAL_OBJ_TYPE_TABLE] = "VAL_OBJ_TYPE_TABLE",
    [VAL_OBJ_TYPE_ASTRAL_SECTOR] = "VAL_OBJ_TYPE_ASTRAL_SECTOR",
    [VAL_OBJ_TYPE_ZONE] = "VAL_OBJ_TYPE_ZONE",
    [VAL_OBJ_TYPE_UNLOCK] = "VAL_OBJ_TYPE_UNLOCK",
    [VAL_OBJ_TYPE_SKILL] = "VAL_OBJ_TYPE_SKILL",
    [VAL_OBJ_TYPE_MAP_MODIFIER] = "VAL_OBJ_TYPE_MAP_MODIFIER",
    [VAL_OBJ_TYPE_STRONGHOLD_PRODUCTION_SETTINGS] = "VAL_OBJ_TYPE_STRONGHOLD_PRODUCTION_SETTINGS",
    [VAL_OBJ_TYPE_STRONGHOLD_CATEGORY] = "VAL_OBJ_TYPE_STRONGHOLD_CATEGORY",
    [VAL_OBJ_TYPE_CHARACTER_CLASS] = "VAL_OBJ_TYPE_CHARACTER_CLASS",
    [VAL_OBJ_TYPE_LFG_DESTINATION] = "VAL_OBJ_TYPE_LFG_DESTINATION",
    [VAL_OBJ_TYPE_ACTION_GROUP] = "VAL_OBJ_TYPE_ACTION_GROUP",
}

-- Подсчет элементов в таблице не/индексируемой.
local function countEntries(tbl)
    local count = 0
    for _ in pairs(tbl) do
        count = count + 1
    end
    return count
end

-- Проверка на таблицу цвета (Color)
local function isColorTable(tbl)
    local count = 0
    local has_r, has_g, has_b, has_a = false, false, false, false
    for k, v in pairs(tbl) do
        count = count + 1
        if count > 4 then
            return false
        end
        if type(v) ~= "number" or v < 0 or v > 1 then
            return false
        end
        if k == "r" then
            has_r = true
        elseif k == "g" then
            has_g = true
        elseif k == "b" then
            has_b = true
        elseif k == "a" then
            has_a = true
        else
            return false
        end
    end
    return count == 4 and has_r and has_g and has_b and has_a
end

-- Проверка на таблицу позиции (GamePosition)
local function isGamePositionTable(tbl)
    local count = 0
    local has_x, has_y, has_z = false, false, false
    for k, v in pairs(tbl) do
        count = count + 1
        if count > 3 then
            return false
        end
        if type(v) ~= "number" then
            return false
        end
        if k == "posX" then
            has_x = true
        elseif k == "posY" then
            has_y = true
        elseif k == "posZ" then
            has_z = true
        else
            return false
        end
    end
    return count == 3 and has_x and has_y and has_z
end

-- Чистка от всякого хлама
local escaped = function( value ) 
    return value:gsub("[\a\b\f\n\r\t\v\\\"]", {
        ["\a"] = "\\a", ["\b"] = "\\b", ["\f"] = "\\f",
        ["\n"] = "\\n", ["\r"] = "\\r", ["\t"] = "\\t",
        ["\v"] = "\\v", ["\\"] = "\\\\", ["\""] = "\\\""
    })
end

--- Выводит содержимое переменной с типами и структурой.
--- Результат: Отформатированная строка дампа.
--- @param value any Переменная для дампа
--- @param depth? integer Максимальная глубина рекурсии (по умолчанию 10)
--- @param indent? integer Текущий отступ (внутреннее)
--- @param seen? table Таблица для отслеживания циклических ссылок (внутреннее)
--- @return string
local function var_dump_internal(value, depth, indent, seen)
    depth = depth or 10
    indent = indent or 0
    seen = seen or {}
    local indent_mode = "    "
    
    local indent_str = string.rep(indent_mode, indent)
    local type_str = apitype(value)
    
    -- Работа с nil. Если таблица { name = nil }, то вернёт пустое табло {}.
    if value == nil then
        return indent_str .. "nil"
    end
    
    -- Работа со стандартными типами и userdata
    if type_str ~= "table" then
        local prefix = indent_str .. type_str
        
        if type_str == "string" then
            return string.format('%s(%d) "%s"', prefix, #value, escaped(value))
        elseif type_str == "WString" then
            local str = userMods.FromWString(value)
            return string.format('%s(%d) "%s"', prefix, #str, escaped(str))
        elseif type_str == "number" then
            return string.format("%s(%s)", prefix, tostring(value))
        elseif type_str == "boolean" then
            return string.format("%s(%s)", prefix, value and "true" or "false")
        elseif type_str == "function" then
            return string.format("%s(%s)", prefix, tostring(value))
        elseif 
            type_str == "ComponentPropertyId" or
            type_str == "QuestId" or
            type_str == "SpellId" or
            type_str == "SkillId" or
            type_str == "ItemCategoryId" or
            type_str == "TextureId" or
            type_str == "UITextureId" or
            type_str == "VisObjectId" or
            type_str == "AliasVisObjectId" or
            type_str == "Sound2DId" or
            type_str == "MountTalentId"
        then -- Один из ResourceId
            local parts = { indent_str .. string.format("userdata(%s) = {", type_str) }
            local new_indent_str = string.rep(indent_mode, indent + 1)
            
            -- value:GetInfo(): table
            local info = value:GetInfo()
            if type(info) == "table" and next( info ) ~= nil then
                local dump = var_dump_internal(info, depth - 1, indent + 1, seen):sub(#new_indent_str + 1)
                table.insert(parts, indent_str .. indent_mode .. "GetInfo = " .. dump)
            end
             
            -- value:GetInstanceId(): light userdata | nil
            --[[ local instanceId = value:GetInstanceId()
            if type(instanceId) ~= nil then
                local dump = var_dump_internal(instanceId, depth - 1, indent + 1, seen):sub(#new_indent_str + 1)
                table.insert(parts, indent_str .. indent_mode .. "GetInstanceId = " .. dump)
            end ]]
            
            table.insert(parts, (#parts > 1 and indent_str or "") .. "}")
            return table.concat(parts, (#parts > 2 and "\n" or ""))
        elseif type_str:sub(1, 7) == "Widget_" then
            -- Конвертирует из (Widget_FormSafe и т.д.) в WidgetForm
            local display_type = type_str:gsub("_", ""):gsub("Safe$", "")
            local parts = { indent_str .. string.format("userdata(%s) = {", display_type) }
            
            -- GetAddonType
            local addonTypeNum = value:GetAddonType()
            if type(addonTypeNum) == "number" then
                local addonTypeStr = ENUM_ADDON_TYPE_MAP[addonTypeNum] or ("UNKNOWN(" .. tostring(addonTypeNum) .. ")")
                table.insert(parts, indent_str .. indent_mode .. "GetAddonType = " .. addonTypeStr)
            end
            
            -- GetAddonName
            local addonName = value:GetAddonName()
            table.insert(parts, indent_str .. indent_mode .. "GetAddonName = string(" .. #addonName .. ") \"" .. addonName .. "\"")
            
            -- GetDebugInfo
            local debugInfo = value:GetDebugInfo()
            table.insert(parts, indent_str .. indent_mode .. "GetDebugInfo = string(" .. #debugInfo .. ") \"" .. debugInfo .. "\"")
            
            -- GetFade
            local fade = value:GetFade()
            if type(fade) == "number" then
                table.insert(parts, indent_str .. indent_mode .. "GetFade = number(" .. fade .. ")")
            end
            
            -- GetBackgroundColor
            local okColor, bgColor = pcall(value.GetBackgroundColor, value)
            if okColor and bgColor ~= nil then
                local new_indent_str_color = string.rep(indent_mode, indent + 1)
                local colorDump = var_dump_internal(bgColor, depth - 1, indent + 1, seen)
                colorDump = colorDump:sub(#new_indent_str_color + 1)
                table.insert(parts, indent_str .. indent_mode .. "GetBackgroundColor = " .. colorDump)
            end
            
            -- GetBackgroundTexture
            local okHasBg, hasBg = pcall(value.HasBackground, value)
            if okHasBg and hasBg then
                local bgTex = value:GetBackgroundTexture()
                local texInfo = bgTex and common.GetTextureInfo( bgTex )
                if texInfo then
                    local new_indent_str_bg = string.rep(indent_mode, indent + 1)
                    local texDump = var_dump_internal(texInfo, depth - 1, indent + 1, seen)
                    texDump = texDump:sub(#new_indent_str_bg + 1)
                    table.insert(parts, indent_str .. indent_mode .. "GetBackgroundTexture = " .. texDump)
                else
                    table.insert(parts, indent_str .. indent_mode .. "GetBackgroundTexture = \"No texture\"")
                end
            end
            
            -- GetForegroundColor
            local okFgColor, fgColor = pcall(value.GetForegroundColor, value)
            if okFgColor and fgColor ~= nil then
                local new_indent_str_fg = string.rep(indent_mode, indent + 1)
                local fgDump = var_dump_internal(fgColor, depth - 1, indent + 1, seen)
                fgDump = fgDump:sub(#new_indent_str_fg + 1)
                table.insert(parts, indent_str .. indent_mode .. "GetForegroundColor = " .. fgDump)
            end

            -- GetForegroundTexture
            local okHasFg, hasFg = pcall(value.HasForeground, value)
            if okHasFg and hasFg then
                local fgTex = value:GetForegroundTexture()
                local texInfo = fgTex and common.GetTextureInfo( fgTex )
                if texInfo then
                    local new_indent_str_fg_tex = string.rep(indent_mode, indent + 1)
                    local texDump = var_dump_internal(texInfo, depth - 1, indent + 1, seen)
                    texDump = texDump:sub(#new_indent_str_fg_tex + 1)
                    table.insert(parts, indent_str .. indent_mode .. "GetForegroundTexture = " .. texDump)
                else
                    table.insert(parts, indent_str .. indent_mode .. "GetForegroundTexture = \"No texture\"")
                end
            end
            
            -- GetId
            local id = value:GetId()
            if type(id) == "number" then
                table.insert(parts, indent_str .. indent_mode .. "GetId = number(" .. id .. ")" )
            end
            
            -- GetName
            local nameStr = value:GetName()
            if type(nameStr) == "string" then
                table.insert(parts, indent_str .. indent_mode .. "GetName = string(" .. #nameStr .. ") \"" .. nameStr .. "\"")
            end
            
            -- GetNamedChildren (только имена)
            local children = value:GetNamedChildren()
            if type(children) == "table" then
                local child_parts = { indent_str .. indent_mode .. "GetNamedChildren = table(" .. #children .. ") {" }
                local child_indent_str = string.rep(indent_mode, indent + 2)
                for i, child in ipairs(children) do
                    local child_type_str = apitype(child)
                    local child_display_type = child_type_str:gsub("_", ""):gsub("Safe$", "")
                    local name_str = child:GetName()
                    table.insert(child_parts, string.format("%s[%d] => userdata(%s) = { GetName = string(%s) \"%s\" }", child_indent_str, i, child_display_type, #name_str, name_str))
                end
                table.insert(child_parts, indent_str .. indent_mode .. "}")
                table.insert(parts, table.concat(child_parts, "\n"))
            end
            
            -- GetParent (только имя)
            local parent = value:GetParent()
            if parent ~= nil then
                local parent_type_str = apitype(parent)
                local parent_display_type = parent_type_str:gsub("_", ""):gsub("Safe$", "")
                local name_str = "nil"
                if parent_type_str:sub(1, 7) == "Widget_" then
                    local parentName = parent:GetName()
                    if type(parentName) == "string" then
                        name_str = "\"" .. parentName .. "\""
                    end
                end
                table.insert(parts, string.format("%sGetParent = userdata(%s) = { GetName = %s }", indent_str .. indent_mode, parent_display_type, name_str))
            end
            
            -- GetPickChildrenOnly
            local pick = value:GetPickChildrenOnly()
            if type(pick) == "boolean" then
                table.insert(parts, indent_str .. indent_mode .. "GetPickChildrenOnly = boolean(" .. tostring(pick) .. ")")
            end
            
            -- GetPlacementPlain
            local placement = value:GetPlacementPlain()
            if type(placement) == "table" then
                local new_indent_str_placement = string.rep(indent_mode, indent + 1)
                local placementDump = var_dump_internal(placement, depth - 1, indent + 1, seen)
                placementDump = placementDump:sub(#new_indent_str_placement + 1)
                table.insert(parts, indent_str .. indent_mode .. "GetPlacementPlain = " .. placementDump)
            end
            
            table.insert(parts, indent_str .. "}")
            return table.concat(parts, "\n")
        elseif type_str == "ValuedObjectLua" then -- Изменен с ValuedObject
            local parts = { indent_str .. "userdata(ValuedObjectLua) = {" }
            local new_indent_str = string.rep(indent_mode, indent + 1)
            
            -- GetType
            local objType = value:GetType()
            if type(objType) == "number" then
                local objTypeStr = ENUM_VAL_OBJ_TYPE_MAP[objType] or ("UNKNOWN(" .. tostring(objType) .. ")")
                table.insert(parts, indent_str .. indent_mode .. "GetType = " .. objTypeStr)
            end
            
            -- GetId
            local objId = value:GetId()
            if objId ~= nil then
                local idDump = var_dump_internal(objId, depth - 1, indent + 1, seen):sub(#new_indent_str + 1)
                table.insert(parts, indent_str .. indent_mode .. "GetId = " .. idDump)
            end
            
            -- GetImage
            local objImage = value:GetImage()
            if objImage ~= nil and objImage ~= value then
                local imgDump = var_dump_internal(objImage, depth - 1, indent + 1, seen):sub(#new_indent_str + 1)
                table.insert(parts, indent_str .. indent_mode .. "GetImage = " .. imgDump)
            end
            
            -- GetShardName
            -- Метод доступен только у ValuedObjectPlayer.
            -- Иначе выбрасывает исключение: <UI::LuaValuedObjectGetShardName: ValuedObject is not ValuedObjectPlayer>
            if objType == VAL_OBJ_TYPE_PLAYER then
                local shardName = value:GetShardName()
                local shardDump = var_dump_internal(shardName, depth - 1, indent + 1, seen):sub(#new_indent_str + 1)
                table.insert(parts, indent_str .. indent_mode .. "GetShardName = " .. shardDump)
            end

            -- GetText
            local objText = value:GetText()
            if objText ~= nil then
                local textDump = var_dump_internal(objText, depth - 1, indent + 1, seen):sub(#new_indent_str + 1)
                table.insert(parts, indent_str .. indent_mode .. "GetText = " .. textDump)
            end

            table.insert(parts, indent_str .. "}")
            return table.concat(parts, "\n")
        elseif type_str == "ValuedText" then
            local parts = { indent_str .. "userdata(ValuedText) = {" }
            local str = userMods.FromWString(value:ToWString())
            table.insert(parts, string.format('%s    ToWString = WString(%d) "%s"', indent_str, #str, escaped(str)))
            table.insert(parts, indent_str .. "}")
            return table.concat(parts, "\n")
        elseif 
            type_str == "RelatedSoundsLua" or 
            type_str == "RelatedTextsLua" or 
            type_str == "RelatedTexturesLua" or 
            type_str == "RelatedWidgetsLua" 
        then
            local parts = { indent_str .. string.format("userdata(%s) = {", type_str) }
            local new_indent_str = string.rep(indent_mode, indent + 1)
            
            -- GetList
            local list = value:GetList()
            if type(list) == "table" then
                local listDump = var_dump_internal(list, depth - 1, indent + 1, seen):sub(#new_indent_str + 1)
                table.insert(parts, indent_str .. indent_mode .. "GetList = " .. listDump)
            end
            
            table.insert(parts, indent_str .. "}")
            return table.concat(parts, "\n")
        elseif type_str == "userdata" then
            return string.format("%s(%s)", prefix, tostring(value))
        elseif type_str == "thread" then
            return prefix .. "(coroutine)"
        end
        
        return prefix
    end
    
    -- Работа с таблицами
    if seen[value] then
        return indent_str .. "*RECURSION*"
    end
    
    -- Когда доходит до предела итерация
    if depth <= 0 then
        return indent_str .. "table(...)"
    end
    
    seen[value] = true
    
    -- Определение заголовка таблицы (Color, GamePosition или обычный счетчик)
    local table_header
    if isColorTable(value) then
        table_header = "table(Color) {"
    elseif isGamePositionTable(value) then
        table_header = "table(GamePosition) {"
    else
        table_header = string.format("table(%d) {", countEntries(value))
    end

    local parts = { indent_str .. table_header }
    local new_depth = depth - 1
    local new_indent = indent + 1
    local new_indent_str = string.rep(indent_mode, new_indent)
    
    -- Сбор ключей
    local keys = {}
    local k = nil
    while true do
        k = next(value, k)
        if k == nil then
            break
        end
        table.insert(keys, k)
    end
    
    -- Сортировка ключей: сначала числа, потом строки, потом остальные
    table.sort(keys, function(a, b)
        local ta, tb = type(a), type(b)
        if ta == "number" and tb == "number" then return a < b end
        if ta == "number" then return true end
        if tb == "number" then return false end
        if ta == "string" and tb == "string" then return a < b end
        return ta < tb
    end)
    
    for _, k in ipairs(keys) do
        local v = value[k]
        local key_str
        if type(k) == "string" and k:match("^[%a_][%w_]*$") then
            key_str = string.format('["%s"]', k)
        else
            key_str = string.format("[%s]", tostring(k))
        end
        
        local dump = v == nil and "nil" or var_dump_internal(v, new_depth, new_indent, seen):sub(#new_indent_str + 1)
        
        table.insert(parts, string.format("%s => %s", new_indent_str .. key_str, dump))
    end
    
    table.insert(parts, indent_str .. "}")
    return table.concat(parts, "\n")
end

-- Публичная функция
function var_dump(...)
    local results = {}
    local n = select('#', ...)
    
    for i = 1, n do
        local value = select(i, ...)
        local result = var_dump_internal(value, 10, 0, {})
        table.insert(results, result)
    end
    
    
    local info = "Debug info var_dump:\n" .. 
        "======================BEGIN======================\n" .. 
        table.concat(results, "\n----------------------\n") .. "\n" .. 
        "=======================END=======================\n"
    
    common.LogInfo( "common", info )
end