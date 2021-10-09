using HorizonSideRobots

function mark_chess(r)
    flag, count_W, count_S = move_to_corner!(r)
    side = 3
    while !isborder(r, Nord)
        mark_row!(r, flag, side)
        move!(r, Nord)
        if flag==0
            putmarker!(r)
        end
        side = (side+2)%4 
    end
    mark_row!(r, flag, side)
    return_to_start!(r, count_W, count_S)
end

function move_to_corner!(r::Robot)
    putmarker!(r)
    flag = 0
    count_W, flag = counter(r, West, flag)
    count_S, flag = counter(r, Sud, flag)
    return flag, count_W, count_S
end

function counter(r::Robot, side, flag)
    count = 0
    while !isborder(r, side)
        move!(r, side)
        if flag==1
            putmarker!(r)
        end
        flag = (flag+1)%2
        count+=1        
    end
    return count, flag 
end


function mark_row!(r, flag, side)
    while !isborder(r, HorizonSide(side))
        move!(r, HorizonSide(side))
        if flag==1
            putmarker!(r)
        end
        flag = (flag+1)%2
    end 
end


function return_to_start!(r::Robot, count_W::Int,count_S::Int)
    while !isborder(r,HorizonSide(1))
        move!(r, HorizonSide(1))
    end
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


mark_chess(r)