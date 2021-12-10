using HorizonSideRobots


function average_temp(r::Robot)
	n = 0
	temp = 0
	direction = 0
	while true
		while !isborder(r,HorizonSide(direction))
			move!(r, HorizonSide(direction))
			if ismarker(r)
				n+=1
				temp+=temperature(r)
			end
			if isborder(r, Sud) && isborder(r, Ost)
				println(temp/n)
				return temp/n
			end
		end
		direction = (direction+2)%4
		move!(r, Ost)
	end
end

average_temp(r)
