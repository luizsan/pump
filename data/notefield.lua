function DrawNotefield()

	--receptor+((60/bpm)*(beat)*100)-((uptime+offset)*100)
	
	love.graphics.setColor(30,200,255,255)
	love.graphics.line(SCREEN_CENTER_X-140,receptor,SCREEN_CENTER_X+140,receptor);
	
	
	
	
	for i=0,350 do

				local beatseconds = ((i)*(bps))
				local remaining = beatseconds-(stream+offset);
				
				ypos = (remaining)*bps*(arrowspacing*4)


		if ypos > SCREEN_TOP-receptor and ypos < SCREEN_BOTTOM then
			
			if math.ceil(i/4) == (i/4) then 
				love.graphics.setColor(255,255,255,255);
			else
				love.graphics.setColor(100,200,255,75);
			end;
			
			
			love.graphics.print(math.ceil(remaining*1000)/1000,SCREEN_CENTER_X-100,receptor+ypos+2)
			love.graphics.line(SCREEN_CENTER_X-100,receptor+ypos,SCREEN_CENTER_X+100,receptor+ypos);
		

			
		end;

		if math.floor(ypos) == 0 then clap:rewind(); end;
	
	end

end;