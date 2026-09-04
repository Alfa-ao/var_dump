-- Включение и настройка опций для участия дамба
local __CONFIG_VAR_DUMP = {
    WIDGET = {
        GetPlacementPlain = true,
        GetSmartPlacementPlain = true,
        GetRealRect = true,
        GetNamedChildrenRecursive = false, -- false (только имена, ибо может забить весь лог до ограничения)
    },
    RESOURCE_ID = {
        GetOnlyInfo = false, -- Использовать только ResourceId:GetInfo
    },
}

-- Если появился тип TWidget
local ENABLE_TWIDGET = type( rawget( _G, "IsTWidget" ) ) == "function"

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

-- Маппинг констант для (WidgetPlacementLua)
local WIDGET_ALIGN_MAP = {
    [WIDGET_ALIGN_LOW] = "WIDGET_ALIGN_LOW",
    [WIDGET_ALIGN_HIGH] = "WIDGET_ALIGN_HIGH",
    [WIDGET_ALIGN_CENTER] = "WIDGET_ALIGN_CENTER",
    [WIDGET_ALIGN_BOTH] = "WIDGET_ALIGN_BOTH",
    [WIDGET_ALIGN_LOW_ABS] = "WIDGET_ALIGN_LOW_ABS",
}

-- Маппинг констант для sizingX / sizingY
local WIDGET_SIZING_MAP = {
    [WIDGET_SIZING_DEFAULT] = "WIDGET_SIZING_DEFAULT",
    [WIDGET_SIZING_CHILDREN] = "WIDGET_SIZING_CHILDREN",
    [WIDGET_SIZING_INTERNAL] = "WIDGET_SIZING_INTERNAL",
}

-- Маппинг констант для (дней)
local ENUM_DAY_OF_WEEK_MAP = {
    [ENUM_Monday] = "ENUM_Monday",
    [ENUM_Tuesday] = "ENUM_Tuesday",
    [ENUM_Wednesday] = "ENUM_Wednesday",
    [ENUM_Thursday] = "ENUM_Thursday",
    [ENUM_Friday] = "ENUM_Friday",
    [ENUM_Saturday] = "ENUM_Saturday",
    [ENUM_Sunday] = "ENUM_Sunday",
}

-- Маппинг констант для (месяцев)
local ENUM_MONTH_MAP = {
    [ENUM_Month_January] = "ENUM_Month_January",
    [ENUM_Month_February] = "ENUM_Month_February",
    [ENUM_Month_March] = "ENUM_Month_March",
    [ENUM_Month_April] = "ENUM_Month_April",
    [ENUM_Month_May] = "ENUM_Month_May",
    [ENUM_Month_June] = "ENUM_Month_June",
    [ENUM_Month_July] = "ENUM_Month_July",
    [ENUM_Month_August] = "ENUM_Month_August",
    [ENUM_Month_September] = "ENUM_Month_September",
    [ENUM_Month_October] = "ENUM_Month_October",
    [ENUM_Month_November] = "ENUM_Month_November",
    [ENUM_Month_December] = "ENUM_Month_December",
}

-- Маппинг констант для (LuaSexInfoPart)
local ENUM_SEX_MAP = {
    [SEX_UNKNOWN] = "SEX_UNKNOWN",
    [SEX_MALE] = "SEX_MALE",
    [SEX_FEMALE] = "SEX_FEMALE",
}

-- Маппинг констант для (MutationInfo)
local ENUM_ZONE_TIER_DIFFICULTY_MAP = {
    [ZONE_TIER_DIFFICULTY_DEFAULT] = "ZONE_TIER_DIFFICULTY_DEFAULT",
    [ZONE_TIER_DIFFICULTY_NONE] = "ZONE_TIER_DIFFICULTY_NONE",
    [ZONE_TIER_DIFFICULTY_EASY] = "ZONE_TIER_DIFFICULTY_EASY",
    [ZONE_TIER_DIFFICULTY_MEDIUM] = "ZONE_TIER_DIFFICULTY_MEDIUM",
    [ZONE_TIER_DIFFICULTY_HARD] = "ZONE_TIER_DIFFICULTY_HARD",
    [ZONE_TIER_DIFFICULTY_INSANE] = "ZONE_TIER_DIFFICULTY_INSANE",
}

-- Подсчет элементов в таблице не/индексируемой.
local function countEntries(tbl)
    local count = 0
    for _ in pairs(tbl) do
        count = count + 1
    end
    return count
end

-- Проверка на таблицу (Color)
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

-- Проверка на таблицу (GamePosition)
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

