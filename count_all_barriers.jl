using HorizonSideRobots

function count_all_barriers(r)
    counters = move_to_corner!(r)         # запомним исходное положение
    column_length = move_forward!(r, Sud)    # первый проход, спуск в нижний угол
    move!(r, Ost)
    count_barriers = move_by_snake!(r, column_length, 0)
    move_to_corner!(r)
    move_forward!(r, Sud)
    row_length = move_forward!(r, Ost)
    count_barriers += move_by_snake!(r, row_length, 1)
    return_to_start!(r, counters)
    return count_barriers
end



function move_by_snake!(r, counter, direction)            # двигаемся "змейкой"
    c = 0
    if direction==0
        side = 3
    else
        side = 0
    end
    while true 
        i = 0
        while i != counter                      # обходим все поле змейкой и ищем перегородки
            if !isborder(r, HorizonSide(direction))  
                move!(r, HorizonSide(direction))
                i += 1
            else                                # если встречается преграда - огибаем 
                i1 = i
                i += move_through_barrier!(r, direction)
                i+=1
                c+=1
                if side==0 && i1<i-1              # увеличиваем счетчик перегородок
                    c-=1
                end
            end
        end
        if !isborder(r,HorizonSide(side))
            move!(r, HorizonSide(side))
        else
            return c
        end
        direction = (direction+2)%4
    end    
end



function move_forward!(r, side)          # движение по прямой
    c = 0
    while !isborder(r, side)
        move!(r, side)
        c+=1
    end
    return c
end


function move_through_barrier!(r, side)   # огибаем преграду
    counter = 0
    counter1 = 0
    if side%2==0
        dir1 = Ost
        dir2 = West
    else
        dir1 = Nord
        dir2 = Sud
    end
    while isborder(r, HorizonSide(side))
        move!(r, dir1)
        counter+=1
    end
    move!(r, HorizonSide(side))
    while isborder(r, dir2)
        move!(r, HorizonSide(side))
        counter1 += 1
    end
    for i in 0:counter-1
        move!(r, dir2)
    end
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


function return_to_start!(r, counters)   # возвращаемся в исходное положение
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


count_all_barriers(r)