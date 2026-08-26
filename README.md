# var_dump

Более релизы не собираются, пока вся типизация не актуализируется до состояния `apitype`.

Script
```lua
local relatedText = common.GetAddonRelatedTextGroup( "template", true )

local color = 0xAA0000FF

var_dump( relatedText, { r = 1, g = 0, b = 0, a = 0.2 }, color )
var_dump( mainForm )
```

---

mods.txt
```
Debug info var_dump:
======================BEGIN======================
userdata(RelatedTextsLua) = {
    GetList = table(2) {
        [1] => string(11) "RECIPE_LINE"
        [2] => string(17) "COLOR_YELLOW_TEXT"
    }
}
----------------------
table(Color) {
    ["a"] => number(0.2)
    ["b"] => number(0)
    ["g"] => number(0)
    ["r"] => number(1)
}
----------------------
number(2852126975)
=======================END=======================

Info: Debug info var_dump:
======================BEGIN======================
userdata(WidgetForm) = {
    GetAddonType = ENUM_ADDON_TYPE_USER
    GetAddonName = string(24) "UserAddon/LibreAlchemyV2"
    GetDebugInfo = string(136) "[160300][WidgetForm]: (UserAddon/LibreAlchemyV2)->mainForm, Resource: Mods/Addons/LibreAlchemyV2/Widgets/LibreAlchemyV2.(WidgetForm).xdb"
    GetFade = number(1)
    GetId = number(160300)
    GetName = string(14) "LibreAlchemyV2"
    GetNamedChildren = table(1) {
        [1] => userdata(WidgetPanel) = { GetName = string(5) "Panel" }
    }
    GetPickChildrenOnly = boolean(true)
    GetPlacementPlain = table(10) {
        ["alignX"] => number(3)
        ["alignY"] => number(3)
        ["highPosX"] => number(0)
        ["highPosY"] => number(0)
        ["posX"] => number(0)
        ["posY"] => number(0)
        ["sizeX"] => number(0)
        ["sizeY"] => number(0)
        ["sizingX"] => number(0)
        ["sizingY"] => number(0)
    }
}
=======================END=======================
```
