function DrawNotefield()
	
	--draw "receptor"
	love.graphics.setColor(30,200,255,255)
	love.graphics.line(SCREEN_CENTER_X-140,receptor,SCREEN_CENTER_X+140,receptor);
	
	elapsed = math.ceil(beat/4);
	
	--local visible = 4;
	local visible = 32
	
	
	for k=0,visible-1 do
		DrawBeat(-16+k*4+(elapsed*4))
	end
		
end;	


function DrawBeat(index)

	--number of beats. 0 = white; 1, 2, 3 = blue;
	for i=0,3 do

			local quarter = math.ceil(i/4) == (i/4);
	
			local beatseconds = ((i+index)*(bps))
			local remaining = beatseconds-(stream+offset);
			
			ypos = (remaining)*bps*(arrowspacing*6)


			if ypos > SCREEN_TOP-receptor-drawdistance and ypos < SCREEN_BOTTOM+drawdistance then

				if quarter then 
					love.graphics.setColor(255,255,255,255); 
					love.graphics.print(math.ceil((i+index)/4),SCREEN_CENTER_X-100,receptor+ypos+2)
					--love.graphics.print(math.ceil(remaining*1000)/1000,SCREEN_CENTER_X-100,receptor+ypos+2)
				else 
					love.graphics.setColor(100,200,255,75); 
				end;
				
				love.graphics.line(SCREEN_CENTER_X-100,receptor+ypos,SCREEN_CENTER_X+100,receptor+ypos);
			end

	--end of for	
	end;
		
--end of function
end;