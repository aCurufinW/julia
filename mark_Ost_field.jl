using HorizonSideRobots


function mark_Ost_field(r::Robot)
    count_S = counter(r, 2)
    count_W = counter(r, 1)
    putmarker!(r)
    count_O = mark_and_count!(r, 3)
    move!(r, HorizonSide(0))
    move_forward_one_time!(r, 1)
    side = 1
    while count_O!=2                 # для квадратного поля - не 2, а 1
        for i in 1:count_O-1
            move_forward_one_time!(r, side)
        end
        move!(r, HorizonSide(0))
        if side==3
            move!(r, HorizonSide(1))
        end
        putmarker!(r)
        side = (side+2)%4
        count_O-=1
    end
    move_forward_one_time!(r, 3)     # для квадратного поля - эти
    move_forward_one_time!(r, 1)     # две строки удаляются
    return_to_start!(r, count_W, count_S)
end

function move_forward_one_time!(r::Robot, side)
    move!(r, HorizonSide(side))
    putmarker!(r)
end


function mark_and_count!(r::Robot, side)
    counter = 0
    while !isborder(r,HorizonSide(side))
        move!(r, HorizonSide(side))
        putmarker!(r)
        counter+=1
    end
    return counter
end

function return_to_start!(r::Robot, count_W::Int,count_S::Int)
    while !isborder(r,HorizonSide(2))
        move!(r, HorizonSide(2))
    end
    for i in 1:count_W
        move!(r, HorizonSide(3))
    end
    for j in 1:count_S
        move!(r, HorizonSide(0))
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



mark_Ost_field(r)