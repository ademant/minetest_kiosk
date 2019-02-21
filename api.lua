
kiosk.inventar={}

kiosk.add_inventar=function(name,buy_value,sell_value,stock)
	if name == nil then
		return
	end
	if buy_value == nil then
		buy_value=1
	end
	if buy_value == 0 then
		buy_value=1
	end
	if sell_value == nil then
		sell_value=kiosk.sell_factor * buy_value
	end
	if sell_value > buy_value then
		sell_value=kiosk.sell_factor * buy_value
	end
	if stock == nil then
		stock = 0
	end
	
	if kiosk.inventar[name] == nil then
		kiosk.inventar[name] = {name = name,
			sell = sell_value,
			buy = sell_value,
			stock=stock,
			}
	else
		local kiosk_inv=kiosk.inventar[name]
		kiosk_inv.sell=sell_value
		kiosk_inv.buy=buy_value
	end
end

kiosk.get_value=function(name,value)
	if name == nil then return end
	if kiosk.inventar[name] == nil then
		kiosk.add_inventar(name,1,0.9,0)
	end
	local kinv=kiosk.inventar[name]
	local output = 0
	if kinv[value] ~= nil then
		output = kinv[value]
	end
	return output
end

kiosk.get_buy=function(name)
	return kiosk.get_value(name,"buy")
end

kiosk.get_sell=function(name)
	return kiosk.get_value(name,"sell")
end

kiosk.get_stock=function(name)
	return kiosk.get_value(name,"stock")
end
