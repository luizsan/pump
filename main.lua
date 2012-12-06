require("data/constants");
require("data/songs");
require("data/gameplay");

require("sys/util");

playing = false;

delta = 0;
fps = 0;
uptime = -1000;

beat = -1000

speed = 3;
tap = 0;

measure = 0;

function love.load()
	
	allsongs = LoadSongs();
	reset();
	
end;


function reset()
	
	
	
	songlist = {
		{	name = "songs/Accept Bloody Fate/Accept Bloody Fate.mp3",
			bpm = 190,
			offset =0.480,
		},
		{	name = "songs/Alte Burg/Alte Burg.ogg",
			bpm = 180,
			offset =-0.060,
		},
		{	name = "songs/Hades The Bloody Rage/Hades The Bloody Rage.ogg",
			bpm = 190,
			offset =-1.580,
		},
	};	
	
	song = math.random(1,#songlist);

		music = love.audio.newSource(songlist[song].name)
		bpm = songlist[song].bpm;
		offset = songlist[song].offset;
	
	bps = 60/bpm;

end;




function love.update(dt)
	
	delta = dt;
	fps = love.timer.getFPS();
	
	
	
	--if math.ceil(uptime-offset) == 0 then  end;
	if playing == false and uptime >= 0 then uptime = 0; music:play() music:seek(0,"seconds"); playing = true end;
	
	
	
	if uptime > -1000 and not music:isPaused() then
		uptime = uptime+dt
		uptime = math.ceil(uptime*100000)/100000
	end;
	
	
	stream = music:tell("seconds")
	
	
	
	
	
end


function love.keypressed(key) 
   
   if key == " " then
		uptime = 0+offset;
		music:stop();
		reset()
		playing = false
   end
   
   
   if key == "kp5" then
		--tap = ((60/bpm)*4)-(uptime+offset)
		--tap = math.ceil(tap*10000)/10000
		--if tap > 0 then tap = "+"..tap; end;
		if music:isPaused() then music:play(); else music:pause(); end;
		
   end
   
end




function love.draw()
	
	DrawNotefield();
	
	local debugger = {
		"delta: "..delta,
		"fps: "..fps,
		"bps: "..(math.ceil((bps)*10000)/10000),
		"\n",
		"uptime "..math.ceil(uptime*1000)/1000,
		"stream: "..math.ceil(stream*1000)/1000,
	};
	
	local info = {
		songlist[song].name,
		songlist[song].bpm,
		songlist[song].offset,
	};
	
	
	love.graphics.setColor(255,255,255,255)
	love.graphics.print(table.concat(debugger,"\n"),10,10)
	love.graphics.printf(table.concat(info,"\n"),SCREEN_RIGHT-310, 10, 300, "right");
	
end;