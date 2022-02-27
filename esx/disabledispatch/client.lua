Citizen.CreateThread(function()
	for i = 0, 20 do
		Citizen.InvokeNative(0xDC0F817884CDD856, i, false)
	end
end)