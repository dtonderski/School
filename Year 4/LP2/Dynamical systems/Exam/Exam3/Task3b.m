clf
x = cantor(21);
epsilon_array = zeros(1,10);
N_box_array = zeros(1,10);
for base = [2,3,4,5]
    for k = 1:10
        end_edges = [1:base^k]/base^k;
        boxes = zeros(size(end_edges));
        for i = 1:base^k
            end_edge = end_edges(i);
            start_edge = end_edge - 1/base^k;
            boxes(i) = binary_search(start_edge, end_edge, x);
        end
        epsilon_array(k) = base^-k;
        N_box_array(k) = sum(boxes);
    end

    loglog(epsilon_array, N_box_array, '-x')
    hold on
end

epsilon_array_new = logspace(log10(min(epsilon_array)), 0);

D0 = log(3)/log(4);
N_box_theory = epsilon_array_new.^(-D0);
loglog(epsilon_array_new, N_box_theory, 'black--')

D0 = -log((sqrt(5)-1)/2)/log(2);
N_box_theory = epsilon_array_new.^(-D0);
loglog(epsilon_array_new, N_box_theory, 'black')

function found = binary_search(lower_bound, upper_bound, data)
    n = length(data);
    L = 1;
    R = n;
    while true
        m = floor((L+R)/2);
        if L >= R
            if data(m) > lower_bound && data(m) < upper_bound
                found = true;
            else
                found = false;
            end
            return
        end
        
        if data(m) < lower_bound
            L = m+1;
        elseif data(m) > upper_bound
            R = m-1;
        else
            found = true;
            return
        end
    end
end


function x = cantor(n)

if n == 0
  x = [1/2];
else
  x = cantor(n-1);
  
  % calculate new points
  x = [x/4, x/2+1/2];
end
end