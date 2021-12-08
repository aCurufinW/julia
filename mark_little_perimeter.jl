using HorizonSideRobots

function mark_little_perimeter!(r)
    counters = move_to_corner!(r)
    height = move_and_count!(r)
    corner_side = move_to_perimeter!(r, height)
    mark_perimeter!(r, corner_side)
    move_to_corner!(r)
    return_to_start!(r, counters)
end


function move_and_count!(r)
    c = 0
    while !isborder(r, Sud)
        move!(r, Sud)
        c+=1
    end
    return c
end


function move_to_perimeter!(r, height)
    direction = 0
    move!(r, Ost)
    while true
        for i in 0:height
            if !isborder(r,HorizonSide(direction))
                move!(r, HorizonSide(direction))
            else
                if i!=height
                    return direction
                end
            end
        end
        direction = (direction+2)%4
        move!(r, Ost)
    end
end


function mark_perimeter!(r, move_by_side)
    putmarker!(r)
    while isborder(r, HorizonSide(move_by_side))
            move!(r, Ost)
        putmarker!(r)
    end
    move!(r, HorizonSide(move_by_side))
    putmarker!(r)
    while isborder(r, West)
        move!(r, HorizonSide(move_by_side))
        putmarker!(r)
    end
    move_by_side = (move_by_side+2)%4
    move!(r, West)
    putmarker!(r)
    while isborder(r,HorizonSide(move_by_side))
        move!(r, West)
        putmarker!(r)
    end
    move!(r, HorizonSide(move_by_side))
    putmarker!(r)
    while isborder(r,Ost)
        move!(r,HorizonSide(move_by_side))
        putmarker!(r)
    end
end


function move_to_corner!(r)           # идем в левый верхний угол
    counters = []
    while !(isborder(r,Nord) && isborder(r,West))
        counter_N = 0
        while !isborder(r,Nord)
            move!(r, Nord)
            counter_N+=1
        end
        pushfirst!(counters, counter_N)
        counter_W = 0
        while !isborder(r,West)
            move!(r, West)
            counter_W+=1
        end
        pushfirst!(counters, counter_W)
    end     
    return counters
end


function return_to_start!(r, counters)   # возвращаемся в начало
    println(size(counters))
    for i in 1:size(counters, 1)
        if i%2==0
            for j in 0:counters[i]-1
                move!(r, Sud)
            end

        end
        if i%2==1
            for j in 0:counters[i]-1
                move!(r, Ost)
            end
        end
    end
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
 

mark_little_perimeter!(r)