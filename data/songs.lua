function LoadSongs()
	local songs = {}
	local dirs = love.filesystem.enumerate(love.filesystem.getWorkingDirectory())
	
	for k, songfolder in ipairs(dirs) do
		if love.filesystem.isDirectory(songfolder) then
			songs[#songs+1] = songfolder;
		end;
	end

	return songs;
end;
