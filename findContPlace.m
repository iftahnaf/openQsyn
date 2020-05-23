function place = findContPlace(list, cont_num, cont_str)

str_4comp_gain = sprintf('#%d - gain',cont_num);
str_4comp_lead = sprintf('#%d - lead',cont_num);
str_4comp_lag = sprintf('#%d - lag',cont_num);
str_4comp_pid = sprintf('#%d - pid',cont_num);
str_4comp_notch = sprintf('#%d - notch',cont_num);
str_4comp_zero = sprintf('#%d - zero',cont_num);

counter = 0;

switch cont_str
    case str_4comp_gain
        for i = 1 : con_num
            if strcmp(list(i),str_4comp_gain)
                counter = counter +1;
            end
        end
        place = counter;
    case str_4comp_lead
        for i = 1 : con_num
            if strcmp(list(i),str_4comp_lead)
                counter = counter +1;
            end
        end
        place = counter;
    case str_4comp_lag
        for i = 1 : con_num
            if strcmp(list(i),str_4comp_lag)
                counter = counter +1;
            end
        end
        place = counter;
    case str_4comp_pid
        for i = 1 : con_num
            if strcmp(list(i),str_4comp_pid)
                counter = counter +1;
            end
        end
        place = counter;
    case str_4comp_notch
        for i = 1 : con_num
            if strcmp(list(i),str_4comp_notch)
                counter = counter +1;
            end
        end
        place = counter;
    case str_4comp_zero
        for i = 1 : con_num
            if strcmp(list(i),str_4comp_zero)
                counter = counter +1;
            end
        end
        place = counter;
end
end