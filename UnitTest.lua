--------------------------------------------------------------------------------



--------------------------------------------------------------------------------
--- @type ForgeCraftRecipeId - ресурс рецепта крафта
--- @type ForgeCraftResourceId -- GetInfo - ресурс forge крафта
--------------------------------------------------------------------------------
--var_dump( craft.GetForgeRecipes() )

--------------------------------------------------------------------------------
--- @type SpellId
--- @type ActionGroupId -- GetInfo
--------------------------------------------------------------------------------
--var_dump( avatar.GetSpellBook() )

--------------------------------------------------------------------------------
--- @type RecipeId
--- @type ComponentPropertyId
--------------------------------------------------------------------------------
--var_dump( avatar.GetAlchemyInfo() )

--------------------------------------------------------------------------------
--- @type ValuedText
--- @type RelatedTextsLua
--------------------------------------------------------------------------------
--[[ local group = common.GetAddonRelatedTextGroup( "template", true )
local vt = common.CreateValuedText {
    format = group:GetText( "RECIPE_LINE" ),
    level = 5,
}
var_dump( vt, group ) ]]

--------------------------------------------------------------------------------
--- @type AbilityId
--------------------------------------------------------------------------------
--var_dump( avatar.GetAbilities()[1] )

--------------------------------------------------------------------------------
--- @type BattlegroundMarkId
--------------------------------------------------------------------------------
--var_dump( battleground.GetAvatarMark() )

--------------------------------------------------------------------------------
--- @type BuffId
--------------------------------------------------------------------------------
--[[ for buffId, buffInfo in pairs( object.GetBuffsInfo( avatar.GetId(), true, true ) ) do
    var_dump( buffId, buffInfo )
end ]]

--------------------------------------------------------------------------------
--- @type CharacterClassId
--------------------------------------------------------------------------------
--var_dump( avatar.GetClassId() )

--------------------------------------------------------------------------------
--- Пробовать на обличие класса, например: демонолог
--- @type CharacterFormId
--------------------------------------------------------------------------------
--var_dump( unit.GetCharacterForm( avatar.GetId() ) )

--------------------------------------------------------------------------------
--- @type CurrencyId
--- @type CurrencyCategoryId
--------------------------------------------------------------------------------
--var_dump( avatar.GetCurrencyId( "myrrh" ) )

--------------------------------------------------------------------------------
--- @type FactionId
--------------------------------------------------------------------------------
--var_dump( unit.GetFactionId( avatar.GetId() ) )

--------------------------------------------------------------------------------
--- @type UnlockId
--- @type UnlockCategoryId
--------------------------------------------------------------------------------
--[[ for _, unlockId in ipairs( avatar.GetUnlocks() ) do
    var_dump( avatar.GetUnlockInfo( unlockId ) )
end ]]

--------------------------------------------------------------------------------
--- @type LifestyleCategoryId
--------------------------------------------------------------------------------
--var_dump( checkroomLib.GetCategories() )

--------------------------------------------------------------------------------
--- @type GlossaryId ?
--------------------------------------------------------------------------------
--var_dump( test )

--------------------------------------------------------------------------------
--- @type GoalId
--------------------------------------------------------------------------------
--var_dump( common.GetAllodsGoalsOnLoadingScreen() )

--------------------------------------------------------------------------------
--- @type InstancedEventCategoryId
--------------------------------------------------------------------------------
--var_dump( matchMaking.GetEventCategories() )

--------------------------------------------------------------------------------
--- @type InstancedEventResourceId
--------------------------------------------------------------------------------
--var_dump( mwar.GetCommonMatchMakingInfo() )

--------------------------------------------------------------------------------
--- @type InterfaceMapMarkerId
--------------------------------------------------------------------------------
--var_dump( cartographer.GetMapMarkers( cartographer.GetCurrentZoneInfo().zonesMapId ) )

--------------------------------------------------------------------------------
--- @type ItemCategoryId
--------------------------------------------------------------------------------
--var_dump( itemLib.GetRootCategories() )

--------------------------------------------------------------------------------
--- пробовать на локации, например: Царство стихий. ["name"] => WString(16) "Огнеяр повержен!"
--- @type MapModifierId
--------------------------------------------------------------------------------
--var_dump( cartographer.GetCurrentMapModifiers() )

