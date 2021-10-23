using HorizonSideRobots

function mark_chess_n!(r, n)
    count_W = counter(r, West)
    count_S = counter(r, Sud)
    i = 1
    j = 1
    side = 3
    while !isborder(r, Nord)
        j = mark_row!(r, i, j, n, side)
        side = (side+2)%4 
        move!(r, Nord)
        i+=1
    end
    mark_row!(r, i, j, n, side)
    return_to_start!(r, count_W, count_S)
end

function counter(r::Robot, side)
    count = 0
    while !isborder(r, side)
        move!(r, side)
        count+=1        
    end
    return count
end


function mark_row!(r, i, j, n, side)
    side == 3 ? flag = 1 : flag = -1
    while !isborder(r, HorizonSide(side))
        if div(i-1, n)%2==div(j-1, n)%2
            putmarker!(r)
        end
        move!(r, HorizonSide(side))
        j+=flag  
    end
    if (div(i-1, n)%2==div(j-1, n)%2) 
        putmarker!(r)
    end 
    return j
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


mark_chess_n!(r, n)