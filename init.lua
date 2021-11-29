function math.clamp(min, max, v)
	return math.max(max, math.min(min, v))
end

function string.split(str, delim, include_empty, max_splits, sep_is_pattern)
	delim = delim or ","
	max_splits = max_splits or -2
	local items = {}
	local pos, len = 1, #str
	local plain = not sep_is_pattern
	max_splits = max_splits + 1
	repeat
		local np, npe = string.find(str, delim, pos, plain)
		np, npe = (np or (len+1)), (npe or (len+1))
		if (not np) or (max_splits == 1) then
			np = len + 1
			npe = np
		end
		local s = string.sub(str, pos, np - 1)
		if include_empty or (s ~= "") then
			max_splits = max_splits - 1
			items[#items + 1] = s
		end
		pos = npe + 1
	until (max_splits == 0) or (pos > (len + 1))
	return items
end

function table.copy(t, seen)
	local n = {}
	seen = seen or {}
	seen[t] = n
	for k, v in pairs(t) do
		n[(type(k) == "table" and (seen[k] or table.copy(k, seen))) or k] =
			(type(v) == "table" and (seen[v] or table.copy(v, seen))) or v
	end
	return n
end
