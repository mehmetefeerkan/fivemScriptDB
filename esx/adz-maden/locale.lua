Locales = {}

function _(str, ...)  -- Translate string

	if Locales[araf.Locale] ~= nil then

		if Locales[araf.Locale][str] ~= nil then
			return string.format(Locales[araf.Locale][str], ...)
		else
			return 'Translation [' .. araf.Locale .. '][' .. str .. '] does not exist'
		end

	else
		return 'Locale [' .. araf.Locale .. '] does not exist'
	end

end

function _U(str, ...) -- Translate string first char uppercase
	return tostring(_(str, ...):gsub("^%l", string.upper))
end