--------------------------------------------------------------------------------
--- @type PostTypeId
--------------------------------------------------------------------------------
--var_dump( bulletinBoard.GetSectionInfos() )

--------------------------------------------------------------------------------
--- Находиться в ангаре с кораблём своим
--- @type ShipSkinId
--------------------------------------------------------------------------------
--var_dump( hangar.GetAvailableSkins() )

--------------------------------------------------------------------------------
--- @type SpecialStatId
--------------------------------------------------------------------------------
--var_dump( avatar.GetRecommendedStats() )

--------------------------------------------------------------------------------
--- @type TutorialCategoryId
--- @type TutorialId
--------------------------------------------------------------------------------
--[[ local categories = tutorialLib.GetCategories() -- TutorialCategoryId
local tutorialIds = tutorialLib.GetCategoryContent( categories[1] ) -- TutorialId
var_dump( categories, tutorialIds ) ]]

--------------------------------------------------------------------------------
--- @type VariableId
--------------------------------------------------------------------------------
--var_dump( avatar.GetVariables() )

--------------------------------------------------------------------------------
--- Тест на цикличность
--------------------------------------------------------------------------------
--[[ local a = { w = userMods.ToWString( "rrr" ), d = nil}
local b = { c = a.w, a = a }
a.d = b
var_dump( a ) ]]

--------------------------------------------------------------------------------
--- @type ItemClassId
--------------------------------------------------------------------------------
--var_dump( avatar.GetItemClassList() )

--------------------------------------------------------------------------------
--- @type OrderBonusId
--------------------------------------------------------------------------------
--var_dump( order.GetOrderBonus() )

--------------------------------------------------------------------------------
--- Reforge (перековка) - это механика в кузнечном деле. Позволяет улучшать качество создаваемых предметов. 
--- @type ReforgeResourceId
--------------------------------------------------------------------------------
--???var_dump( craft.GetReforgeRecipe() )

--------------------------------------------------------------------------------
--- @type ZodiacSignId
--------------------------------------------------------------------------------
--[[ local id = unit.GetEquipmentItemId( avatar.GetId(), DRESS_SLOT_OFFENSIVERUNE1, ITEM_CONT_EQUIPMENT )
local itemRuneInfo = itemLib.GetRuneInfo( id )
var_dump( itemRuneInfo ) ]]

--------------------------------------------------------------------------------
--- @type userdata | table Widget
--------------------------------------------------------------------------------
--var_dump( common.GetAddonMainForm( "UserAddon/LibreAlchemyV2" ) )
--var_dump( mainForm )
--var_dump( _G )
--------------------------------------------------------------------------------
--- @type FactoryCacheSafe | lightuserdata
--------------------------------------------------------------------------------
--var_dump( mainForm:GetFactoryCache() )
--[[ local cache = mainForm:GetFactoryCache()
common.LogInfo("common", "type=" .. type(cache) .. " apitype=" .. apitype(cache) ) ]]
--------------------------------------------------------------------------------
--- @type thread
--------------------------------------------------------------------------------
--var_dump( coroutine.create( function() end ) )

--------------------------------------------------------------------------------
--- @type test
--------------------------------------------------------------------------------
--var_dump( test )



