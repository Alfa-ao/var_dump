-- Включение и настройка опций для участия дамба
local __CONFIG_VAR_DUMP = type( rawget( _G, "__CONFIG_VAR_DUMP" ) ) == "table" and __CONFIG_VAR_DUMP or {
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

-- Если появился тип TWidget
local ENABLE_TWIDGET = type( rawget( _G, "IsTWidget" ) ) == "function"

--------------------------------------------------------------------------------
-- Маппинг констант вместо значений.
--------------------------------------------------------------------------------

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

-- Маппинг констант (дней)
local ENUM_DAY_OF_WEEK_MAP = {
    [ENUM_Monday] = "ENUM_Monday",
    [ENUM_Tuesday] = "ENUM_Tuesday",
    [ENUM_Wednesday] = "ENUM_Wednesday",
    [ENUM_Thursday] = "ENUM_Thursday",
    [ENUM_Friday] = "ENUM_Friday",
    [ENUM_Saturday] = "ENUM_Saturday",
    [ENUM_Sunday] = "ENUM_Sunday",
}

-- Маппинг констант (месяцев)
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

-- Маппинг констант для (TextureInfo)
local TEXTURE_TYPE_MAP = {
    [0] = "DXT1",
    [1] = "DXT3",
    [2] = "DXT5",
}

--------------------------------------------------------------------------------

-- Подсчет элементов в таблице не/индексируемой.
local function countEntries( tbl )
    local count = 0
    for _ in pairs( tbl ) do
        count = count + 1
    end
    return count
end

--- Для создания функций валидации структуры таблицы.
--- @param schema table Хеш-таблица { [ имя поля ] = { допустимые типы } }.
--- @return function
local function createTableValidator( schema )
    local expected_count = countEntries( schema )

    return function( tbl )
        if not __CONFIG_VAR_DUMP.TABLE.tableIdentification or type( tbl ) ~= "table" then
            return false
        end

        local count = 0
        local found = {}

        for k, v in pairs( tbl ) do
            count = count + 1
            
            -- Выход, если элементов больше
            if count > expected_count then
                return false
            end

            local validator = schema[k]
            -- Если ключ не описан в схеме
            if not validator then
                return false
            end

            local is_valid = false
            
            if type( validator ) == "function" then -- кастомные функции-валидаторы
                is_valid = validator( v )
            elseif type( validator ) == "table" then -- проверка по списку допустимых типов
                for _, t in ipairs( validator ) do
                    if apitype( v ) == t then
                        is_valid = true
                        break
                    end
                end
            end

            if not is_valid then
                return false
            end

            found[k] = true
        end

        -- Если кол-во ключей не совпадает
        if count ~= expected_count then
            return false
        end

        -- Все ли ключи присутствуют
        for k in pairs( schema ) do
            if not found[k] then
                return false
            end
        end

        return true
    end
end

--------------------------------------------------------------------------------
-- Переопределение функций проверки на статическую таблицу
--------------------------------------------------------------------------------

-- Проверка на таблицу (Color)
local isColorTable = createTableValidator {
    r = function( v ) return type( v ) == "number" and v >= 0 and v <= 1 end,
    g = function( v ) return type( v ) == "number" and v >= 0 and v <= 1 end,
    b = function( v ) return type( v ) == "number" and v >= 0 and v <= 1 end,
    a = function( v ) return type( v ) == "number" and v >= 0 and v <= 1 end,
}

-- Проверка на таблицу (GamePosition)
local isGamePositionTable = createTableValidator {
    posX = { "number" },
    posY = { "number" },
    posZ = { "number" },
}

-- Проверка на таблицу (WidgetPlacementLua)
local isWidgetPlacementTable = createTableValidator {
    alignX = { "number" }, alignY = { "number" },
    highPosX = { "number" }, highPosY = { "number" },
    posX = { "number" }, posY = { "number" },
    sizeX = { "number" }, sizeY = { "number" },
    sizingX = { "number" }, sizingY = { "number" },
}

-- Проверка на таблицу (Geodata)
local isGeodataTable = createTableValidator {
    x = { "number" }, y = { "number" },
    width = { "number" }, height = { "number" },
}

-- Проверка на таблицу (InnateStatSecondary)
local isInnateStatSecondaryTable = createTableValidator {
    N1 = { "number" }, N2 = { "number" }, N3 = { "number" }, N4 = { "number" },
    isLow = { "boolean" }, isReduced = { "boolean" },
}

-- Проверка на таблицу (LuaFullDateTime)
local isLuaFullDateTimeTable = createTableValidator {
    y = { "number" }, m = { "number" }, d = { "number" },
    h = { "number" }, min = { "number" }, s = { "number" }, ms = { "number" },
    wday = { "number" }, month = { "number" },
    sysMonth = { "string" }, overallMs = { "number" },
}

-- Проверка на таблицу (LuaRaceClassInfoPart)
local isLuaRaceClassInfoPartTable = createTableValidator {
    sysName = { "string" },  name = { "WString" }, description = { "WString" },
    sysClassName = { "string" }, className = { "WString" },
    sysRaceName = { "string" }, raceName = { "WString" },
}

-- Проверка на таблицу (LuaSexInfoPart)
local isLuaSexInfoPartTable = createTableValidator {
    sex = { "number" },
    name = { "WString" },
    raceSexName = { "WString" },
}

-- Проверка на таблицу (MutationInfo)
local isMutationInfoTable = createTableValidator {
    difficulty = { "number" },
    population = { "number" },
    buffId = { "BuffId" },
}

-- Проверка на таблицу (TextureInfo)
local isTextureInfoTable = createTableValidator {
    binaryFile = { "string" },
    realHeight = { "number" },
    realWidth = { "number" },
    type = { "number" },
    xdbFile = { "string" },
}

--------------------------------------------------------------------------------

-- Чистка от всякого хлама
local escaped = function( value ) 
    return value:gsub( "[\a\b\f\n\r\t\v\\\"]", {
        ["\a"] = "\\a", ["\b"] = "\\b", ["\f"] = "\\f",
        ["\n"] = "\\n", ["\r"] = "\\r", ["\t"] = "\\t",
        ["\v"] = "\\v", ["\\"] = "\\\\", ["\""] = "\\\""
    } )
end

-- Маппинг функций для (ResourceId). ResourceId:GetInfo не интересен, либо выводит пустую {}у.
local RESOURCE_INFO_MAP = {
    ["AbilityId"] = { name = "avatar.GetAbilityInfo", fn = function( v ) return avatar.GetAbilityInfo( v ) end },
    ["BuffId"] = { name = "object.GetBuffInfo", fn = function( v ) return object.GetBuffInfo(v, false) end },
    ["ComponentPropertyId"] = { name = "avatar.GetComponentInfo", fn = function( v ) return avatar.GetComponentInfo( v ) end },
    ["ForgeCraftRecipeId"] = { name = "craft.GetForgeRecipeInfo", fn = function( v ) return craft.GetForgeRecipeInfo( v ) end },
    ["InterfaceMapMarkerId"] = { name = "cartographer.GetMarkerInfo", fn = function( v ) return cartographer.GetMarkerInfo( v ) end },
    ["ItemCategoryId"] = { name = "itemLib.GetCategoryInfo", fn = function( v ) return itemLib.GetCategoryInfo( v ) end },
    ["MapModifierId"] = { name = "cartographer.GetMapModifierInfo", fn = function( v ) return cartographer.GetMapModifierInfo( v ) end },
    ["SpellId"] = { name = "spellLib.GetActionGroups", fn = function( v ) return spellLib.GetActionGroups( v ) end },
    ["RecipeId"] = { name = "avatar.GetRecipeInfo", fn = function( v ) return avatar.GetRecipeInfo( v ) end },
    ["UnlockId"] = { name = "avatar.GetUnlockInfo", fn = function( v ) return avatar.GetUnlockInfo( v ) end },
    ["PostTypeId"] = { name = "bulletinBoard.ReadSection", fn = function( v ) return bulletinBoard.ReadSection( v ) end },
    ["SpecialStatId"] = { name = "common.GetSpecialStatInfo", fn = function( v ) return common.GetSpecialStatInfo( v ) end },
    ["TutorialCategoryId"] = { name = "tutorialLib.GetCategoryInfo", fn = function( v ) return tutorialLib.GetCategoryInfo( v ) end },
    ["TutorialId"] = { name = "tutorialLib.GetTutorialInfo", fn = function( v ) return tutorialLib.GetTutorialInfo( v ) end },
    ["VariableId"] = { name = "avatar.GetVariableInfo", fn = function( v ) return avatar.GetVariableInfo( v ) end },
    ["OrderBonusId"] = { name = "order.GetOrderBonusInfo", fn = function( v ) return order.GetOrderBonusInfo( v ) end },
}

--- Выводит содержимое переменной с типами и структурой.
--- @param value any Переменная для дампа
--- @param depth? integer Максимальная глубина рекурсии (по умолчанию 10)
--- @param indent? integer Текущий отступ, внутреннее
--- @param seen_tables? table Таблица для отслеживания циклических ссылок, внутреннее
--- @param userdata_ancestors? table ///
--- @return string
local function var_dump_internal( value, depth, indent, seen_tables, userdata_ancestors )
    depth = depth or __CONFIG_VAR_DUMP.DEBUG.depth
    indent = indent or 0
    seen_tables = seen_tables or {}
    userdata_ancestors = userdata_ancestors or {}
    
    local indent_mode = "    "
    local indent_str = string.rep( indent_mode, indent )
    local type_str = apitype( value )
    local native_type = type( value )
    
    local is_table = ( native_type == "table" )
    local is_userdata = ( native_type == "userdata" and type_str ~= "WString" )
    local is_light_userdata = ( native_type == "userdata" and type_str == "userdata" )
    
    -- проверка на циклические ссылки
    if is_table and seen_tables[ value ] then
        return indent_str .. string.format( "%s(0) = *RECURSION*", native_type )
    end
    if is_userdata and not is_light_userdata and userdata_ancestors[ value ] then
        return indent_str .. string.format( "%s(%s) = *RECURSION*", native_type, type_str )
    end

    -- Посещенные
    if is_table then seen_tables[ value ] = true end
    if is_userdata and not is_light_userdata then userdata_ancestors[ value ] = true end

    -- для очистки userdata из пути рекурсии
    local function finish( result )
        if is_userdata and not is_light_userdata then
            userdata_ancestors[ value ] = nil
        end
        return result
    end
    
    -- nil. Если таблица { name = nil }, то вернёт пустую {}у
    if value == nil then
        return indent_str .. "nil"
    end
    
    --------------------------------------------------------------------------------
    -- string, number, boolean, function, light userdata, userdata( apitype ), thread
    --------------------------------------------------------------------------------
    if native_type ~= "table" then
        local prefix = indent_str .. type_str
        
        if native_type == "string" then
            return string.format( '%s(%d) "%s"', prefix, #value, escaped( value ) )
        elseif native_type == "number" then
            return string.format( "%s(%s)", prefix, tostring( value ) )
        elseif native_type == "boolean" then
            return string.format( "%s(%s)", prefix, value and "true" or "false" )
        elseif native_type == "function" then
            return string.format( "%s(%s)", prefix, tostring( value ) )
        elseif native_type == "userdata" then
            local new_indent_str = string.rep( indent_mode, indent + 1 )
            local address = ""
            
            if __CONFIG_VAR_DUMP.USERDATA.hexadecimal or is_light_userdata then
                address = "#0x" .. tostring( value ):match( "0x(%x+)" )
            end
            --------------------------------------------------------------------------------
            -- light userdata
            if is_light_userdata then
                return indent_str .. string.format( "light userdata(%s)", address )
            end
            --------------------------------------------------------------------------------
            if type_str == "WString" then
                local str = userMods.FromWString( value )
                return string.format( '%s(%d) "%s"', prefix, #str, escaped( str ) )
            elseif type_str == "FactoryCacheSafe" then
                local parts = { indent_str .. string.format( "userdata(%s)%s = {", type_str, address ) }
                --------------------------------------------------------------------------------
                -- FactoryCacheSafe:IsValid
                table.insert( parts, new_indent_str .. "IsValid = boolean(" .. tostring( value:IsValid() ) .. ")" )
                --------------------------------------------------------------------------------
                -- FactoryCacheSafe:GetId
                table.insert( parts, new_indent_str .. "GetId = number(" .. tostring( value:GetId() ) .. ")" )
                --------------------------------------------------------------------------------
                -- FactoryCacheSafe:GetDebugInfo
                local debugInfo = value:GetDebugInfo()
                table.insert( parts, new_indent_str .. "GetDebugInfo = string(" .. #debugInfo .. ") \"" .. escaped( debugInfo ) .. "\"" )
                --------------------------------------------------------------------------------
                table.insert( parts, indent_str .. "}" )
                return finish( table.concat( parts, "\n" ) )
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
                type_str == "TextureId" or -- common.GetTextureInfo
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
                local parts = { indent_str .. string.format( "userdata(%s)%s = {", type_str, address ) }
                
                local info_getter = RESOURCE_INFO_MAP[ type_str ]
                if not __CONFIG_VAR_DUMP.RESOURCE_ID.GetOnlyInfo and info_getter then
                    local dump = var_dump_internal( info_getter.fn( value ), depth - 1, indent + 1, seen_tables, userdata_ancestors ):sub( #new_indent_str + 1 )
                    table.insert( parts, new_indent_str .. info_getter.name .. " = " .. dump )
                else
                    -- ResourceId:GetInfo(): table
                    local info = value:GetInfo()
                    if type( info ) == "table" and next( info ) ~= nil then
                        local dump = var_dump_internal( info, depth - 1, indent + 1, seen_tables, userdata_ancestors ):sub( #new_indent_str + 1 )
                        table.insert( parts, new_indent_str .. "GetInfo = " .. dump )
                    end
                end
                
                table.insert( parts, ( #parts > 1 and indent_str or "" ) .. "}" )
                return finish( table.concat( parts, ( #parts > 2 and "\n" or "" ) ) )
            elseif type_str:sub( 1, 7 ) == "Widget_" then
                -- Удаляет лишнее (Widget_FormSafe), получаем WidgetForm
                local display_type = type_str:gsub( "_", "" ):gsub( "Safe$", "" )
                local parts = { indent_str .. string.format( "userdata(%s)%s = {", display_type, address ) }
                --------------------------------------------------------------------------------
                -- WidgetSafe:GetDebugInfo
                local GetDebugInfo = value:GetDebugInfo()
                table.insert( parts, new_indent_str .. "GetDebugInfo = string(" .. #GetDebugInfo .. ") \"" .. GetDebugInfo .. "\"" )
                --------------------------------------------------------------------------------
                -- WidgetSafe:GetAddonType
                local GetAddonType = value:GetAddonType()
                local addonTypeStr = string.format( "number(%s(%d))", ENUM_ADDON_TYPE_MAP[ GetAddonType ] or "unknown", GetAddonType )
                table.insert( parts, new_indent_str .. "GetAddonType = " .. addonTypeStr )
                --------------------------------------------------------------------------------
                -- WidgetSafe:GetId
                table.insert( parts, new_indent_str .. "GetId = number(" .. value:GetId() .. ")" )
                --------------------------------------------------------------------------------
                -- WidgetSafe:GetAddonName
                local GetAddonName = value:GetAddonName()
                table.insert( parts, new_indent_str .. "GetAddonName = string(" .. #GetAddonName .. ") \"" .. GetAddonName .. "\"" )
                --------------------------------------------------------------------------------
                -- WidgetSafe:GetName
                local GetName = value:GetName()
                table.insert( parts, new_indent_str .. "GetName = string(" .. #GetName .. ") \"" .. GetName .. "\"" )
                --------------------------------------------------------------------------------
                -- WidgetSafe:GetPriority
                table.insert( parts, new_indent_str .. "GetPriority = number(" .. value:GetPriority() .. ")" )
                --------------------------------------------------------------------------------
                -- WidgetSafe:GetBackgroundColor
                local okColor, bgColor = pcall( value.GetBackgroundColor )
                if okColor and bgColor ~= nil then
                    local dump = var_dump_internal( bgColor, depth - 1, indent + 1, seen_tables, userdata_ancestors ):sub( #new_indent_str + 1 )
                    table.insert( parts, new_indent_str .. "GetBackgroundColor = " .. dump )
                end
                --------------------------------------------------------------------------------
                -- WidgetSafe:GetForegroundColor
                -- pcall - достаточно проще, чем создавать список разрешённых виджетов и чекать потом.
                -- GetForegroundColor - Can't get background color (Back layer not exist). Тоже самое с GetBackgroundColor
                local okFgColor, fgColor = pcall( value.GetForegroundColor )
                if okFgColor and fgColor ~= nil then
                    local dump = var_dump_internal( fgColor, depth - 1, indent + 1, seen_tables, userdata_ancestors ):sub( #new_indent_str + 1 )
                    table.insert( parts, new_indent_str .. "GetForegroundColor = " .. dump )
                end
                --------------------------------------------------------------------------------
                -- WidgetSafe:GetBackgroundTexture
                local hasBg = value:HasBackground()
                if hasBg then
                    local bgTex = value:GetBackgroundTexture()
                    local texInfo = bgTex and common.GetTextureInfo( bgTex )
                    if texInfo then
                        local dump = var_dump_internal( texInfo, depth - 1, indent + 1, seen_tables, userdata_ancestors ):sub( #new_indent_str + 1 )
                        table.insert( parts, new_indent_str .. "GetBackgroundTexture = " .. dump )
                    else
                        table.insert( parts, new_indent_str .. "GetBackgroundTexture = \"No texture\"")
                    end
                end
                --------------------------------------------------------------------------------
                -- WidgetSafe:GetForegroundTexture
                local hasFg = value:HasForeground()
                if hasFg then
                    local fgTex = value:GetForegroundTexture()
                    local texInfo = fgTex and common.GetTextureInfo( fgTex )
                    if texInfo then
                        local dump = var_dump_internal( texInfo, depth - 1, indent + 1, seen_tables, userdata_ancestors ):sub( #new_indent_str + 1 )
                        table.insert( parts, new_indent_str .. "GetForegroundTexture = " .. dump )
                    else
                        table.insert( parts, new_indent_str .. "GetForegroundTexture = \"No texture\"")
                    end
                end
                --------------------------------------------------------------------------------
                -- WidgetSafe:GetNamedChildren (только имена, ибо уйдет в цикличность)
                local GetNamedChildren = value:GetNamedChildren()
                if next( GetNamedChildren ) ~= nil then
                    local child_indent_str = new_indent_str .. indent_mode
                    local child_parts = { new_indent_str .. "GetNamedChildren = table(" .. #GetNamedChildren .. ") {" }
                    for i, child in ipairs( GetNamedChildren ) do
                        if __CONFIG_VAR_DUMP.WIDGET.GetNamedChildren then
                            local dump = var_dump_internal( child, depth - 1, indent + 2, seen_tables, userdata_ancestors ):sub( #child_indent_str + 1 )
                            table.insert( child_parts, string.format( "%s[%d] => %s", child_indent_str, i, dump ) )
                        else
                            local child_display_type = apitype( child ):gsub( "_", "" ):gsub( "Safe$", "" )
                            local name_str = child:GetName()
                            table.insert( child_parts, string.format( 
                                "%s[%d] => userdata(%s)%s = { GetName = string(%s) \"%s\" }", 
                                child_indent_str, i, child_display_type, address, #name_str, name_str
                            ) )
                        end
                    end
                    table.insert( child_parts, new_indent_str .. "}" )
                    table.insert( parts, table.concat( child_parts, "\n" ) )
                end
                --------------------------------------------------------------------------------
                -- WidgetSafe:GetParent (только имя, ибо уйдет в цикличность)
                local GetParent = value:GetParent()
                if GetParent ~= nil then
                    local parent_display_type = apitype( GetParent ):gsub( "_", "" ):gsub( "Safe$", "" )
                    local name_str = "\"" .. GetParent:GetName() .. "\""
                    table.insert( parts, string.format(
                        "%sGetParent = userdata(%s)%s = { GetName = %s }", 
                        new_indent_str, parent_display_type, address, name_str
                    ) )
                end
                --------------------------------------------------------------------------------
                -- WidgetSafe:IsEnabled
                if __CONFIG_VAR_DUMP.WIDGET.IsEnabled then
                    local result = value:IsEnabled()
                    table.insert( parts, new_indent_str .. "IsEnabled = boolean(" .. tostring( result ) .. ")" )
                end
                --------------------------------------------------------------------------------
                -- WidgetSafe:IsEnabledEx
                if __CONFIG_VAR_DUMP.WIDGET.IsEnabledEx then
                    table.insert( parts, new_indent_str .. "IsEnabledEx = boolean(" .. tostring( value:IsEnabledEx() ) .. ")" )
                end
                --------------------------------------------------------------------------------
                -- WidgetSafe:IsVisible
                if __CONFIG_VAR_DUMP.WIDGET.IsVisible then
                    table.insert( parts, new_indent_str .. "IsVisible = boolean(" .. tostring( value:IsVisible() ) .. ")" )
                end
                --------------------------------------------------------------------------------
                -- WidgetSafe:IsVisibleEx
                if __CONFIG_VAR_DUMP.WIDGET.IsVisibleEx then
                    table.insert( parts, new_indent_str .. "IsVisibleEx = boolean(" .. tostring( value:IsVisibleEx() ) .. ")" )
                end
                --------------------------------------------------------------------------------
                -- WidgetSafe:GetTransparentInput
                table.insert( parts, new_indent_str .. "GetTransparentInput = boolean(" .. tostring( value:GetTransparentInput() ) .. ")" )
                --------------------------------------------------------------------------------
                -- WidgetSafe:GetPickChildrenOnly
                local result = value:GetPickChildrenOnly()
                table.insert( parts, new_indent_str .. "GetPickChildrenOnly = boolean(" .. tostring( result ) .. ")" )
                --------------------------------------------------------------------------------
                -- WidgetSafe:GetFade
                local result = value:GetFade()
                table.insert( parts, new_indent_str .. "GetFade = number(" .. result .. ")" )
                --------------------------------------------------------------------------------
                -- WidgetSafe:GetTabOrder
                local result = value:GetTabOrder()
                table.insert( parts, new_indent_str .. "GetTabOrder = number(" .. result .. ")" )
                --------------------------------------------------------------------------------
                -- WidgetSafe:GetPlacementPlain
                if __CONFIG_VAR_DUMP.WIDGET.GetPlacementPlain then
                    local result = value:GetPlacementPlain()
                    local dump = var_dump_internal( result, depth - 1, indent + 1, seen_tables, userdata_ancestors ):sub( #new_indent_str + 1 )
                    table.insert( parts, new_indent_str .. "GetPlacementPlain = " .. dump )
                end
                --------------------------------------------------------------------------------
                -- WidgetSafe:GetSmartPlacementPlain
                if __CONFIG_VAR_DUMP.WIDGET.GetSmartPlacementPlain then
                    local result = value:GetSmartPlacementPlain()
                    local dump = var_dump_internal( result, depth - 1, indent + 1, seen_tables, userdata_ancestors ):sub( #new_indent_str + 1 )
                    table.insert( parts, new_indent_str .. "GetSmartPlacementPlain = " .. dump )
                end
                --------------------------------------------------------------------------------
                -- WidgetSafe:GetRealRect
                if __CONFIG_VAR_DUMP.WIDGET.GetRealRect then
                    local result = value:GetRealRect()
                    local dump = var_dump_internal( result, depth - 1, indent + 1, seen_tables, userdata_ancestors ):sub( #new_indent_str + 1 )
                    table.insert( parts, new_indent_str .. "GetRealRect = " .. dump )
                end
                --------------------------------------------------------------------------------
                table.insert( parts, indent_str .. "}" )
                return finish( table.concat( parts, "\n" ) )
            elseif type_str == "ValuedObjectLua" then -- Изменен с ValuedObject
                local parts = { indent_str .. string.format( "userdata(%s)%s = {", type_str, address ) }
                --------------------------------------------------------------------------------
                -- ValuedObjectLua:GetType
                local objType = value:GetType()
                local typeVal = ENUM_VAL_OBJ_TYPE_MAP[ objType ] or "unknown"
                local objTypeStr = string.format( "number(%s(%d))", typeVal, objType )
                table.insert( parts, new_indent_str .. "GetType = " .. objTypeStr )
                --------------------------------------------------------------------------------
                -- ValuedObjectLua:GetId
                local objId = value:GetId()
                local dump = var_dump_internal( objId, depth - 1, indent + 1, seen_tables, userdata_ancestors ):sub( #new_indent_str + 1 )
                table.insert( parts, new_indent_str .. "GetId = " .. dump )
                --------------------------------------------------------------------------------
                -- ValuedObjectLua:GetImage
                local objImage = value:GetImage()
                --[[ if objImage ~= nil and objImage ~= value then ]]
                local dump = var_dump_internal( objImage, depth - 1, indent + 1, seen_tables, userdata_ancestors ):sub( #new_indent_str + 1 )
                table.insert( parts, new_indent_str .. "GetImage = " .. dump )
                --------------------------------------------------------------------------------
                -- ValuedObjectLua:GetShardName
                -- Метод доступен только у ValuedObjectPlayer.
                -- Иначе выбрасывает исключение: <UI::LuaValuedObjectGetShardName: ValuedObject is not ValuedObjectPlayer>
                if objType == VAL_OBJ_TYPE_PLAYER then
                    local GetShardName = value:GetShardName()
                    local dump = var_dump_internal( GetShardName, depth - 1, indent + 1, seen_tables, userdata_ancestors ):sub( #new_indent_str + 1 )
                    table.insert( parts, new_indent_str .. "GetShardName = " .. dump )
                end
                --------------------------------------------------------------------------------
                -- ValuedObjectLua:GetText
                local objText = value:GetText()
                local dump = var_dump_internal( objText, depth - 1, indent + 1, seen_tables, userdata_ancestors ):sub( #new_indent_str + 1 )
                table.insert( parts, new_indent_str .. "GetText = " .. dump )
                --------------------------------------------------------------------------------
                table.insert( parts, indent_str .. "}" )
                return finish( table.concat( parts, "\n" ) )
            elseif type_str == "ValuedText" then
                local parts = { indent_str .. string.format( "userdata(%s)%s = {", type_str, address ) }
                --------------------------------------------------------------------------------
                local str = userMods.FromWString( value:ToWString() )
                table.insert( parts, string.format( '%sToWString = WString(%d) "%s"', new_indent_str, #str, escaped( str ) ) )
                --------------------------------------------------------------------------------
                table.insert( parts, indent_str .. "}" )
                return finish( table.concat( parts, "\n" ) )
            elseif 
                type_str == "RelatedSoundsLua" or 
                type_str == "RelatedTextsLua" or 
                type_str == "RelatedTexturesLua" or 
                type_str == "RelatedWidgetsLua" 
            then
                local parts = { indent_str .. string.format( "userdata(%s)%s = {", type_str, address ) }
                --------------------------------------------------------------------------------
                -- RelatedSafe:GetList
                local list = value:GetList()
                local dump = var_dump_internal( list, depth - 1, indent + 1, seen_tables, userdata_ancestors ):sub( #new_indent_str + 1 )
                table.insert( parts, new_indent_str .. "GetList = " .. dump )
                --------------------------------------------------------------------------------
                table.insert( parts, indent_str .. "}" )
                return finish( table.concat( parts, "\n" ) )
            end
            
            return string.format( "%s(%s)%s", prefix, tostring( value ) )
        elseif native_type == "thread" then
            return prefix .. "(coroutine)"
        end
        
        return prefix
    end
    
    
    
    
    --------------------------------------------------------------------------------
    -- TABLE
    --------------------------------------------------------------------------------
    -- Когда доходит до предела глубина дерева (ограничение)
    if depth <= 0 then
        return indent_str .. "table(...)"
    end
    
    --------------------------------------------------------------------------------
    -- Определение заголовка таблицы table(Color, GamePosition, ...)
    local table_header
    local is_widget_placement = false
    local is_full_date_time = false
    local is_lua_sex_info_part = false
    local is_mutation_info = false
    local is_texture_info = false
    local count_values = countEntries( value )
    
    if isColorTable( value ) then
        table_header = string.format( "table(Color:%d) {", count_values )
    elseif isGamePositionTable( value ) then
        table_header = string.format( "table(GamePosition:%d) {", count_values )
    elseif isWidgetPlacementTable( value ) then
        table_header = string.format( "table(WidgetPlacementLua:%d) {", count_values )
        is_widget_placement = true
    elseif isGeodataTable( value ) then
        table_header = string.format( "table(Geodata:%d) {", count_values )
    elseif isInnateStatSecondaryTable( value ) then
        table_header = string.format( "table(InnateStatSecondary:%d) {", count_values )
    elseif isLuaFullDateTimeTable( value ) then
        table_header = string.format( "table(LuaFullDateTime:%d) {", count_values )
        is_full_date_time = true
    elseif isLuaRaceClassInfoPartTable( value ) then
        table_header = string.format( "table(LuaRaceClassInfoPart:%d) {", count_values )
    elseif isLuaSexInfoPartTable( value ) then
        table_header = string.format( "table(LuaSexInfoPart:%d) {", count_values )
        is_lua_sex_info_part = true
    elseif isMutationInfoTable( value ) then
        table_header = string.format( "table(MutationInfo:%d) {", count_values )
        is_mutation_info = true
    elseif isTextureInfoTable( value ) then
        table_header = string.format( "table(%d) {", count_values )
        is_texture_info = true
    elseif ENABLE_TWIDGET and IsTWidget( value ) then -- Вывод особой таблицы TWidget
        local raw_widget = value:GetRaw()
        local dump = var_dump_internal( raw_widget, depth - 1, indent, seen_tables, userdata_ancestors ):gsub( "userdata%(", "TWidget(", 1 )
        return dump
    else
        table_header = string.format( "table(%d) {", count_values )
    end
    --------------------------------------------------------------------------------

    local parts = { indent_str .. table_header }
    local new_depth = depth - 1
    local new_indent = indent + 1
    local new_indent_str = string.rep( indent_mode, new_indent )
    
    -- Сбор ключей
    local keys = {}
    local k = nil
    while true do
        k = next( value, k )
        if k == nil then
            break
        end
        table.insert( keys, k )
    end
    
    -- Сортировка ключей: числа, строки, остальные
    table.sort( keys, function( a, b )
        local ta, tb = type( a ), type( b )
        if ta == "number" and tb == "number" then return a < b end
        if ta == "number" then return true end
        if tb == "number" then return false end
        if ta == "string" and tb == "string" then return a < b end
        return ta < tb
    end )
    
    -- Прочёс по каждому элементу
    for _, k in ipairs( keys ) do
        local v = value[k]
        local key_str
        if type( k ) == "string" and k:match( "^[%a_][%w_]*$" ) then
            key_str = string.format( '["%s"]', k )
        else
            key_str = string.format( "[%s]", tostring( k ) )
        end

        local dump
        --------------------------------------------------------------------------------
        if is_widget_placement and type( v ) == "number" and type( k ) == "string" then
            -- Если таблица WidgetPlacementLua
            if k == "alignX" or k == "alignY" then
                local constName = WIDGET_ALIGN_MAP[v] or "unknown"
                dump = string.format( "number(%s(%d))", constName, v )
            elseif k == "sizingX" or k == "sizingY" then
                local constName = WIDGET_SIZING_MAP[v] or "unknown"
                dump = string.format( "number(%s(%d))", constName, v )
            end
        elseif is_full_date_time and type( v ) == "number" and type( k ) == "string" then
            -- Если таблица LuaFullDateTime
            if k == "wday" then
                local constName = ENUM_DAY_OF_WEEK_MAP[v] or "unknown"
                dump = string.format( "number(%s(%d))", constName, v )
            elseif k == "month" then
                local constName = ENUM_MONTH_MAP[v] or "unknown"
                dump = string.format( "number(%s(%d))", constName, v )
            end
        elseif is_lua_sex_info_part and type( v ) == "number" and k == "sex" then
            -- Если таблица LuaSexInfoPart
            local constName = ENUM_SEX_MAP[v] or "unknown"
            dump = string.format( "number(%s(%d))", constName, v )
        elseif is_mutation_info and type( v ) == "number" and k == "difficulty" then
            -- Если таблица MutationInfo
            local constName = ENUM_ZONE_TIER_DIFFICULTY_MAP[v] or "unknown"
            dump = string.format( "number(%s(%d))", constName, v )
        elseif is_texture_info and type( v ) == "number" and k == "type" then
            -- Если таблица TextureInfo
            local constName = TEXTURE_TYPE_MAP[v] or "UNKNOWN"
            dump = string.format( "number(%s:%d)", constName, v )
        end
        --------------------------------------------------------------------------------
        if not dump then
            dump = var_dump_internal( v, new_depth, new_indent, seen_tables, userdata_ancestors ):sub( #new_indent_str + 1 )
        end

        table.insert( parts, string.format( "%s => %s", new_indent_str .. key_str, dump ) )
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