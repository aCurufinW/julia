using HorizonSideRobots

function mark_perimeter_with_barriers!(r)
    for side in 0:3
        counters = move_through_barrier!(r, side)
        putmarker!(r)
        return_to_start!(r, counters, side)
    end       
end


function move_through_barrier!(r, side)
    counters = []
    while (length(counters)==0 || counters[length(counters)]!=0)
        count1 = 0
        count2 = 0
        count3 = 0
        while !isborder(r, HorizonSide(side))
            move!(r, HorizonSide(side))
            count1+=1
        end
        while (isborder(r, HorizonSide(side)) && !isborder(r, HorizonSide((side+1)%4)))
            move!(r, HorizonSide((side+1)%4))
            count2 += 1
        end
        if !isborder(r, HorizonSide(side))
            move!(r, HorizonSide(side))
            count3 += 1
            while isborder(r, HorizonSide((side+3)%4))
                move!(r, HorizonSide(side))
                count3 += 1
            end
            for i in 1:count2
                move!(r, HorizonSide((side+3)%4))
            end
        else 
            for i in 1:count2
                move!(r, HorizonSide((side+3)%4))
            end
            count2 = 0
        end
        if count2 == 0
            for i in [(side+1)%4, (side+3)%4]
                new_count = 0
                while !isborder(r, HorizonSide(i))
                    move!(r, HorizonSide(i))
                    putmarker!(r)
                    new_count+=1
                end
                for j in 0:new_count-1
                    move!(r, HorizonSide((i+2)%4))
                end
                putmarker!(r)
            end
        end
        push!(counters,count1)
        push!(counters,count2)
        push!(counters,count3)
        push!(counters,count2)
    end
    return counters   
end


function move_forward!(r, side, count)
    for i in 0:count-1
        move!(r, HorizonSide(side))
    end
end


function return_to_start!(r, counters, side)
    counters = reverse(counters)
    for i in 1:length(counters)
        rside = side
        if i%2 == 1
            rside = (rside+i)%4
        else
            rside = (rside+2)%4
        end
        move_forward!(r, rside, counters[i])
    end
end

mark_perimeter_with_barriers!(r)