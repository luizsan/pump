require("sys/animation");local tap_downleft = love.graphics.newImage("noteskins/fiesta/DownLeft Tap Note 6x1.png");local tap_downright = love.graphics.newImage("noteskins/fiesta/DownRight Tap Note 6x1.png");local tap_upleft = love.graphics.newImage("noteskins/fiesta/UpLeft Tap Note 6x1.png");local tap_upright = love.graphics.newImage("noteskins/fiesta/UpRight Tap Note 6x1.png");local tap_center = love.graphics.newImage("noteskins/fiesta/Center Tap Note 6x1.png");local hold_downleft = love.graphics.newImage("noteskins/fiesta/DownLeft Hold Body Active 6x1.png");local hold_downright = love.graphics.newImage("noteskins/fiesta/DownRight Hold Body Active 6x1.png");local hold_upleft = love.graphics.newImage("noteskins/fiesta/UpLeft Hold Body Active 6x1.png");local hold_upright = love.graphics.newImage("noteskins/fiesta/UpRight Hold Body Active 6x1.png");local hold_center = love.graphics.newImage("noteskins/fiesta/Center Hold Body Active 6x1.png");local tail_downleft = love.graphics.newImage("noteskins/fiesta/DownLeft Hold BottomCap Active 6x1.png");local tail_downright = love.graphics.newImage("noteskins/fiesta/DownRight Hold BottomCap Active 6x1.png");local tail_upleft = love.graphics.newImage("noteskins/fiesta/UpLeft Hold BottomCap Active 6x1.png");local tail_upright = love.graphics.newImage("noteskins/fiesta/UpRight Hold BottomCap Active 6x1.png");local tail_center = love.graphics.newImage("noteskins/fiesta/Center Hold BottomCap Active 6x1.png");TAPNOTE = {	tap_downleft,	tap_upleft,	tap_center,	tap_upright,	tap_downright,}HOLD = {	hold_downleft,	hold_upleft,	hold_center,	hold_upright,	hold_downright,}TAIL = {	tail_downleft,	tail_upleft,	tail_center,	tail_upright,	tail_downright,}--[[TAPNOTE = {	newAnimation(tap_downleft,64,64,0.05,0);	newAnimation(tap_upleft,64,64,0.05,0);	newAnimation(tap_center,64,64,0.05,0);	newAnimation(tap_upright,64,64,0.05,0);	newAnimation(tap_downright,64,64,0.05,0);}HOLD = {	newAnimation(hold_downleft,64,64,0.05,0);	newAnimation(hold_upleft,64,64,0.05,0);	newAnimation(hold_center,64,64,0.05,0);	newAnimation(hold_upright,64,64,0.05,0);	newAnimation(hold_downright,64,64,0.05,0);}TAIL = {	newAnimation(tail_downleft,64,64,0.05,0);	newAnimation(tail_upleft,64,64,0.05,0);	newAnimation(tail_center,64,64,0.05,0);	newAnimation(tail_upright,64,64,0.05,0);	newAnimation(tail_downright,64,64,0.05,0);}]]