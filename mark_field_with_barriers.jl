using HorizonSideRobots

function mark_field_with_barriers!(r)
    counters = move_to_corner!(r)
    height = move_and_count!(r)
    move_to_last_corner!(r, height)
    move_to_corner!(r)
    return_to_start!(r, counters)
end


function move_and_count!(r)
    c = 0
    while !isborder(r, Sud)
        putmarker!(r)
        move!(r, Sud)
        c+=1
    end
    putmarker!(r)
    return c
end


function move_to_last_corner!(r, height)
    direction = 0
    move!(r, Ost)
    while true
        i = 0
        while i!=height
            if (isborder(r, Nord) && isborder(r, Ost)) # конец
                return 0
            end
            if !isborder(r,HorizonSide(direction))    # маркируем свободные клетки до границы
                putmarker!(r)
                move!(r, HorizonSide(direction))
                i+=1
            else
                putmarker!(r)
                if i!=height-1
                    i+=move_through_barrier!(r, direction)
                end
                while !isborder(r, HorizonSide(direction))
                    move!(r, HorizonSide(direction))
                    putmarker!(r)
                    i+=1
                end
                if i == height-1
                    putmarker!(r)
                    i+=1
                end
            end
        end
        putmarker!(r)
        direction = (direction+2)%4
        if !isborder(r, Ost)
            move!(r, Ost)
        end
    end
end

function move_through_barrier!(r, side)
    counter = 0
    counter1 = 0
    while isborder(r, HorizonSide(side))
        move!(r, Ost)
        counter+=1
    end
    move!(r, HorizonSide(side))
    while isborder(r, West)
        move!(r, HorizonSide(side))
        counter1 += 1
    end
    for i in 0:counter-1
        move!(r, West)
    end
    putmarker!(r)
    return(counter1)
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
 

mark_field_with_barriers!(r)
