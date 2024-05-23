pico-8 cartridge // http://www.pico-8.com
version 41
__lua__
-- tetris :)
#include main.lua
#include util.lua
#include palette.lua
#include grid.lua
#include ui.lua
#include player.lua
#include piece.lua
__gfx__
00000000222220000000000000000000001111100000011111000000000004444444444033333333330000003333333333000000444444444444444444440000
00000000211120000000000000000000001222100000015551000000000004333443334034443344430000003111331113000000422244222442224422240000
00700700211120000000000000000000001222100000015551000000000004333443334034443344430000003111331113000000422244222442224422240000
00077000211120000000000000000000001222100000015551000000000004333443334034443344430000003111331113000000422244222442224422240000
00077000222220000000000000000000001111100000011111000000000004444444444033333333330000003333333333000000444444444444444444440000
00700700222222222222222011111111111111101111111111111110444444444400000000000333333333303333333333000000000000000000000000000000
00000000211122111221112012221122211222101555115551155510433344333400000000000344433444303111331113000000000000000000000000000000
00000000211122111221112012221122211222101555115551155510433344333400000000000344433444303111331113000000000000000000000000000000
00000000211122111221112012221122211222101555115551155510433344333400000000000344433444303111331113000000000000000000000000000000
00000000222222222222222011111111111111101111111111111110444444444400000000000333333333303333333333000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000222220000000000011111000000000001111100000000000444440000000000033333000000000003333300000000000444440000000000000000000
00000000211120000000000012221000000000001555100000000000433340000000000034443000000000003111300000000000422240000000000000000000
00000000211120000000000012221000000000001555100000000000433340000000000034443000000000003111300000000000422240000000000000000000
00000000211120000000000012221000000000001555100000000000433340000000000034443000000000003111300000000000422240000000000000000000
00000000222220000000000011111000000000001111100000000000444440000000000033333000000000003333300000000000444440000000000000000000
__map__
0102030405060708090a0b000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1112131415161718191a1b000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000002b000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
