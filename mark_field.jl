using HorizonSideRobots


function mark_field(r::Robot)
    count_N = counter(r, 0)
    count_W = counter(r, 1)
    putmarker!(r)
    arr = [2, 0]
    side = 0
    while !(isborder(r, HorizonSide(2)) && isborder(r, HorizonSide(3)))
        move_forward!(r, arr[side%2+1])
        side+=1
        move!(r, HorizonSide(3))
        putmarker!(r)
    end
    println(5)
    move_forward!(r, 0)
    move_forward!(r, 1)
    return_to_start!(r, count_W, count_N)
end

function move_forward!(r::Robot, side)
    while !isborder(r,HorizonSide(side))
        move!(r, HorizonSide(side))
        putmarker!(r)
    end
end

function return_to_start!(r::Robot, count_W::Int,count_N::Int)
    for i in 1:count_W
        move!(r, HorizonSide(3))
    end
    for j in 1:count_N
        move!(r, HorizonSide(2))
    end
end

function counter(r::Robot, side)
    count = 0
    while !isborder(r, HorizonSide(side))
        move!(r, HorizonSide(side))
        count+=1        
    end
    return count
end



mark_field(r)