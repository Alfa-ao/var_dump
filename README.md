# var_dump

Script
```lua
local relatedText = common.GetAddonRelatedTextGroup( "template", true )

local color = 0xAA0000FF

local dump = var_dump( relatedText, { r = 1, g = 0, b = 0, a = 0.2 }, color )
common.LogInfo( "common", dump )
```

---

mods.txt
```
userdata(RelatedTextsLua) = {
    GetList = table(2) {
        [1] => string(11) "RECIPE_LINE"
        [2] => string(17) "COLOR_YELLOW_TEXT"
    }
}
----------------------
table(0) {
    ["a"] => number(0.2)
    ["b"] => number(0)
    ["g"] => number(0)
    ["r"] => number(1)
}
----------------------
number(2852126975)
```
