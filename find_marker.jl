using HorizonSideRobots


function find_marker(r::Robot)
	c = 0
	while true
		for i in 1:4
			if i%2==0 c+=1 end
			for j in 1:c
				move!(r, HorizonSideRobots(i))
				if ismarker(r)
					println(ismarker(r))
					return 0
				end
			end
		end
	end
end


find_marker(r)
