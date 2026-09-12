-- test Global( "__CONFIG_VAR_DUMP", {} )

-- ( DEFAULT не трогать. Юзать __CONFIG_VAR_DUMP = {...} )
-- Включение и настройка опций для участия дамба
local DEFAULT_CONFIG_VAR_DUMP = {
    DEBUG = {
        version = "v1.5.1",
        depth = 10, -- Максимальная глубина рекурсии. table(...) { 1 => table(...) { 1 => И т.д.. } }
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

--- Совмещение default и юзер таблицы конфига
--- @param base table Дефолт таблица
--- @param source table user custom table
--- @return table
local function deepMerge( base, source )
    local result = {}
    
    for k, v in pairs( base ) do
        if type( v ) == "table" and type( source[k] ) == "table" then
            result[k] = deepMerge( v, source[k] )
        else
            result[k] = v
        end
    end
    
    for k, v in pairs( source ) do
        if result[k] == nil then
            result[k] = v
        end
    end
    
    return result
end

local user_config = rawget( _G, "__CONFIG_VAR_DUMP" )
if type( user_config ) == "table" then
    if not user_config.DEBUG or user_config.DEBUG.version ~= DEFAULT_CONFIG_VAR_DUMP.DEBUG.version then
        common.LogInfo( "common", 
            "[var_dump] Warning: Your __CONFIG_VAR_DUMP is outdated. " ..
            "Please update to version " .. DEFAULT_CONFIG_VAR_DUMP.DEBUG.version
        )
    end
end

local __CONFIG_VAR_DUMP = deepMerge( DEFAULT_CONFIG_VAR_DUMP, user_config or {} )

-- Если появился тип TWidget
local ENABLE_TWIDGET = type( rawget( _G, "IsTWidget" ) ) == "function"

--------------------------------------------------------------------------------
-- Маппинг констант взамен значений.
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

-- Маппинг для (TextureInfo). В кодовом API таких констант не существует. Только для текстурных виджетов.
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
        if type( tbl ) ~= "table" then
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

        -- Кол-во ключей не совпадает
        if count ~= expected_count then
            return false
        end

        -- Нужные ключи не присутствуют
        for k in pairs( schema ) do
            if not found[k] then
                return false
            end
        end

        return true
    end
end

--------------------------------------------------------------------------------
--- Каждая таблица содержит:
--- name - имя типа для заголовка
--- schema - схема полей типизации для createTableValidator
--- fieldMappers - маппинг полей (необязательно)
--- customFormatter - кастомная форматировка (необязательно)
--------------------------------------------------------------------------------
local TABLE_TYPES = {
    {
        name = "Color",
        schema = {
            r = function( v ) return type( v ) == "number" and v >= 0 and v <= 1 end,
            g = function( v ) return type( v ) == "number" and v >= 0 and v <= 1 end,
            b = function( v ) return type( v ) == "number" and v >= 0 and v <= 1 end,
            a = function( v ) return type( v ) == "number" and v >= 0 and v <= 1 end,
        },
    },
    {
        name = "GamePosition",
        schema = {
            posX = { "number" }, posY = { "number" }, posZ = { "number" },
        },
    },
    {
        name = "WidgetPlacementLua",
        schema = {
            alignX = { "number" }, alignY = { "number" },
            highPosX = { "number" }, highPosY = { "number" },
            posX = { "number" }, posY = { "number" },
            sizeX = { "number" }, sizeY = { "number" },
            sizingX = { "number" }, sizingY = { "number" },
        },
        fieldMappers = {
            alignX = WIDGET_ALIGN_MAP,
            alignY = WIDGET_ALIGN_MAP,
            sizingX = WIDGET_SIZING_MAP,
            sizingY = WIDGET_SIZING_MAP,
        },
    },
    {
        name = "Geodata",
        schema = {
            x = { "number" }, y = { "number" },
            width = { "number" }, height = { "number" },
        },
    },
    {
        name = "InnateStatSecondary",
        schema = {
            N1 = { "number" }, N2 = { "number" }, N3 = { "number" }, N4 = { "number" },
            isLow = { "boolean" }, isReduced = { "boolean" },
        },
    },
    {
        name = "LuaFullDateTime",
        schema = {
            y = { "number" }, m = { "number" }, d = { "number" },
            h = { "number" }, min = { "number" }, s = { "number" }, ms = { "number" },
            wday = { "number" }, month = { "number" },
            sysMonth = { "string" }, overallMs = { "number" },
        },
        fieldMappers = {
            wday = ENUM_DAY_OF_WEEK_MAP,
            month = ENUM_MONTH_MAP,
        },
    },
    {
        name = "LuaRaceClassInfoPart",
        schema = {
            sysName = { "string" }, name = { "WString" }, description = { "WString" },
            sysClassName = { "string" }, className = { "WString" },
            sysRaceName = { "string" }, raceName = { "WString" },
        },
    },
    {
        name = "LuaSexInfoPart",
        schema = {
            sex = { "number" },
            name = { "WString" },
            raceSexName = { "WString" },
        },
        fieldMappers = {
            sex = ENUM_SEX_MAP,
        },
    },
    {
        name = "MutationInfo",
        schema = {
            difficulty = { "number" },
            population = { "number" },
            buffId = { "BuffId" },
        },
        fieldMappers = {
            difficulty = ENUM_ZONE_TIER_DIFFICULTY_MAP,
        },
    },
    {
        name = "TextureInfo",
        schema = {
            binaryFile = { "string" },
            realHeight = { "number" },
            realWidth = { "number" },
            type = { "number" },
            xdbFile = { "string" },
        },
        -- number(DXT1:0) вместо number(DXT1(0))
        customFormatter = function( k, v )
            if k == "type" and type( v ) == "number" then
                local constName = TEXTURE_TYPE_MAP[v] or "UNKNOWN"
                return string.format( "number(%s:%d)", constName, v )
            end
        end,
    },
}

for _, desc in ipairs( TABLE_TYPES ) do
    desc.validator = createTableValidator( desc.schema )
end

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
--- @param ctx table Контекст рекурсии { depth, indent, seen, ancestors }
--- @param inline? boolean Если true, не добавляет отступ к первой строке
--- @return string
local function var_dump_internal( value, ctx, inline )
    local indent_mode = "    "
    local indent_str = string.rep( indent_mode, ctx.indent )
    local header_indent = inline and "" or indent_str
    
    local type_str = apitype( value )
    local native_type = type( value )
    
    local is_table = ( native_type == "table" )
    local is_userdata = ( native_type == "userdata" and type_str ~= "WString" )
    local is_light_userdata = ( native_type == "userdata" and type_str == "userdata" )
    
    --- Add рекурсивный дамп.
    local function ctxAdd( ctx, key, val )
        local dump = var_dump_internal( val, ctx, true )
        table.insert( ctx.parts, ctx.new_indent .. key .. " = " .. dump )
    end

    --- Add отформатированную строку.
    local function ctxAddRaw( ctx, key, formatted_val )
        table.insert( ctx.parts, ctx.new_indent .. key .. " = " .. formatted_val )
    end
    
    -- проверка на циклические ссылки
    if is_table and ctx.seen[ value ] then
        return header_indent .. string.format( "%s(0) = *RECURSION*", native_type )
    end
    
    if is_userdata and not is_light_userdata and ctx.ancestors[ value ] then
        return header_indent .. string.format( "%s(%s) = *RECURSION*", native_type, type_str )
    end
    
    -- set на посещение
    if is_table then ctx.seen[ value ] = true end
    if is_userdata and not is_light_userdata then ctx.ancestors[ value ] = true end
    
    -- для очистки userdata из пути рекурсии
    local function finish( result )
        if is_userdata and not is_light_userdata then
            ctx.ancestors[ value ] = nil
        end
        return result
    end
    
    -- nil. Если таблица { name = nil }, то вернёт пустую {}у
    if value == nil then
        return header_indent .. "nil"
    end
    
    local block_ctx = {
        depth = ctx.depth - 1,
        indent = ctx.indent + 1,
        seen = ctx.seen,
        ancestors = ctx.ancestors,
        parts = {},
        new_indent = string.rep( indent_mode, ctx.indent + 1 )
    }
    
    --------------------------------------------------------------------------------
    -- string, number, boolean, function, light userdata, userdata( apitype ), thread
    --------------------------------------------------------------------------------
    if native_type ~= "table" then
        local prefix = header_indent .. type_str
        if native_type == "string" then
            return header_indent .. string.format( '%s(%d) "%s"', type_str, #value, escaped( value ) )
        elseif native_type == "number" then
            return header_indent .. string.format( "%s(%s)", type_str, tostring( value ) )
        elseif native_type == "boolean" then
            return header_indent .. string.format( "%s(%s)", type_str, value and "true" or "false" )
        elseif native_type == "function" then
            return header_indent .. string.format( "%s(%s)", type_str, tostring( value ) )
        elseif native_type == "userdata" then
            local address = ""
            
            if __CONFIG_VAR_DUMP.USERDATA.hexadecimal or is_light_userdata then
                local hex = tostring( value ):match( "0x(%x+)" )
                address = hex and ( "#0x" .. hex ) or ""
            end
            --------------------------------------------------------------------------------
            -- light userdata
            if is_light_userdata then
                return header_indent .. string.format( "light userdata(%s)", address )
            end
            --------------------------------------------------------------------------------
            if type_str == "WString" then
                local str = userMods.FromWString( value )
                return header_indent .. string.format( '%s(%d) "%s"', type_str, #str, escaped( str ) )
            elseif type_str == "FactoryCacheSafe" then
                block_ctx.parts = { header_indent .. string.format( "userdata(%s)%s = {", type_str, address ) }
                --------------------------------------------------------------------------------
                ctxAdd( block_ctx, "IsValid", value:IsValid() )
                ctxAdd( block_ctx, "GetId", value:GetId() )
                ctxAdd( block_ctx, "GetDebugInfo", value:GetDebugInfo() )
                --------------------------------------------------------------------------------
                table.insert( block_ctx.parts, indent_str .. "}" )
                return finish( table.concat( block_ctx.parts, "\n" ) )
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
                block_ctx.parts = { header_indent .. string.format( "userdata(%s)%s = {", type_str, address ) }
                local info_getter = RESOURCE_INFO_MAP[ type_str ]
                --------------------------------------------------------------------------------
                if not __CONFIG_VAR_DUMP.RESOURCE_ID.GetOnlyInfo and info_getter then
                    ctxAdd( block_ctx, info_getter.name, info_getter.fn( value ) )
                else
                    -- ResourceId:GetInfo
                    local info = value:GetInfo()
                    if type( info ) == "table" and next( info ) ~= nil then
                        ctxAdd( block_ctx, "GetInfo", info )
                    end
                end
                --------------------------------------------------------------------------------
                table.insert( block_ctx.parts, ( #block_ctx.parts > 1 and indent_str or "" ) .. "}" )
                return finish( table.concat( block_ctx.parts, ( #block_ctx.parts > 2 and "\n" or "" ) ) )
                --------------------------------------------------------------------------------
            elseif type_str:sub( 1, 7 ) == "Widget_" then
                local display_type = type_str:gsub( "_", "" ):gsub( "Safe$", "" )
                block_ctx.parts = { header_indent .. string.format( "userdata(%s)%s = {", display_type, address ) }
                --------------------------------------------------------------------------------
                ctxAdd( block_ctx, "GetDebugInfo", value:GetDebugInfo() )
                --------------------------------------------------------------------------------
                local addonType = value:GetAddonType()
                ctxAddRaw( block_ctx, "GetAddonType", string.format( "number(%s(%d))", ENUM_ADDON_TYPE_MAP[addonType] or "unknown", addonType ) )
                --------------------------------------------------------------------------------
                ctxAdd( block_ctx, "GetId", value:GetId() )
                ctxAdd( block_ctx, "GetAddonName", value:GetAddonName() )
                ctxAdd( block_ctx, "GetName", value:GetName() )
                ctxAdd( block_ctx, "GetPriority", value:GetPriority() )
                --------------------------------------------------------------------------------
                -- WidgetSafe:GetBackgroundColor
                -- WidgetSafe:GetBackgroundTexture
                local hasBg = value:HasBackground()
                if hasBg then
                    local bgColor = value:GetBackgroundColor()
                    local bgTex = value:GetBackgroundTexture()
                    local texInfo = bgTex and common.GetTextureInfo( bgTex )
                    
                    if bgColor then
                        ctxAdd( block_ctx, "GetBackgroundColor", bgColor )
                    end
                    
                    if texInfo then
                        ctxAdd( block_ctx, "GetBackgroundTexture", texInfo )
                    else 
                        ctxAddRaw( block_ctx, "GetBackgroundTexture", '"No texture"' )
                    end
                end
                --------------------------------------------------------------------------------
                -- WidgetSafe:GetForegroundColor
                -- WidgetSafe:GetForegroundTexture
                local hasFg = value:HasForeground()
                if hasFg then
                    local fgColor = value:GetForegroundColor()
                    local fgTex = value:GetForegroundTexture()
                    local texInfo = fgTex and common.GetTextureInfo( fgTex )
                    
                    if fgColor then
                        ctxAdd( block_ctx, "GetForegroundColor", fgColor )
                    end
                    
                    if texInfo then
                        ctxAdd( block_ctx, "GetForegroundTexture", texInfo )
                    else 
                        ctxAddRaw( block_ctx, "GetForegroundTexture", '"No texture"' )
                    end
                end
                --------------------------------------------------------------------------------
                -- WidgetSafe:GetNamedChildren (только имена, ибо уйдет в цикличность)
                local GetNamedChildren = value:GetNamedChildren()
                if next( GetNamedChildren ) ~= nil then
                    local child_indent_str = block_ctx.new_indent .. indent_mode
                    local child_parts = { block_ctx.new_indent .. "GetNamedChildren = table(" .. #GetNamedChildren .. ") {" }
                    for i, child in ipairs( GetNamedChildren ) do
                        if __CONFIG_VAR_DUMP.WIDGET.GetNamedChildren then
                            local child_ctx = { depth = block_ctx.depth, indent = ctx.indent + 2, seen = ctx.seen, ancestors = ctx.ancestors }
                            local dump = var_dump_internal( child, child_ctx, true )
                            table.insert( child_parts, string.format( "%s[%d] => %s", child_indent_str, i, dump ) )
                        else
                            local child_display_type = apitype( child ):gsub( "_", "" ):gsub( "Safe$", "" )
                            local name_str = child:GetName()
                            local child_address = ""
                            
                            if __CONFIG_VAR_DUMP.USERDATA.hexadecimal then
                                local hex = tostring( child ):match( "0x(%x+)" )
                                child_address = hex and ( "#0x" .. hex ) or ""
                            end
                            
                            table.insert( child_parts, string.format( 
                                "%s[%d] => userdata(%s)%s = { GetName = string(%s) \"%s\" }", 
                                child_indent_str, i, child_display_type, child_address, #name_str, name_str
                            ) )
                        end
                    end
                    
                    table.insert( child_parts, block_ctx.new_indent .. "}" )
                    table.insert( block_ctx.parts, table.concat( child_parts, "\n" ) )
                end
                --------------------------------------------------------------------------------
                -- WidgetSafe:GetParent (только имя, ибо уйдет в цикличность)
                local parent = value:GetParent()
                if parent then
                    local parent_display_type = apitype( parent ):gsub( "_", "" ):gsub( "Safe$", "" )
                    local name_str = "\"" .. parent:GetName() .. "\""
                    local parent_address = ""
                    if __CONFIG_VAR_DUMP.USERDATA.hexadecimal then
                        local hex = tostring( parent ):match( "0x(%x+)" )
                        parent_address = hex and ( "#0x" .. hex ) or ""
                    end
                    
                    ctxAddRaw( block_ctx, "GetParent", string.format(
                        "userdata(%s)%s = { GetName = %s }", 
                        parent_display_type, parent_address, name_str
                    ) )
                end
                --------------------------------------------------------------------------------
                if __CONFIG_VAR_DUMP.WIDGET.IsEnabled then
                    ctxAdd( block_ctx, "IsEnabled", value:IsEnabled() )
                end
                --------------------------------------------------------------------------------
                if __CONFIG_VAR_DUMP.WIDGET.IsEnabledEx then
                    ctxAdd( block_ctx, "IsEnabledEx", value:IsEnabledEx() )
                end
                --------------------------------------------------------------------------------
                if __CONFIG_VAR_DUMP.WIDGET.IsVisible then
                    ctxAdd( block_ctx, "IsVisible", value:IsVisible() )
                end
                --------------------------------------------------------------------------------
                if __CONFIG_VAR_DUMP.WIDGET.IsVisibleEx then
                    ctxAdd( block_ctx, "IsVisibleEx", value:IsVisibleEx() )
                end
                --------------------------------------------------------------------------------
                ctxAdd( block_ctx, "GetTransparentInput", value:GetTransparentInput() )
                ctxAdd( block_ctx, "GetPickChildrenOnly", value:GetPickChildrenOnly() )
                --------------------------------------------------------------------------------
                ctxAdd( block_ctx, "GetFade", value:GetFade() )
                ctxAdd( block_ctx, "GetTabOrder", value:GetTabOrder() )
                --------------------------------------------------------------------------------
                if __CONFIG_VAR_DUMP.WIDGET.GetPlacementPlain then
                    ctxAdd( block_ctx, "GetPlacementPlain", value:GetPlacementPlain() )
                end
                --------------------------------------------------------------------------------
                if __CONFIG_VAR_DUMP.WIDGET.GetSmartPlacementPlain then
                    ctxAdd( block_ctx, "GetSmartPlacementPlain", value:GetSmartPlacementPlain() )
                end
                --------------------------------------------------------------------------------
                if __CONFIG_VAR_DUMP.WIDGET.GetRealRect then
                    ctxAdd( block_ctx, "GetRealRect", value:GetRealRect() )
                end
                --------------------------------------------------------------------------------
                table.insert( block_ctx.parts, indent_str .. "}" )
                return finish( table.concat( block_ctx.parts, "\n" ) )
                --------------------------------------------------------------------------------
            elseif type_str == "ValuedObjectLua" then 
                block_ctx.parts = { header_indent .. string.format( "userdata(%s)%s = {", type_str, address ) }
                --------------------------------------------------------------------------------
                -- ValuedObjectLua:GetType
                local objType = value:GetType()
                local typeVal = ENUM_VAL_OBJ_TYPE_MAP[ objType ] or "unknown"
                local objTypeStr = string.format( "number(%s(%d))", typeVal, objType )
                ctxAddRaw( block_ctx, "GetType", objTypeStr )
                --------------------------------------------------------------------------------
                ctxAdd( block_ctx, "GetId", value:GetId() )
                ctxAdd( block_ctx, "GetImage", value:GetImage() )
                ctxAdd( block_ctx, "GetText", value:GetText() )
                --------------------------------------------------------------------------------
                -- ValuedObjectLua:GetShardName
                -- Метод доступен только у ValuedObjectPlayer.
                -- Иначе выбрасывает исключение: <UI::LuaValuedObjectGetShardName: ValuedObject is not ValuedObjectPlayer>
                if objType == VAL_OBJ_TYPE_PLAYER then
                    ctxAdd( block_ctx, "GetShardName", value:GetShardName() )
                end
                --------------------------------------------------------------------------------
                table.insert( block_ctx.parts, indent_str .. "}" )
                return finish( table.concat( block_ctx.parts, "\n" ) )
                --------------------------------------------------------------------------------
            elseif type_str == "ValuedText" then
                block_ctx.parts = { header_indent .. string.format( "userdata(%s)%s = {", type_str, address ) }
                --------------------------------------------------------------------------------
                ctxAdd( block_ctx, "ToWString", value:ToWString() )
                ctxAdd( block_ctx, "userMods.FromValuedText", userMods.FromValuedText( value, true ) )
                --------------------------------------------------------------------------------
                table.insert( block_ctx.parts, indent_str .. "}" )
                return finish( table.concat( block_ctx.parts, "\n" ) )
            elseif 
                type_str == "RelatedSoundsLua" or type_str == "RelatedTextsLua" or 
                type_str == "RelatedTexturesLua" or type_str == "RelatedWidgetsLua" 
            then
                block_ctx.parts = { header_indent .. string.format( "userdata(%s)%s = {", type_str, address ) }
                --------------------------------------------------------------------------------
                ctxAdd( block_ctx, "GetList", value:GetList() )
                --------------------------------------------------------------------------------
                table.insert( block_ctx.parts, indent_str .. "}" )
                return finish( table.concat( block_ctx.parts, "\n" ) )
            end
            
            -- UniqueId
            --------------------------------------------------------------------------------
            -- Оставлю на память. "Tail Call Optimization Lua"
            -- Некорректно формируется стек-трейс в Lua c аномальным "bad argument #4".
            -- указывает на вызывающую функцию var_dump_internal вместо string.format
            -- bad argument #4 to 'var_dump_internal' (value expected)
            -- func: ?, ?, line: -1, defined: C, line: -1, [C]
            -- func: var_dump_internal, upvalue, line: -1, defined: C, line: -1, [C]
            -- Fix: 
            -- return string.format( "%s(%s)%s", prefix, tostring( value ) )
            -- to:
            --------------------------------------------------------------------------------
            return header_indent .. string.format( "userdata(%s)%s", type_str, address )
            
        elseif native_type == "thread" then
            return prefix .. "(coroutine)"
        end
        
        return prefix
    end
    
    --------------------------------------------------------------------------------
    -- TABLE
    --------------------------------------------------------------------------------
    -- Когда доходит до предела глубина дерева (ограничение)
    if ctx.depth <= 0 then
        return header_indent .. "table(...)"
    end
    
    --------------------------------------------------------------------------------
    -- Определение заголовка table(Color, ...)
    local table_header
    local matched_type = nil
    local count_values = countEntries( value )
    
    if __CONFIG_VAR_DUMP.TABLE.tableIdentification then
        for _, desc in ipairs( TABLE_TYPES ) do
            if desc.validator( value ) then
                matched_type = desc
                break
            end
        end
    end
    
    if matched_type then
        table_header = string.format( "table(%s:%d) {", matched_type.name, count_values )
    elseif ENABLE_TWIDGET and IsTWidget( value ) then
    local raw_widget = value:GetRaw()
        local dump = var_dump_internal( raw_widget, ctx, inline ):gsub( "userdata%(", "TWidget(", 1 )
        return dump
    else
        table_header = string.format( "table(%d) {", count_values )
    end
    
    --------------------------------------------------------------------------------
    
    local parts = { header_indent .. table_header }
    local keys = {}
    
    local k = nil
    while true do
        k = next( value, k )
        if k == nil then break end
        table.insert( keys, k )
    end
    
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
        
        local dump = nil
        --------------------------------------------------------------------------------
        if matched_type and type( v ) == "number" and type( k ) == "string" then
            -- Сначало кастомный форматтер
            if matched_type.customFormatter then
                dump = matched_type.customFormatter( k, v )
            elseif matched_type.fieldMappers and matched_type.fieldMappers[k] then
                local map = matched_type.fieldMappers[k]
                local constName = map[v] or "unknown"
                dump = string.format( "number(%s(%d))", constName, v )
            end
        end
        --------------------------------------------------------------------------------
        
        if not dump then
            dump = var_dump_internal( v, block_ctx, true )
        end
        
        table.insert( parts, string.format( "%s => %s", block_ctx.new_indent .. key_str, dump ) )
    end
    
    table.insert( parts, indent_str .. "}" )
    return finish( table.concat( parts, "\n" ) )
end

-- Public функция
function var_dump( ... )
    local results = {}
    local result
    local args = { ... }
    
    for i = 1, #args do
        result = var_dump_internal( args[i], { 
            depth = __CONFIG_VAR_DUMP.DEBUG.depth, 
            indent = 0, 
            seen = {}, 
            ancestors = {} 
        } )
        
        table.insert( results, result )
    end
    
    local info = "<<< Debug info var_dump >>>\n" .. 
        "======================BEGIN======================\n" .. 
        table.concat( results, "\n----------------------\n" ) .. "\n" .. 
        "=======================END=======================\n"
    
    common.LogInfo( "common", info ) -- Ограничение 64000 символов.
end