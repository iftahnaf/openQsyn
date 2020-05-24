function place = findContPlace(list, cont_num, cont_str)

str_4comp_gain = sprintf('#%d - gain',cont_num);
str_4comp_lead = sprintf('#%d - lead',cont_num);
str_4comp_lag = sprintf('#%d - lag',cont_num);
str_4comp_pid = sprintf('#%d - pid',cont_num);
str_4comp_notch = sprintf('#%d - notch',cont_num);
str_4comp_zero = sprintf('#%d - zero',cont_num);

counter = 0;

switch cont_str{1}
    case str_4comp_gain
        for i = 1 : cont_num
            if strcmp(list(i),sprintf('#%d - gain',i))
                counter = counter +1;
            end
        end
    case str_4comp_lead
        for i = 1 : cont_num
            if strcmp(list(i),sprintf('#%d - lead',i))
                counter = counter +1;
            end
        end
    case str_4comp_lag
        for i = 1 : cont_num
            if strcmp(list(i),sprintf('#%d - lag',i))
                counter = counter +1;
            end
        end
    case str_4comp_pid
        for i = 1 : cont_num
            if strcmp(list(i),sprintf('#%d - pid',i))
                counter = counter +1;
            end
        end
    case str_4comp_notch
        for i = 1 : cont_num
            if strcmp(list(i),sprintf('#%d - notch',i))
                counter = counter +1;
            end
        end
    case str_4comp_zero
        for i = 1 : cont_num
            if strcmp(list(i),sprintf('#%d - zero',i))
                counter = counter +1;
            end
        end
end
place = counter;
fprintf('\nYou edited/deleted the %d controller of type: - %s controller ,the controller number is %d\n', place, cont_str{1}, cont_num)
end