require("data/constants");
require("data/songs");
require("data/gameplay");

require("sys/util");

Fonts = {};

debug = true;
playing = false;
delta = 0;
fps = 0;
uptime = -1000;
beat = -1000
speed = 1;
tap = 0;
measure = 0;

function love.load()
	allsongs = LoadSongs();
	Fonts["Mono"] = love.graphics.newFont("fonts/DejaVuSansMono.ttf", 11);
	love.graphics.setFont( Fonts.Mono );
	reset();
end;

function reset()
	songlist = {
		{	name = "Accept Bloody Fate",
			extension = ".mp3",
			bpm = 190,
			offset = 0.480,
		},
		{	name = "Alte Burg",
			extension = ".ogg",
			bpm = 180,
			offset = -0.060,
		},
		{	name = "Hades The Bloody Rage",
			extension = ".ogg",
			bpm = 190,
			offset = -1.580,
		},
		{	name = "Kocchi Muite Baby",
			extension = ".mp3",
			bpm = 185,
			offset = -2.760,
		},
	};	
	
	song = math.random(1,#songlist);
	
	local str = "songs/"..songlist[song].name.."/"..songlist[song].name
	music = love.audio.newSource(str..songlist[song].extension);
	bpm = songlist[song].bpm;
	offset = songlist[song].offset;
	step = str..".ssc";
	
	bps = 60/bpm;
	
	BuildNotes()

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
	if key == "escape" then
	love.event.push('quit');
	end

	if key == " " then
		uptime = 0-offset;
		music:stop();
		reset()
		playing = false
	end

	if key == "`" then
		debug = not debug;
	end 

	if key == "kp7" then
		speed = speed - 1/8
	end

	if key == "kp8" then
		speed = speed + 1/8;
	end

	if key == "kp9" then
		speed = 1;
	end

	if key == "kp5" then
		--tap = ((60/bpm)*4)-(uptime+offset)
		--tap = math.ceil(tap*10000)/10000
		--if tap > 0 then tap = "+"..tap; end;
		if music:isPaused() then music:play(); else music:pause(); end;
	end
end

function love.draw()
	if notes then DrawNotefield(); end
	if debug then
		local debugger = {
			"delta: "..delta,
			"fps: "..fps,
			"bps: "..(math.ceil((bps)*10000)/10000),
			"\n",
			"uptime "..math.ceil(uptime*1000)/1000,
			"stream: "..math.ceil(stream*1000)/1000,
			"elapsed: "..elapsed,
		};
	
		local info = {
			songlist[song].name,
			songlist[song].bpm,
			songlist[song].offset,
		};
	
		love.graphics.setColor(255,255,255,192)
		--[[ 
		love.graphics.print(table.concat(debugger,"\n"),10,10)
		love.graphics.printf(table.concat(info,"\n"),SCREEN_RIGHT-310, 10, 300, "right");
		]]
		-- new ugly one
		love.graphics.printf(string.format(
			"Delta__: %03.04f\n" ..
			"FPS____: %03i\n" ..
			"BPS____: %03.04f\n" ..
			"Uptime_: %03.04f\n" ..
			"Stream_: %03.04f\n" ..
			"Elapsed: %03.04f\n" ..
			"------------------\n" ..
			"NAME___: %s\n"      ..
			"BPM____: %03.04f\n" ..
			"OFFSET_: %03.04f\n" ..
			"------------------\n" ..
			"SPEED__: %03.04f",
			delta, fps, (math.ceil((bps)*10000)/10000), math.ceil(uptime*1000)/1000, math.ceil(stream*1000)/1000, elapsed, info[1], info[2], info[3], speed),
			SCREEN_LEFT+16, 16, 300, "left");
	end
end;
