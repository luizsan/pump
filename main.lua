require("data/constants");
require("data/notefield");

playing = false;
arrowspacing = 60

delta = 0;
fps = 0;
uptime = -1000;

beat = -1000
receptor = 0;

tap = 0;
elapsed = 0;
drawdistance = 100;

function love.load()

	tapnote = love.graphics.newImage("Center.png");

	clap = love.audio.newSource("clap.ogg","static")
	receptor = SCREEN_CENTER_Y-174;
	reset();
	
end;


function reset()
	
	
	
	songlist = {
		{	name = "Ascending Into Naught.mp3",
			bpm = 155,
			offset = 1.290,
		},
		{	name = "Alice in Black Market.mp3",
			bpm = 176,
			offset = 0.460,
		},
		{	name = "Dies irae.mp3",
			bpm = 180,
			offset = -0.080,
		},
		{	name = "Contract.ogg",
			bpm = 180,
			offset = -0.015,
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
	if playing == false then music:play() music:seek(0,"seconds"); playing = true end;
	
	
	
	if uptime > -1000 then
		uptime = uptime+dt
		uptime = math.ceil(uptime*100000)/100000
	end;
	
	
	stream = music:tell("seconds")
	
	
	beat = math.ceil((stream-offset)/bps*1000)/1000-1;
	
	
end


function love.keypressed(key) 
   
   if key == " " then
		uptime = 0-offset;
		music:stop();
		reset()
		playing = false
   end
   
   --[[
   if key == "kp5" then
		tap = ((60/bpm)*4)-(uptime+offset)
		tap = math.ceil(tap*10000)/10000
		if tap > 0 then tap = "+"..tap; end;
   end
   ]]
end




function love.draw()
	
	DrawNotefield();
	
	local debugger = {
		"delta: "..delta,
		"fps: "..fps,
		"bps: "..(math.ceil((bps)*10000)/10000),
		"\n",
		"stream: "..math.ceil(stream*1000)/1000,
		"current bar: "..math.ceil(beat/4),
		"elapsed "..elapsed,
	};
	
	local info = {
		songlist[song].name,
		songlist[song].bpm,
	};
	
	
	love.graphics.setColor(255,255,255,255)
	love.graphics.print(table.concat(debugger,"\n"),10,10)
	love.graphics.printf(table.concat(info,"\n"),SCREEN_RIGHT-310, 10, 300, "right");
	
end;