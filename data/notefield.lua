local columnspacing = 48;
local numcolumns = 5;

function DrawNotefield()
	--draw "receptor"
	love.graphics.setColor(30,200,255,255)
	love.graphics.line(SCREEN_CENTER_X-140,receptor,SCREEN_CENTER_X+140,receptor);
	
	
	beat = math.ceil((uptime-offset)/bps*1000)/1000;
	elapsed = math.ceil((beat)/4);
	local visible = math.ceil(128/speed*bps);
	local negative = -32
	
	--visible beats
	for k=0,visible-1 do
		DrawBeat(negative+k*4+(elapsed*4))
	end
end;

function DrawBeat(index)
	--number of beats. 0 = white; 1, 2, 3 = blue;
	for i=0,3 do
		local quarter = math.ceil(i/4) == (i/4);
		local beatseconds = ((i+index)*(bps))
		local remaining = beatseconds-(uptime+offset);
		local measure = math.ceil((i+index)/4);
		local curbeat = math.ceil(i+index)
		
		local ypos = (remaining)*(bpm/60)*(arrowspacing*0.8*speed)
		if ypos > SCREEN_TOP-receptor-drawdistance and ypos < SCREEN_BOTTOM+drawdistance then
			if quarter then 
				love.graphics.setColor(255,255,255,255); 
				--love.graphics.print(math.ceil(remaining*1000)/1000,SCREEN_CENTER_X-100,receptor+ypos+2)
			else 
				love.graphics.setColor(100,200,255,255); 
			end;
			
			love.graphics.print(string.format("%i [%i]", curbeat, index),SCREEN_CENTER_X-100,receptor+ypos+2)
			love.graphics.line(SCREEN_CENTER_X-100,receptor+ypos,SCREEN_CENTER_X+100,receptor+ypos);
		end
	--end of for	
	end;
	
	local bar = (index/4)+2;

	--draw notes inside of measure
	if notes[bar] then --if measure exists
		for n=1,#notes[bar] do --gets note rows inside of measure (string table)
			for c=1,numcolumns do --draw columns
				if tonumber(string.sub(notes[bar][n],c,c)) ~= 0 then
					DrawNote(index+((n-1)/(#notes[bar])*4),1,c);
				end;
			end;
		end;
	end;
--end of function
end;


function DrawNote(beat,button,column)	
	if button == 0 then return end; 
	
	local notebutton;
	beat = tonumber(beat);
	
	if column > 5 then column = column-5 end;
	local notecolumn = 0;
	
	if column == 1 then notebutton = DL;  notecolumn = columnspacing*-2;
	elseif column == 2 then notebutton = UL; notecolumn = columnspacing*-1;
	elseif column == 3 then notebutton = C; notecolumn = 0;
	elseif column == 4 then notebutton = UR;  notecolumn = columnspacing*1;
	elseif column == 5 then notebutton = DR;  notecolumn = columnspacing*2;
	end;
	
	local beatseconds = ((beat)*(bps))
	local remaining = beatseconds-(uptime+offset);
	local ypos = (remaining)*(bpm/60)*(arrowspacing*0.8*speed);
	
	love.graphics.setColor(255,255,255,255); 
	
	if column~=0 and ypos > SCREEN_TOP-receptor-drawdistance and ypos < SCREEN_BOTTOM+drawdistance then
		notebutton:draw(SCREEN_CENTER_X+notecolumn-32,ypos+32);
	end;
end;
