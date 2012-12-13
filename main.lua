require("data/constants");
require("data/songs");
require("data/gameplay");
--
require("sys/util");

Content = {};
Content.Fonts = {};

Game = {
	debug	= false,
	playing	= false,
	delta	= 0,
	fps		= 0,
	uptime	= -1000,
	beat	= -1000
};

Player = {
	Speed	= 1,
	Tap = 0,
	Measure = 0
};

Songs = nil

debug = true;
playing = false;
delta = 0;
fps = 0;
uptime = -1000;
beat = -1000
speed = 3;
tap = 0;
measure = 0;


function love.load()
	Songs = LoadSongs();
	Content.Fonts["Mono"] = love.graphics.newFont("fonts/DejaVuSansMono.ttf", 11);
	love.graphics.setFont( Content.Fonts["Mono"] );
	ResetGame();
end;

function ResetGame()
	
	songlist = {
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
		{	name = "Unique",
			extension = ".mp3",
			bpm = 145,
			offset = -0.700,
		},
		{	name = "Sudden Death R99",
			extension = ".mp3",
			bpm = 190,
			offset = 1.040,
		},
		{	name = "Crossing Field",
			extension = ".ogg",
			bpm = 179,
			offset = 0.015,
		},
		{	name = "Alice in Black Market",
			extension = ".mp3",
			bpm = 176,
			offset = 0.460,
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

	if playing == false then 
	
		if offset > 0 and uptime >= offset then
			music:play() 
			music:seek(0,"seconds");
			playing = true 
		elseif offset < 0 and uptime >= 0 then
			music:play() 
			music:seek(offset*-1,"seconds");
			playing = true 
		end;
		
	end;
	
	
	if uptime > -1000 and not music:isPaused() then uptime = uptime+dt end;
	
	stream = music:tell("seconds")

end

function love.keypressed(key) 
	-- quit
	if key == "escape" then
		love.event.push('quit');
	end
	-- reset / reroll song
	if key == " " then
		uptime = -1;
		music:stop();
		ResetGame()
		playing = false
	end
	-- debug
	if key == "`" then
		debug = not debug;
	end 
	-- Speed Down 
	if key == "kp7" and speed > 1/8 then
		speed = speed - 1/8
	end
	-- Speed Up
	if key == "kp8" then
		speed = speed + 1/8;
	end
	-- Speed Reset
	if key == "kp9" then
		speed = 1;
	end
	-- Pause
	if key == "kp5" then
		if music:isPaused() then music:play(); else music:pause(); end;
	end
end

function love.draw()
	if notes then 
		DrawNotefield();
	end
	if debug then
		local Stats = {
			Delta		= delta,
			FPS			= fps,
			BPS			= (math.ceil((bps)*10000)/10000),
			uptime		= math.ceil(uptime*1000)/1000,
			Stream		= math.ceil(stream*1000)/1000,
			Elapsed		= elapsed,
			SongName	= songlist[song].name,
			SongBPM		= songlist[song].bpm,
			SongOffset	= songlist[song].offset,
			Beat			= beat,
		};
		
		love.graphics.setColor(255,255,255,192)
		love.graphics.printf(string.format(
			"Delta___: %03.04f\n" ..
			"FPS_____: %03i\n" ..
			"BPS_____: %03.04f\n" ..
			"Uptime__: %03.04f\n" ..
			"Stream__: %03.04f\n" ..
			"Elapsed_: %03.04f\n" ..
			"Beat____: %03i\n" ..
			"------------------\n" ..
			"NAME____: %s\n"      ..
			"BPM_____: %03.04f\n" ..
			"OFFSET__: %03.04f\n" ..
			"------------------\n" ..
			"SPEED___: %03.04f",
			Stats.Delta, Stats.FPS, Stats.BPS, Stats.uptime, Stats.Stream, Stats.Elapsed, Stats.Beat, Stats.SongName, Stats.SongBPM, Stats.SongOffset, speed),
			SCREEN_LEFT+12, 12, 300, "left");
	end
end;
