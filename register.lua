local S = kiosk.intllib
local F = minetest.formspec_escape

xpfw.register_attribute("kiosk_account",{min=0,max=math.huge,default=0,
	hud=1,})

unified_inventory.register_button("kiosk", {
	type = "image",
	image = "kiosk_button_128.png",
	tooltip = S("Kiosk")
})

local sell = minetest.create_detached_inventory("sell", {
	on_put = function(inv, listname, index, stack, player)
--		inv:set_stack(listname, index, nil)
		local item_stack=inv:get_stack(listname,index)
		if item_stack == nil then return end
		local item_name=item_stack:get_name()
		if item_name == nil then return end
		local item_count=item_stack:get_count()
		if item_count <1 then return end
		local player_name = player:get_player_name()
--		minetest.sound_play("trash", {to_player=player_name, gain = 1.0})
	end,
})
sell:set_size("main", 1)
local buy = minetest.create_detached_inventory("buy", {
	on_put = function(inv, listname, index, stack, player)
--		inv:set_stack(listname, index, nil)
		local player_name = player:get_player_name()
--		minetest.sound_play("trash", {to_player=player_name, gain = 1.0})
	end,
})
buy:set_size("main", 1)


unified_inventory.register_page("kiosk", {
	get_formspec = function(player, perplayer_formspec)
		local fy = perplayer_formspec.formspec_y
		local name = player:get_player_name()
		local formspec = "label[0,0;"..F(S("Kiosk")).."]"..
			"list[detached:sell;main;1,1;1,1;]"..
			"list[detached:buy;main;1,2;1,1;]"..
			"button[3,1;2,1;button_sell;"..S("Sell").."]"..
			"button[3,2;2,1;button_buy;"..S("Buy").."]"..
			"label[5.0,"..(fy + 0.0)..";"..F(S("Buy at")).."]"..
			"label[5.0,"..(fy + 0.5)..";"..F(S("Sell at")).."]"..
			"listring[current_player;main]"..
			"listring[detached:"..name.."_kiosk;kiosk]"
		return {formspec=formspec}
	end,
})

minetest.after(0.01,function()
	print("size")
	print(dump2(VoxelArea:getExtent()))
	for i,def in pairs(minetest.registered_nodes) do
		local nodeinfo=minetest.find_nodes_in_area({x=(-10),y=(-10),z=(-10)},{x=(10),y=(10),z=(10)},i)
		if #nodeinfo>0 then
			print(i..": "..#nodeinfo)
		end
	end
end)

