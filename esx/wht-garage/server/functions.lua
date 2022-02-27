UpdateGarage = function(vehicleProps, newGarage)
	local sqlQuery = [[
		UPDATE
			owned_vehicles
		SET
			garage = @garage, vehicle = @newVehicle
		WHERE
			plate = @plate
	]]

	exports.ghmattimysql:execute(sqlQuery, {
		["@plate"] = vehicleProps["plate"],
		["@garage"] = newGarage,
		["@newVehicle"] = json.encode(vehicleProps)
	}, function(rowsChanged)	
	end)
end