-- Проверка на таблицу (WidgetPlacementLua)
local function isWidgetPlacementTable(tbl)
    local requiredKeys = { "alignX", "alignY", "highPosX", "highPosY", "posX", "posY", "sizeX", "sizeY", "sizingX", "sizingY" }
    local count = 0
    for k, v in pairs(tbl) do
        count = count + 1
        if count > 10 then return false end
        if type(v) ~= "number" then return false end
        local found = false
        for _, rk in ipairs(requiredKeys) do
            if k == rk then
                found = true
                break
            end
        end
        if not found then return false end
    end
    return count == 10
end

-- Проверка на таблицу (Geodata)
local function isGeodataTable(tbl)
    local count = 0
    local expected = { x = true, y = true, width = true, height = true }
    local found = {}
    for k, v in pairs(tbl) do
        count = count + 1
        if count > 4 then return false end
        if not expected[k] then return false end
        if type(v) ~= "number" then return false end
        found[k] = true
    end
    if count ~= 4 then return false end
    for k in pairs(expected) do if not found[k] then return false end end
    return true
end

-- Проверка на таблицу (InnateStatSecondary)
local function isInnateStatSecondaryTable(tbl)
    local count = 0
    local expected = { N1 = true, N2 = true, N3 = true, N4 = true, isLow = true, isReduced = true }
    local found = {}
    for k, v in pairs(tbl) do
        count = count + 1
        if count > 6 then return false end
        if not expected[k] then return false end
        if k == "isLow" or k == "isReduced" then
            if type(v) ~= "boolean" then return false end
        else
            if type(v) ~= "number" then return false end
        end
        found[k] = true
    end
    if count ~= 6 then return false end
    for k in pairs(expected) do if not found[k] then return false end end
    return true
end

-- Проверка на таблицу (LuaFullDateTime)
local function isLuaFullDateTimeTable(tbl)
    local count = 0
    local expected = { 
        y = true, m = true, d = true, h = true, min = true, s = true, ms = true, 
        wday = true, month = true, sysMonth = true, overallMs = true 
    }
    local found = {}
    for k, v in pairs(tbl) do
        count = count + 1
        if count > 11 then return false end
        if not expected[k] then return false end
        if k == "sysMonth" then
            if type(v) ~= "string" then return false end
        else
            if type(v) ~= "number" then return false end
        end
        found[k] = true
    end
    if count ~= 11 then return false end
    for k in pairs(expected) do if not found[k] then return false end end
    return true
end

-- Проверка на таблицу (LuaRaceClassInfoPart)
local function isLuaRaceClassInfoPartTable(tbl)
    local expected = {
        sysName = "string", name = "WString", description = "WString",
        sysClassName = "string", className = "WString",
        sysRaceName = "string", raceName = "WString"
    }
    local count = 0
    for k, v in pairs(tbl) do
        count = count + 1
        if count > 7 then return false end
        local exp_type = expected[k]
        if not exp_type then return false end
        local type = apitype(v)
        if type ~= "string" or type ~= "WString" then return false end
    end
    return count == 7
end

-- Проверка на таблицу (LuaSexInfoPart)
local function isLuaSexInfoPartTable(tbl)
    local count = 0
    local found = {}
    for k, v in pairs(tbl) do
        count = count + 1
        if count > 3 then return false end
        if k == "sex" then
            if type(v) ~= "number" then return false end
        elseif k == "name" or k == "raceSexName" then
            if apitype(v) ~= "WString" then return false end
        else
            return false
        end
        found[k] = true
    end
    if count ~= 3 then return false end
    return found.sex and found.name and found.raceSexName
end

-- Проверка на таблицу (MutationInfo)
local function isMutationInfoTable(tbl)
    local count = 0
    local found = {}
    for k, v in pairs(tbl) do
        count = count + 1
        if count > 3 then return false end
        if k == "difficulty" or k == "population" then
            if type(v) ~= "number" then return false end
        elseif k == "buffId" then
            if apitype(v) ~= "BuffId" then return false end
        else
            return false
        end
        found[k] = true
    end
    if count ~= 3 then return false end
    return found.difficulty and found.population and found.buffId
end

-- Чистка от всякого хлама
local escaped = function( value ) 
    return value:gsub("[\a\b\f\n\r\t\v\\\"]", {
        ["\a"] = "\\a", ["\b"] = "\\b", ["\f"] = "\\f",
        ["\n"] = "\\n", ["\r"] = "\\r", ["\t"] = "\\t",
        ["\v"] = "\\v", ["\\"] = "\\\\", ["\""] = "\\\""
    })
end

