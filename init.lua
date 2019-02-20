-- base copied from 3d_armor_ui
-- support for i18n
local S = armor_i18n.gettext
local F = minetest.formspec_escape

if not minetest.global_exists("unified_inventory") then
	minetest.log("warning", S("Kiosk: Mod loaded but unused."))
	return
end

if unified_inventory.sfinv_compat_layer then
	return
end

unified_inventory.register_button("kiosk", {
	type = "image",
	image = "kiosk_button_128.png",
	tooltip = S("Kiosk")
})

unified_inventory.register_page("kiosk", {
	get_formspec = function(player, perplayer_formspec)
		local fy = perplayer_formspec.formspec_y
		local name = player:get_player_name()
		if armor.def[name].init_time == 0 then
			return {formspec="label[0,0;"..F(S("Armor not initialized!")).."]"}
		end
		local formspec = "label[0,0;"..F(S("Kiosk")).."]"..
			"list[detached:"..name.."_kiosk;kiosk;0,"..fy..";1,2;]"..
			"label[5.0,"..(fy + 0.0)..";"..F(S("Buy at")).."]"..
			"label[5.0,"..(fy + 0.5)..";"..F(S("Sell at")).."]"..
			"listring[current_player;main]"..
			"listring[detached:"..name.."_kiosk;kiosk]"
		return {formspec=formspec}
	end,
})
