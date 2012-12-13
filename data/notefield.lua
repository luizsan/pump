local columnspacing = 48;
local numcolumns = 5;

local notequad = love.graphics.newQuad( 0, 0, 64, 64, 384, 64 );

function DrawNotefield()
	--draw "receptor"
	love.graphics.setColor(30,200,255,255)
	love.graphics.line(SCREEN_CENTER_X-140,receptor,SCREEN_CENTER_X+140,receptor);

	
	beat = math.ceil((stream)/bps*1000)/1000;
	elapsed = math.ceil((beat)/4);
	
	local visible = math.ceil(128/speed*bps)+16;
	local negative = -32
	
	--visible beats
	for k=0,visible do
		DrawBeat(negative+k*4+(elapsed*4));
		DrawHolds(negative+k*4+(elapsed*4));
		DrawTaps(negative+k*4+(elapsed*4));
	end
	
end;

function DrawBeat(index)

	--number of beats. 0 = white; 1, 2, 3 = blue;
	for i=0,3 do
		local quarter = math.ceil(i/4) == (i/4);
		local beatseconds = ((i+index)*(bps))
		local remaining = beatseconds-(uptime);
		local measure = math.ceil((i+index)/4);
		local curbeat = math.ceil(i+index)
		
		local ypos = (remaining)*(bpm/60)*(arrowspacing*0.875*speed)
		if ypos > SCREEN_TOP-receptor-drawdistance and ypos < SCREEN_BOTTOM+drawdistance then
			if quarter then 
				love.graphics.setColor(255,255,255,255); 
				--love.graphics.print(math.ceil(remaining*1000)/1000,SCREEN_CENTER_X-100,receptor+ypos+2)
			else 
				love.graphics.setColor(100,200,255,255); 
			end;
			
			--love.graphics.print(string.format("%i [%i]", curbeat, index),SCREEN_CENTER_X-100,receptor+ypos+2)
			love.graphics.print(index/4,SCREEN_CENTER_X-100,receptor+ypos+2)
			love.graphics.line(SCREEN_CENTER_X-100,receptor+ypos,SCREEN_CENTER_X+100,receptor+ypos);
		end;
	--end of for	
	end;
	
	local bar = (index/4)+1
	if notes[bar] then --if measure exists
	
		for n=1,#notes[bar] do --gets note rows inside of measure (string table)
		
			for c=1,numcolumns do --draw columns
				local notetype = tonumber(string.sub(notes[bar][n],c,c))
				if notetype ~= 0 then
					DrawNote(index+((n-1)/(#notes[bar])*4),notetype,c);
				end;
			end;
			
		end;
	end;
	
	
--end of function
end;


function DrawNote(beat,button,column,split)	
	if button == 0 then return end; 

	local beat = tonumber(beat);
	local addition = 0;
	
	if column > 5 then column = column-5 end;
	local notecolumn = 0;
	
	if column == 1 then notecolumn = columnspacing*-2;
	elseif column == 2 then notecolumn = columnspacing*-1;
	elseif column == 3 then notecolumn = 0;
	elseif column == 4 then notecolumn = columnspacing*1;
	elseif column == 5 then notecolumn = columnspacing*2;
	end;
	
	local beatseconds = ((beat)*(bps))
	local remaining = beatseconds-(uptime);
	local ypos = (remaining)*(bpm/60)*(arrowspacing*0.875*speed)+32;
	
	if column == 1 or column == 5 then addition = -4 elseif column == 2 or column == 4 then addition = 4 else addition = 0 end;
	love.graphics.setColor(255,255,255,255); 
	
	--time to draw!
	if column~=0 and ypos > SCREEN_TOP-receptor-drawdistance and ypos < SCREEN_BOTTOM+drawdistance then
		
		
		--tapnote
		if button == 1 then 
			love.graphics.drawq(TAPNOTE[column], notequad, SCREEN_CENTER_X+notecolumn, ypos, 0, 1, 1, 32, 0);
		--hold head
		elseif button == 2 then
			love.graphics.drawq(HOLD[column], notequad, SCREEN_CENTER_X+notecolumn, ypos, 0, 1, 1, 32, -32-addition);
			love.graphics.drawq(TAPNOTE[column], notequad, SCREEN_CENTER_X+notecolumn, ypos, 0, 1, 1, 32, 0);
		elseif button == 4 then
		--hold body
		--	love.graphics.drawq(HOLD[column], notequad, SCREEN_CENTER_X+notecolumn, ypos, 0, 1, 0.1, 32, -32);
		elseif button == 3 then
		--hold tail
			love.graphics.drawq(TAIL[column], notequad, SCREEN_CENTER_X+notecolumn, ypos, 0, 1, 1, 32, 0);
		end;
	
	
	
	end;
	
end;
