using HorizonSideRobots


function mark_kross(r::Robot)
    for side in 0:3
        move_forward!(r, side)
        return_to_start!(r, change_side(side))
    end
    putmarker!(r)
end

function move_forward!(r::Robot, side)
    while !isborder(r,HorizonSide(side))
        move!(r, HorizonSide(side))
        putmarker!(r)
    end
end

function return_to_start!(r::Robot, side)
    while ismarker(r)
        move!(r, HorizonSide(side))
    end
end

function change_side(side)
    return mod(side+2, 4)
end

mark_kross(r)