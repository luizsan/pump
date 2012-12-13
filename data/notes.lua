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

	lines = {};
	notes = {};
	insert = {};
	holdactive = {};
	digit = 0;
	
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

		
		--if legit notes
		if string.len(lines[k])==5 or string.len(lines[k])==10 then
		
			--if measure is empty, fill it with blank
			if notes[measure] == nil then notes[measure] = {} end;
			
			--check if holds and set holdactive/inactive
			for h=1,string.len(lines[k]) do 
				
				
				digit = string.sub(lines[k],h,h);	
				insert[h] = tostring(digit);
				if digit == "2" then holdactive[h] = true elseif digit == "1" or digit == "3" then holdactive[h] = false end;
				
				if insert[h] == "0" and holdactive[h] == true then insert[h] = "4" end;
			
			end;
			
			local row = (table.concat(insert));
			table.insert(notes[measure],row);
			
		--changing measure
		elseif string.find(lines[k],",") ~= nil then
			measure = measure+1;
		--end
		end
		
	end;
end
