function Code(code)
	local language = nil
	if code.classes[1] == nil then
		language = "text"
	else
		language = code.classes[1]
	end
	local minted_env = "\\mintinline{" .. language .. "}{" .. code.text .. "}"
	return pandoc.RawInline("latex", minted_env)
end
