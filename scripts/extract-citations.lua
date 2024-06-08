-- Purpose: Extract citation keys from a .bib file and use them to determine
-- whether to use \cite or \ref in the output.
local bibfile = "references.bib" -- Your bib file

function log(msg)
	quarto.log.output(msg)
end

local function anyTrue(t)
	for _, v in pairs(t) do
		if v == true then
			return true
		end
	end

	return false
end

log("running extract-citations")

-- Function to extract citation keys from a .bib file
function extractCitationKeys(bibfile)
	local citationKeys = {}
	for line in io.lines(bibfile) do
		local key = line:match("@%w+{([^,]+),")
		if key then
			citationKeys[key] = true
		end
	end
	return citationKeys
end

local citationKeys = extractCitationKeys(bibfile)

-- log(table.concat(citationKeys, ", "))

-- Function to process Cite elements
return {
	Cite = function(el)
		if quarto.doc.is_format("pdf") then
			local cites = el.citations:map(function(cite)
				return cite.id
			end)
			local modes = el.citations:map(function(cite)
				return cite.mode
			end)
			-- check whether all of them are in the bib file
			local pass = cites:map(function(cite)
				local out = citationKeys[cite] == true
				return out
			end)

			local any_cite = anyTrue(pass)

			-- log(any_cite)
			-- log(cites)

			local citesStr = ""

			if any_cite then
				if modes[1] == "AuthorInText" then
					citesStr = "\\cite{" .. table.concat(cites, ", ") .. "}"
				elseif modes[1] == "SuppressAuthor" then
					citesStr = "\\citeyear{" .. table.concat(cites, ", ") .. "}"
				else
					citesStr = "\\citep{" .. table.concat(cites, ", ") .. "}"
				end
			else
				citesStr = "\\ref{" .. table.concat(cites, ", ") .. "}"
			end

			return pandoc.RawInline("latex", citesStr)
		end
	end,
}
