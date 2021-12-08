using HorizonSideRobots

function endless_border(r)
    c = 1
    t = 1
    while true
        for j in 1:2
            for i in 1:c
                if isborder(r, Nord)
                    move!(r, HorizonSide(t))
                    if !isborder(r, Nord)
                        return 0
                    end
                end
            end
            t = (t+2)%4
            c+=1
        end
    end            
end


endless_border(r)