--[[ 
table(184) {
    ["apitype"] => function(function: builtin#31)
    ["assert"] => function(function: builtin#2)
    ["bit"] => table(12) {
        ["arshift"] => function(function: builtin#72)
        ["band"] => function(function: builtin#75)
        ["bnot"] => function(function: builtin#68)
        ["bor"] => function(function: builtin#76)
        ["bswap"] => function(function: builtin#69)
        ["bxor"] => function(function: builtin#77)
        ["lshift"] => function(function: builtin#70)
        ["rol"] => function(function: builtin#73)
        ["ror"] => function(function: builtin#74)
        ["rshift"] => function(function: builtin#71)
        ["tobit"] => function(function: builtin#67)
        ["tohex"] => function(function: builtin#78)
    }
    ["collectgarbage"] => function(function: builtin#28) -- интерфейс для управления сборщиком мусора
    ["coroutine"] => table(7) { -- public
        ["create"] => function(function: builtin#36)
        ["isyieldable"] => function(function: builtin#35)
        ["resume"] => function(function: builtin#38)
        ["running"] => function(function: builtin#34)
        ["status"] => function(function: builtin#33)
        ["wrap"] => function(function: builtin#40)
        ["yield"] => function(function: builtin#37)
    }
    ["dofile"] => function(function: builtin#26)
    ["error"] => function(function: builtin#20)
    ["gcinfo"] => function(function: builtin#27)
    ["getfenv"] => function(function: builtin#10)
    ["getmetatable"] => function(function: builtin#8)
    ["ipairs"] => function(function: builtin#7)
    ["isindexableudata"] => function(function: builtin#32)
    ["jit"] => table(10) {
        ["arch"] => string(3) "x64"
        ["attach"] => function(function: builtin#108)
        ["flush"] => function(function: builtin#105)
        ["off"] => function(function: builtin#104)
        ["on"] => function(function: builtin#103)
        ["os"] => string(7) "Windows"
        ["security"] => function(function: builtin#107)
        ["status"] => function(function: builtin#106)
        ["version"] => string(28) "LuaJIT 2.1.1741730670_Allods"
        ["version_num"] => number(20199)
    }
    ["load"] => function(function: builtin#24)
    ["loadfile"] => function(function: builtin#23)
    ["loadstring"] => function(function: builtin#25)
    ["math"] => table(34) {
        ["abs"] => function(function: builtin#41)
        ["acos"] => function(function: builtin#51)
        ["asin"] => function(function: builtin#50)
        ["atan"] => function(function: builtin#52)
        ["atan2"] => function(function: builtin#59)
        ["ceil"] => function(function: builtin#43)
        ["clamp"] => function(function: 0x4a9f6d48)
        ["cos"] => function(function: builtin#48)
        ["cosh"] => function(function: builtin#54)
        ["deg"] => function(function: 0x4a9f5bc0)
        ["exp"] => function(function: builtin#46)
        ["floor"] => function(function: builtin#42)
        ["fmod"] => function(function: builtin#61)
        ["frexp"] => function(function: builtin#56)
        ["huge"] => number(inf)
        ["ldexp"] => function(function: builtin#62)
        ["log"] => function(function: builtin#58)
        ["log10"] => function(function: builtin#45)
        ["max"] => function(function: builtin#64)
        ["min"] => function(function: builtin#63)
        ["modf"] => function(function: builtin#57)
        ["pi"] => number(3.1415926535898)
        ["pow"] => function(function: builtin#60)
        ["rad"] => function(function: 0x4a9f5ca0)
        ["random"] => function(function: builtin#65)
        ["randomseed"] => function(function: builtin#66)
        ["round"] => function(function: 0x4a9f6ce8)
        ["sign"] => function(function: 0x4a9f5148)
        ["sin"] => function(function: builtin#47)
        ["sinh"] => function(function: builtin#53)
        ["sqrt"] => function(function: builtin#44)
        ["tan"] => function(function: builtin#49)
        ["tanh"] => function(function: builtin#55)
        ["wrap"] => function(function: 0x4a9f6da8)
    }
    ["newproxy"] => function(function: builtin#29)
    ["next"] => function(function: builtin#4)
    ["pairs"] => function(function: builtin#5)
    ["pcall"] => function(function: builtin#21)
    ["print"] => function(function: builtin#30)
    ["rawequal"] => function(function: builtin#14)
    ["rawget"] => function(function: builtin#12)
    ["rawlen"] => function(function: builtin#15)
    ["rawset"] => function(function: builtin#13)
    ["select"] => function(function: builtin#17)
    ["setfenv"] => function(function: builtin#11)
    ["setmetatable"] => function(function: builtin#9)
    ["string"] => table(14) {
        ["byte"] => function(function: builtin#79)
        ["char"] => function(function: builtin#80)
        ["dump"] => function(function: builtin#86)
        ["find"] => function(function: builtin#87)
        ["format"] => function(function: builtin#92)
        ["gmatch"] => function(function: builtin#90)
        ["gsub"] => function(function: builtin#91)
        ["len"] => function(function: 0x4a9f4ab8)
        ["lower"] => function(function: builtin#84)
        ["match"] => function(function: builtin#88)
        ["rep"] => function(function: builtin#82)
        ["reverse"] => function(function: builtin#83)
        ["sub"] => function(function: builtin#81)
        ["upper"] => function(function: builtin#85)
    }
    ["table"] => table(18) {
        ["clear"] => function(function: builtin#102)
        ["clone"] => function(function: 0x4a9f51a8)
        ["concat"] => function(function: builtin#95)
        ["foreach"] => function(function: 0x4a9f4060)
        ["foreachi"] => function(function: 0x4a9f3f48)
        ["getn"] => function(function: 0x4a9f4138)
        ["getsize"] => function(function: 0x4a9f5208)
        ["insert"] => function(function: builtin#94)
        ["isempty"] => function(function: builtin#98)
        ["maxn"] => function(function: builtin#93)
        ["move"] => function(function: 0x4a9f44a8)
        ["new"] => function(function: builtin#101)
        ["nkeys"] => function(function: builtin#97)
        ["pack"] => function(function: builtin#100)
        ["remove"] => function(function: 0x4a9f4350)
        ["sclone"] => function(function: builtin#96)
        ["sort"] => function(function: builtin#99)
        ["unpack"] => function(function: builtin#16)
    }
    ["tonumber"] => function(function: builtin#18)
    ["tostring"] => function(function: builtin#19)
    ["type"] => function(function: builtin#3)
    ["unpack"] => function(function: builtin#16)
    ["xpcall"] => function(function: builtin#22)
}
 ]]





--------------------------------------------------------------------------------
------------------------------- Lua API Release --------------------------------
--------------------------------------------------------------------------------

-- Удалены следующие функции:
-- https://alfa-ao.github.io/allods-lua-api-docs/#18.0.0-spellLib._DurationBuff
--var_dump( "#18.0.0-spellLib._DurationBuff", spellLib.HasDurationBuff, spellLib.GetDurationBuff )

--------------------------------------------------------------------------------

-- Индексация возвращаемой таблицы становится валидным 0 => 1
-- https://alfa-ao.github.io/allods-lua-api-docs/#17.0.0-options.Get...Ids
--var_dump( "#17.0.0-options.Get...Ids", options.GetPageIds() )

--------------------------------------------------------------------------------

-- Вместо функции: options.SetOptionCurrentIndex.
-- Разделены по типу на булевые / все остальные. Можно передать 3 аргумент true для мгновенного применения.
-- https://alfa-ao.github.io/allods-lua-api-docs/#17.0.0-options.SetOptionCurrentIndex
--var_dump( "#17.0.0-options.SetOptionCurrentIndex", options.SetOptionCurrentIndex, options.SetOptionEnabled, options.SetOptionIndex )

--------------------------------------------------------------------------------

-- Новые API
-- https://alfa-ao.github.io/allods-lua-api-docs/#17.0.0-options.IsOptionEnabled
--var_dump( "#17.0.0-options.IsOptionEnabled", options.IsOptionEnabled )

--------------------------------------------------------------------------------

-- Тип UniqueId меняется с userdata на number (int64) во всех связанных API. Соответственно все методы UniqueId исчезают.
-- https://alfa-ao.github.io/allods-lua-api-docs/#17.0.0-UniqueId
--var_dump( "#17.0.0-UniqueId", avatar.GetUniqueId() )

--------------------------------------------------------------------------------

-- Аддоны использующие кастомные стили должны будут явно их загрузить. 
-- Появится специальная API: common.LoadCustomCss( id ) - загружает набор стилей аддона с заданным id.
-- https://alfa-ao.github.io/allods-lua-api-docs/#17.0.0-WidgetCss
--var_dump( "#17.0.0-WidgetCss", common.LoadCustomCss )

--------------------------------------------------------------------------------

-- Функция DEPRECATED. Аналог common.SendUserModsEvent
-- https://alfa-ao.github.io/allods-lua-api-docs/#16.0.0-userMods.SendEvent
--var_dump( "#16.0.0-userMods.SendEvent", userMods.SendEvent )

--------------------------------------------------------------------------------