-- Маппинг функций для (ResourceId). ResourceId:GetInfo не интересен, либо выводит пустую таблицу {}.
local RESOURCE_INFO_MAP = {
    ["AbilityId"] = { name = "avatar.GetAbilityInfo", fn = function(v) return avatar.GetAbilityInfo(v) end },
    ["BuffId"] = { name = "object.GetBuffInfo", fn = function(v) return object.GetBuffInfo(v, false) end },
    ["ComponentPropertyId"] = { name = "avatar.GetComponentInfo", fn = function(v) return avatar.GetComponentInfo(v) end },
    ["ForgeCraftRecipeId"] = { name = "craft.GetForgeRecipeInfo", fn = function(v) return craft.GetForgeRecipeInfo(v) end },
    ["InterfaceMapMarkerId"] = { name = "cartographer.GetMarkerInfo", fn = function(v) return cartographer.GetMarkerInfo(v) end },
    ["ItemCategoryId"] = { name = "itemLib.GetCategoryInfo", fn = function(v) return itemLib.GetCategoryInfo(v) end },
    ["MapModifierId"] = { name = "cartographer.GetMapModifierInfo", fn = function(v) return cartographer.GetMapModifierInfo(v) end },
    ["SpellId"] = { name = "spellLib.GetActionGroups", fn = function(v) return spellLib.GetActionGroups(v) end },
    ["RecipeId"] = { name = "avatar.GetRecipeInfo", fn = function(v) return avatar.GetRecipeInfo(v) end },
    ["UnlockId"] = { name = "avatar.GetUnlockInfo", fn = function(v) return avatar.GetUnlockInfo(v) end },
    ["PostTypeId"] = { name = "bulletinBoard.ReadSection", fn = function(v) return bulletinBoard.ReadSection(v) end },
    ["SpecialStatId"] = { name = "common.GetSpecialStatInfo", fn = function(v) return common.GetSpecialStatInfo(v) end },
    ["TutorialCategoryId"] = { name = "tutorialLib.GetCategoryInfo", fn = function(v) return tutorialLib.GetCategoryInfo(v) end },
    ["TutorialId"] = { name = "tutorialLib.GetTutorialInfo", fn = function(v) return tutorialLib.GetTutorialInfo(v) end },
    ["VariableId"] = { name = "avatar.GetVariableInfo", fn = function(v) return avatar.GetVariableInfo(v) end },
    ["OrderBonusId"] = { name = "order.GetOrderBonusInfo", fn = function(v) return order.GetOrderBonusInfo(v) end },
}

