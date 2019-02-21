-- base copied from 3d_armor_ui
-- support for i18n
kiosk = {}
kiosk.path = minetest.get_modpath("kiosk")
kiosk.config = minetest.get_mod_storage()
kiosk.modname=minetest.get_current_modname()
local S = dofile(kiosk.path .. "/intllib.lua")
kiosk.intllib = S
local F = minetest.formspec_escape

minetest.log("action", "[MOD]"..minetest.get_current_modname().." -- start loading from "..minetest.get_modpath(minetest.get_current_modname()))

-- import settingtypes.txt
basic_functions.import_settingtype(kiosk.path .. "/settingtypes.txt")

if not minetest.global_exists("unified_inventory") then
	minetest.log("warning", S("Kiosk: Mod loaded but unused."))
	return
end

dofile(kiosk.path .. "/config.lua")
dofile(kiosk.path .. "/api.lua")

if rawget(_G,"unified_inventory") then
	dofile(kiosk.path .. "/register.lua")
end

minetest.log("action", "[MOD]"..minetest.get_current_modname().." -- loaded ")

