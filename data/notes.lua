--freem
local function tablefind(t, sFind)
	for _, v in pairs(t) do
		if v == sFind then
			return _
		end
	end
	return nil
end


function BuildNotes()
	--local stepfile = "songs/Kocchi Muite Baby/Kocchi Muite Baby.ssc"

	lines = {}
	notes = {}
	local measure = 1;

	for line in love.filesystem.lines(step) do
		line = string.gsub(line,"\n","");
		line = string.gsub(line,"\r","");
		table.insert(lines, line)
	end

	--
	local index = tablefind(lines, "#NOTES:")
	for i=1,index do 
		table.remove(lines,1);
	end;

	for k=1,#lines do
		if  string.find(lines[k],";") == nil and string.find(lines[k],",") == nil and string.find(lines[k],"measure") == nil then
			if not notes[measure] then notes[measure] = {} end;
			table.insert(notes[measure],lines[k]);
		else
			measure = measure+1;
		end
	end;
end
