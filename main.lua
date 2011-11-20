speed = 2
move_x = 0
font = love.graphics.newFont("font/gtw.ttf", 30)
love.graphics.setFont(font)

function love.draw()
  for i = 0,8 do
		love.graphics.draw(road, 0, 132 * (i-1) + bg_scroll)
	end
	for i,v in ipairs(et) do
  		love.graphics.draw(oil, v.x, v.y)
	end
	love.graphics.draw(truck,truck_x, truck_y,0,1,1,20)
	love.graphics.print("speed:"..math.floor(speed^2),0,0)
end

x,y = 0,0
bg_dt = 0
bg_scroll = 0
truck_x = 400
truck_y = 700
speed_dt = 0
e_dt = 0
et = {}

function love.update(dt)
  bg_dt = bg_dt + dt
	speed_dt = speed_dt + dt
	e_dt = e_dt + dt
	if speed_dt > 1 then
		speed_dt = 0
		speed = speed + (14/300)
	end
	if bg_dt > 0.01*(1/speed) then
    bg_dt = 0
    bg_scroll = (bg_scroll+speed^2)%132
    for i,v in ipairs(et) do
      v.y = (v.y+speed^2)
    end
  end
	if e_dt > .5 then
		e_dt = 0
		local x = math.random(163,639)
		local e = {}
		e.x = x
		e.y = -45
		table.insert(et,e)
	end
	chex()	
	truck_x = truck_x + move_x
end

function love.load()
	truck = love.graphics.newImage("imgs/Truck.png")
	oil = love.graphics.newImage("imgs/OIL.png")	
	road = love.graphics.newImage("imgs/road.png")
end

function love.keypressed(key)

	if key == "a" then
    move_x = -4
	end  
	
	if key == "d" then
    move_x = 4
	end	

end

function love.keyreleased(key)

	if key == "a" then
    move_x = 0
	end  
	
	if key == "d" then
    move_x = 0
	end	

end

function dist(a,b)
	return math.sqrt((truck_x - b.x)^2 + (700 - b.y)^2)
end

function chex()
	for i,v in ipairs(et) do
		if dist(p,v) < 35 then
			speed = speed * .99
		end
	end
end
