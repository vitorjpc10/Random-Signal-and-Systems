function Problem394(m)
sum = 0; 

    for i = 1:m
        if i < 400
            cost(i) = i * .15;
        elseif i == 400
            cost(i) = i * .10;
        elseif i < 500
            cost(i) = i * .30;
        else
            cost(i) = 0;
        end
        
    sum = sum + cost(i);
    
    end
    
sum    
average_cost = sum/m
end

% As M becomes larger both the sum and the average cost increases
% accordingly. 