--- Выводит содержимое переменной с типами и структурой.
--- @param value any Переменная для дампа
--- @param depth? integer Максимальная глубина рекурсии (по умолчанию 10)
--- @param indent? integer Текущий отступ, внутреннее
--- @param seen_tables? table Таблица для отслеживания циклических ссылок, внутреннее
--- @param userdata_ancestors? table ///
--- @return string
local function var_dump_internal( value, depth, indent, seen_tables, userdata_ancestors )
    depth = depth or 10
    indent = indent or 0
    seen_tables = seen_tables or {}
    userdata_ancestors = userdata_ancestors or {}
    
    local indent_mode = "    "
    local indent_str = string.rep( indent_mode, indent )
    local type_str = apitype( value )
    local native_type = type( value )
    
    local is_table = ( native_type == "table" )
    local is_userdata = ( native_type == "userdata" )

    -- проверка на циклические ссылки
    if is_table and seen_tables[ value ] then
        return indent_str .. string.format( "%s(0) = *RECURSION*", native_type )
    end
    if is_userdata and userdata_ancestors[ value ] then
        return indent_str .. string.format( "%s(%s) = *RECURSION*", native_type, type_str )
    end

    -- Посещенные
    if is_table then seen_tables[ value ] = true end
    if is_userdata then userdata_ancestors[ value ] = true end

    -- для очистки userdata из пути рекурсии
    local function finish( result )
        if is_userdata then
            userdata_ancestors[ value ] = nil
        end
        return result
    end
    
    -- nil. Если таблица { name = nil }, то вернёт пустую {}у
    if value == nil then
        return indent_str .. "nil"
    end
    
    --------------------------------------------------
    -- кроме table, остальные типы
    --------------------------------------------------
    if type_str ~= "table" then
        local prefix = indent_str .. type_str
        
        if type_str == "string" then
            return string.format( '%s(%d) "%s"', prefix, #value, escaped( value ) )
        elseif type_str == "WString" then
            local str = userMods.FromWString( value )
            return string.format( '%s(%d) "%s"', prefix, #str, escaped( str ) )
        elseif type_str == "number" then
            return string.format( "%s(%s)", prefix, tostring( value ) )
        elseif type_str == "boolean" then
            return string.format( "%s(%s)", prefix, value and "true" or "false" )
        elseif type_str == "function" then
            return string.format( "%s(%s)", prefix, tostring( value ) )
        elseif 
            type_str == "AbilityId" or -- avatar.GetAbilityInfo
            type_str == "ActionGroupId" or -- GetInfo
            type_str == "AliasVisObjectId" or -- Available only in internal (not UserAddon).
            
            
            
            
            type_str == "BattlegroundMarkId" or -- GetInfo
            type_str == "BillingBonusId" or
            type_str == "BuffId" or
            type_str == "CharacterClassId" or -- GetInfo
            type_str == "CharacterFormId" or -- GetInfo
            type_str == "CombatTagId" or -- GetInfo
            type_str == "ComponentPropertyId" or
            type_str == "CurrencyCategoryId" or -- GetInfo
            type_str == "CurrencyId" or -- GetInfo
            type_str == "DecalObjectId" or -- Available only in internal (not UserAddon).
            type_str == "ForgeCraftRecipeId" or -- craft.GetForgeRecipeInfo
            type_str == "ForgeCraftResourceId" or -- GetInfo
            type_str == "FactionId" or -- GetInfo
            type_str == "GlossaryId" or -- GetInfo
            type_str == "GoalId" or -- GetInfo
            type_str == "InstancedEventCategoryId" or -- GetInfo
            type_str == "InstancedEventResourceId" or -- GetInfo
            type_str == "InterfaceMapMarkerId" or
            type_str == "ItemCategoryId" or
            type_str == "ItemId" or -- GetInfo
            type_str == "ItemClassId" or -- GetInfo
            type_str == "LfgDestinationCategoryId" or -- GetInfo
            type_str == "LfgDestinationId" or -- GetInfo
            type_str == "LifestyleCategoryId" or -- GetInfo
            type_str == "LifestyleCollectionId" or -- GetInfo
            type_str == "LootGroupId" or -- GetInfo
            type_str == "MapModifierId" or -- 
            type_str == "MedalId" or -- GetInfo
            type_str == "MedalRankId" or -- GetInfo
            type_str == "MountTalentId" or -- GetInfo
            type_str == "OrderBonusId" or -- 
            type_str == "PostTypeId" or -- 
            type_str == "QuestId" or -- GetInfo
            type_str == "RecipeId" or -- GetInfo
            type_str == "ResourceId" or -- GetInfo
            type_str == "RuleId" or -- GetInfo
            type_str == "ShipSkinId" or -- GetInfo
            type_str == "SkillId" or -- GetInfo
            type_str == "Sound2DId" or -- 
            type_str == "SpecialStatId" or -- 
            type_str == "SpellId" or -- 
            type_str == "TeleportMasterId" or -- 
            type_str == "TextureId" or -- 
            type_str == "TimeTableId" or -- GetInfo
            type_str == "TutorialCategoryId" or -- 
            type_str == "TutorialId" or -- 
            type_str == "UITextureId" or -- Available only in internal (not UserAddon).
            type_str == "UnlockId" or
            type_str == "UnlockCategoryId" or -- GetInfo
            type_str == "VariableId" or -- GetInfo
            type_str == "VisActionId" or -- Available only in internal (not UserAddon).
            type_str == "VisObjectId" or -- Available only in internal (not UserAddon).
            type_str == "VisualShipId" or -- GetInfo
            type_str == "VoteId" or -- GetInfo
            type_str == "WishmasterResourceId" or -- GetInfo
            type_str == "ZodiacSignId"
        then -- Один из ResourceId
            local parts = { indent_str .. string.format("userdata(%s) = {", type_str) }
            local new_indent_str = string.rep(indent_mode, indent + 1)
            
            local info_getter = RESOURCE_INFO_MAP[type_str]
            if not __CONFIG_VAR_DUMP.RESOURCE_ID.GetOnlyInfo and info_getter then
                local raw_info = info_getter.fn( value )
                local dump = var_dump_internal(raw_info, depth - 1, indent + 1, seen_tables, userdata_ancestors):sub(#new_indent_str + 1)
                table.insert(parts, indent_str .. indent_mode .. info_getter.name .. " = " .. dump)
            else
                -- ResourceId:GetInfo(): table
                local info = value:GetInfo()
                if type(info) == "table" and next( info ) ~= nil then
                    local dump = var_dump_internal(info, depth - 1, indent + 1, seen_tables, userdata_ancestors):sub(#new_indent_str + 1)
                    table.insert(parts, indent_str .. indent_mode .. "GetInfo = " .. dump)
                end
            end
             
            -- ResourceId:GetInstanceId(): light userdata | nil
            --[[ local instanceId = value:GetInstanceId()
            if type(instanceId) ~= nil then
                local dump = var_dump_internal(instanceId, depth - 1, indent + 1, seen_tables, userdata_ancestors):sub(#new_indent_str + 1)
                table.insert(parts, indent_str .. indent_mode .. "GetInstanceId = " .. dump)
            end ]]
            
            table.insert(parts, (#parts > 1 and indent_str or "") .. "}")
            return finish( table.concat(parts, (#parts > 2 and "\n" or "")) )
        elseif type_str:sub(1, 7) == "Widget_" then
            -- Удаляет лишнее (Widget_FormSafe), получаем WidgetForm
            local display_type = type_str:gsub("_", ""):gsub("Safe$", "")
            local parts = { indent_str .. string.format("userdata(%s) = {", display_type) }
            local new_indent_str = string.rep(indent_mode, indent + 1)
            --------------------------------------------------
            -- WidgetSafe:GetDebugInfo
            local result = value:GetDebugInfo()
            table.insert(parts, indent_str .. indent_mode .. "GetDebugInfo = string(" .. #result .. ") \"" .. result .. "\"")
            --------------------------------------------------
            -- WidgetSafe:GetAddonType
            local result = value:GetAddonType()
            local typeVal = ENUM_ADDON_TYPE_MAP[result] or "unknown"
            local addonTypeStr = string.format("number(%s(%d))", typeVal, result)
            table.insert(parts, indent_str .. indent_mode .. "GetAddonType = " .. addonTypeStr)
            --------------------------------------------------
            -- WidgetSafe:GetId
            local result = value:GetId()
            table.insert(parts, indent_str .. indent_mode .. "GetId = number(" .. result .. ")" )
            --------------------------------------------------
            -- WidgetSafe:GetAddonName
            local result = value:GetAddonName()
            table.insert(parts, indent_str .. indent_mode .. "GetAddonName = string(" .. #result .. ") \"" .. result .. "\"")
            --------------------------------------------------
            -- WidgetSafe:GetName
            local result = value:GetName()
            table.insert(parts, indent_str .. indent_mode .. "GetName = string(" .. #result .. ") \"" .. result .. "\"")
            --------------------------------------------------
            -- WidgetSafe:GetPriority
            local result = value:GetPriority()
            table.insert(parts, indent_str .. indent_mode .. "GetPriority = number(" .. result .. ")" )
            --------------------------------------------------
            -- WidgetSafe:GetBackgroundColor
            local okColor, bgColor = pcall(value.GetBackgroundColor, value)
            if okColor and bgColor ~= nil then
                local dump = var_dump_internal(bgColor, depth - 1, indent + 1, seen_tables, userdata_ancestors):sub(#new_indent_str + 1)
                table.insert( parts, indent_str .. indent_mode .. "GetBackgroundColor = " .. dump )
            end
            --------------------------------------------------
            -- WidgetSafe:GetForegroundColor
            -- pcall - достаточно проще, чем создавать список разрешённых виджетов и чекать потом.
            -- GetForegroundColor - Can't get background color (Back layer not exist). Тоже самое с GetBackgroundColor
            local okFgColor, fgColor = pcall(value.GetForegroundColor, value)
            if okFgColor and fgColor ~= nil then
                local dump = var_dump_internal(fgColor, depth - 1, indent + 1, seen_tables, userdata_ancestors):sub(#new_indent_str + 1)
                table.insert( parts, indent_str .. indent_mode .. "GetForegroundColor = " .. dump )
            end
            --------------------------------------------------
            -- WidgetSafe:GetBackgroundTexture
            local hasBg = value:HasBackground()
            if hasBg then
                local bgTex = value:GetBackgroundTexture()
                local texInfo = bgTex and common.GetTextureInfo( bgTex )
                if texInfo then
                    local dump = var_dump_internal(texInfo, depth - 1, indent + 1, seen_tables, userdata_ancestors):sub(#new_indent_str + 1)
                    table.insert( parts, indent_str .. indent_mode .. "GetBackgroundTexture = " .. dump )
                else
                    table.insert(parts, indent_str .. indent_mode .. "GetBackgroundTexture = \"No texture\"")
                end
            end
            --------------------------------------------------
            -- WidgetSafe:GetForegroundTexture
            local hasFg = value:HasForeground()
            if hasFg then
                local fgTex = value:GetForegroundTexture()
                local texInfo = fgTex and common.GetTextureInfo( fgTex )
                if texInfo then
                    local dump = var_dump_internal(texInfo, depth - 1, indent + 1, seen_tables, userdata_ancestors):sub(#new_indent_str + 1)
                    table.insert( parts, indent_str .. indent_mode .. "GetForegroundTexture = " .. dump )
                else
                    table.insert(parts, indent_str .. indent_mode .. "GetForegroundTexture = \"No texture\"")
                end
            end
            --------------------------------------------------
            -- WidgetSafe:GetNamedChildren (только имена, ибо уйдет в цикличность)
            local result = value:GetNamedChildren()
            if next( result ) ~= nil then
                local child_parts = { indent_str .. indent_mode .. "GetNamedChildren = table(" .. #result .. ") {" }
                for i, child in ipairs(result) do
                    if __CONFIG_VAR_DUMP.WIDGET.GetNamedChildrenRecursive then
                        local dump = var_dump_internal(child, depth - 1, indent + 1, seen_tables, userdata_ancestors):sub(#new_indent_str + 1)
                        table.insert(child_parts, string.format("%s[%d] => %s", new_indent_str, i, dump))
                    else
                        local child_display_type = apitype(child):gsub("_", ""):gsub("Safe$", "")
                        local name_str = child:GetName()
                        table.insert(child_parts, string.format("%s[%d] => userdata(%s) = { GetName = string(%s) \"%s\" }", new_indent_str, i, child_display_type, #name_str, name_str))
                    end
                end
                table.insert(child_parts, indent_str .. indent_mode .. "}")
                table.insert(parts, table.concat(child_parts, "\n"))
            end
            --------------------------------------------------
            -- WidgetSafe:GetParent (только имя, ибо уйдет в цикличность)
            local result = value:GetParent()
            if result ~= nil then
                local parent_display_type = apitype(result):gsub("_", ""):gsub("Safe$", "")
                local name_str = "\"" .. result:GetName() .. "\""
                table.insert(parts, string.format("%sGetParent = userdata(%s) = { GetName = %s }", indent_str .. indent_mode, parent_display_type, name_str))
            end
            --------------------------------------------------
            -- WidgetSafe:IsEnabledEx
            local result = value:IsEnabledEx()
            table.insert( parts, indent_str .. indent_mode .. "IsEnabledEx = boolean(" .. tostring( result ) .. ")" )
            --------------------------------------------------
            -- WidgetSafe:IsVisibleEx
            local result = value:IsVisibleEx()
            table.insert( parts, indent_str .. indent_mode .. "IsVisibleEx = boolean(" .. tostring( result ) .. ")" )
            --------------------------------------------------
            -- WidgetSafe:GetTransparentInput
            local result = value:GetTransparentInput()
            table.insert( parts, indent_str .. indent_mode .. "GetTransparentInput = boolean(" .. tostring( result ) .. ")" )
            --------------------------------------------------
            -- WidgetSafe:GetPickChildrenOnly
            local result = value:GetPickChildrenOnly()
            table.insert( parts, indent_str .. indent_mode .. "GetPickChildrenOnly = boolean(" .. tostring( result ) .. ")" )
            --------------------------------------------------
            -- WidgetSafe:GetFade
            local result = value:GetFade()
            table.insert(parts, indent_str .. indent_mode .. "GetFade = number(" .. result .. ")")
            --------------------------------------------------
            -- WidgetSafe:GetTabOrder
            local result = value:GetTabOrder()
            table.insert(parts, indent_str .. indent_mode .. "GetTabOrder = number(" .. result .. ")")
            --------------------------------------------------
            -- WidgetSafe:GetPlacementPlain
            if __CONFIG_VAR_DUMP.WIDGET.GetPlacementPlain then
                local result = value:GetPlacementPlain()
                local dump = var_dump_internal(result, depth - 1, indent + 1, seen_tables, userdata_ancestors):sub(#new_indent_str + 1)
                table.insert(parts, indent_str .. indent_mode .. "GetPlacementPlain = " .. dump)
            end
            --------------------------------------------------
            -- WidgetSafe:GetSmartPlacementPlain
            if __CONFIG_VAR_DUMP.WIDGET.GetSmartPlacementPlain then
                local result = value:GetSmartPlacementPlain()
                local dump = var_dump_internal(result, depth - 1, indent + 1, seen_tables, userdata_ancestors):sub(#new_indent_str + 1)
                table.insert(parts, indent_str .. indent_mode .. "GetSmartPlacementPlain = " .. dump)
            end
            --------------------------------------------------
            -- WidgetSafe:GetRealRect
            if __CONFIG_VAR_DUMP.WIDGET.GetRealRect then
                local result = value:GetRealRect()
                local dump = var_dump_internal(result, depth - 1, indent + 1, seen_tables, userdata_ancestors):sub(#new_indent_str + 1)
                table.insert(parts, indent_str .. indent_mode .. "GetRealRect = " .. dump)
            end
            --------------------------------------------------
            table.insert(parts, indent_str .. "}")
            return finish( table.concat(parts, "\n") )
        elseif type_str == "ValuedObjectLua" then -- Изменен с ValuedObject
            local parts = { indent_str .. "userdata(ValuedObjectLua) = {" }
            local new_indent_str = string.rep(indent_mode, indent + 1)
            --------------------------------------------------
            -- ValuedObjectLua:GetType
            local objType = value:GetType()
            local typeVal = ENUM_VAL_OBJ_TYPE_MAP[objType] or "unknown"
            local objTypeStr = string.format("number(%s(%d))", typeVal, objType)
            table.insert(parts, indent_str .. indent_mode .. "GetType = " .. objTypeStr)
            --------------------------------------------------
            -- ValuedObjectLua:GetId
            local objId = value:GetId()
            local dump = var_dump_internal(objId, depth - 1, indent + 1, seen_tables, userdata_ancestors):sub(#new_indent_str + 1)
            table.insert(parts, indent_str .. indent_mode .. "GetId = " .. dump)
            --------------------------------------------------
            -- ValuedObjectLua:GetImage
            local objImage = value:GetImage()
            --[[ if objImage ~= nil and objImage ~= value then ]]
            local dump = var_dump_internal(objImage, depth - 1, indent + 1, seen_tables, userdata_ancestors):sub(#new_indent_str + 1)
            table.insert(parts, indent_str .. indent_mode .. "GetImage = " .. dump)
            --------------------------------------------------
            -- ValuedObjectLua:GetShardName
            -- Метод доступен только у ValuedObjectPlayer.
            -- Иначе выбрасывает исключение: <UI::LuaValuedObjectGetShardName: ValuedObject is not ValuedObjectPlayer>
            if objType == VAL_OBJ_TYPE_PLAYER then
                local shardName = value:GetShardName()
                local dump = var_dump_internal(shardName, depth - 1, indent + 1, seen_tables, userdata_ancestors):sub(#new_indent_str + 1)
                table.insert(parts, indent_str .. indent_mode .. "GetShardName = " .. dump)
            end
            --------------------------------------------------
            -- ValuedObjectLua:GetText
            local objText = value:GetText()
            local dump = var_dump_internal(objText, depth - 1, indent + 1, seen_tables, userdata_ancestors):sub(#new_indent_str + 1)
            table.insert(parts, indent_str .. indent_mode .. "GetText = " .. dump)
            --------------------------------------------------
            table.insert(parts, indent_str .. "}")
            return finish( table.concat(parts, "\n") )
        elseif type_str == "ValuedText" then
            local parts = { indent_str .. "userdata(ValuedText) = {" }
            --------------------------------------------------
            local str = userMods.FromWString(value:ToWString())
            table.insert(parts, string.format('%sToWString = WString(%d) "%s"', indent_str .. indent_mode, #str, escaped( str )))
            --------------------------------------------------
            table.insert(parts, indent_str .. "}")
            return finish( table.concat(parts, "\n") )
        elseif 
            type_str == "RelatedSoundsLua" or 
            type_str == "RelatedTextsLua" or 
            type_str == "RelatedTexturesLua" or 
            type_str == "RelatedWidgetsLua" 
        then
            local parts = { indent_str .. string.format("userdata(%s) = {", type_str) }
            local new_indent_str = string.rep(indent_mode, indent + 1)
            --------------------------------------------------
            -- RelatedSafe:GetList
            local list = value:GetList()
            local dump = var_dump_internal(list, depth - 1, indent + 1, seen_tables, userdata_ancestors):sub(#new_indent_str + 1)
            table.insert(parts, indent_str .. indent_mode .. "GetList = " .. dump)
            --------------------------------------------------
            table.insert(parts, indent_str .. "}")
            return finish( table.concat(parts, "\n") )
        elseif type_str == "userdata" then
            return string.format("%s(%s)", prefix, tostring( value ))
        elseif type_str == "thread" then
            return prefix .. "(coroutine)"
        end
        
        return prefix
    end
    
    
    
    
    --------------------------------------------------
    -- РАБОТА С ТАБЛИЦЕЙ далее.
    --------------------------------------------------
    -- Когда доходит до предела итерация
    if depth <= 0 then
        return indent_str .. "table(...)"
    end
    
    --------------------------------------------------
    -- Определение заголовка таблицы table(Color, GamePosition, ...)
    local table_header
    local is_widget_placement = false
    local is_full_date_time = false
    local is_lua_sex_info_part = false
    local is_mutation_info = false
    
    if isColorTable( value ) then
        table_header = "table(Color) {"
    elseif isGamePositionTable( value ) then
        table_header = "table(GamePosition) {"
    elseif isWidgetPlacementTable( value ) then
        table_header = "table(WidgetPlacementLua) {"
        is_widget_placement = true
    elseif isGeodataTable( value ) then
        table_header = "table(Geodata) {"
    elseif isInnateStatSecondaryTable( value ) then
        table_header = "table(InnateStatSecondary) {"
    elseif isLuaFullDateTimeTable( value ) then
        table_header = "table(LuaFullDateTime) {"
        is_full_date_time = true
    elseif isLuaRaceClassInfoPartTable( value ) then
        table_header = "table(LuaRaceClassInfoPart) {"
    elseif isLuaSexInfoPartTable( value ) then
        table_header = "table(LuaSexInfoPart) {"
        is_lua_sex_info_part = true
    elseif isMutationInfoTable( value ) then
        table_header = "table(MutationInfo) {"
        is_mutation_info = true
    elseif ENABLE_TWIDGET and IsTWidget( value ) then -- Вывод особой таблицы TWidget
        local raw_widget = value:GetRaw()
        local dump = var_dump_internal(raw_widget, depth - 1, indent, seen_tables, userdata_ancestors):gsub( "userdata%(", "TWidget(", 1 )
        return dump
    else
        table_header = string.format("table(%d) {", countEntries( value ))
    end
    --------------------------------------------------

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
    
    -- Сортировка ключей: числа, строки, остальные
    table.sort(keys, function(a, b)
        local ta, tb = type(a), type(b)
        if ta == "number" and tb == "number" then return a < b end
        if ta == "number" then return true end
        if tb == "number" then return false end
        if ta == "string" and tb == "string" then return a < b end
        return ta < tb
    end)
    
    -- Прочёс по каждому элементу
    for _, k in ipairs(keys) do
        local v = value[k]
        local key_str
        if type(k) == "string" and k:match("^[%a_][%w_]*$") then
            key_str = string.format('["%s"]', k)
        else
            key_str = string.format("[%s]", tostring(k))
        end

        local dump
        --------------------------------------------------
        if v == nil then
            dump = "nil"
        elseif is_widget_placement and type(v) == "number" and type(k) == "string" then
            -- Если таблица WidgetPlacementLua
            if k == "alignX" or k == "alignY" then
                local constName = WIDGET_ALIGN_MAP[v] or "unknown"
                dump = string.format("number(%s(%d))", constName, v)
            elseif k == "sizingX" or k == "sizingY" then
                local constName = WIDGET_SIZING_MAP[v] or "unknown"
                dump = string.format("number(%s(%d))", constName, v)
            end
        elseif is_full_date_time and type(v) == "number" and type(k) == "string" then
            -- Если таблица LuaFullDateTime
            if k == "wday" then
                local constName = ENUM_DAY_OF_WEEK_MAP[v] or "unknown"
                dump = string.format("number(%s(%d))", constName, v)
            elseif k == "month" then
                local constName = ENUM_MONTH_MAP[v] or "unknown"
                dump = string.format("number(%s(%d))", constName, v)
            end
        elseif is_lua_sex_info_part and type(v) == "number" and k == "sex" then
            -- Если таблица LuaSexInfoPart
            local constName = ENUM_SEX_MAP[v] or "unknown"
            dump = string.format("number(%s(%d))", constName, v)
        elseif is_mutation_info and type(v) == "number" and k == "difficulty" then
            -- Если таблица MutationInfo
            local constName = ENUM_ZONE_TIER_DIFFICULTY_MAP[v] or "unknown"
            dump = string.format("number(%s(%d))", constName, v)
        end
        --------------------------------------------------
        if not dump then
            dump = var_dump_internal(v, new_depth, new_indent, seen_tables, userdata_ancestors):sub(#new_indent_str + 1)
        end

        table.insert(parts, string.format("%s => %s", new_indent_str .. key_str, dump))
    end
    
    table.insert( parts, indent_str .. "}" )
    return finish( table.concat( parts, "\n" ) )
end

-- Public функция
function var_dump( ... )
    local results = {}
    local n = select( '#', ... )
    local seen_tables = {}
    local userdata_ancestors = {}
    
    for i = 1, n do
        local result = var_dump_internal( select( i, ... ), 10, 0, seen_tables, userdata_ancestors )
        table.insert( results, result )
    end
    
    local info = "<<< Debug info var_dump >>>\n" .. 
        "======================BEGIN======================\n" .. 
        table.concat( results, "\n----------------------\n" ) .. "\n" .. 
        "=======================END=======================\n"
    
    common.LogInfo( "common", info ) -- Ограничение 64000 символов.
end