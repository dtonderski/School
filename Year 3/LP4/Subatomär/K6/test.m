for i = [1:4]
    for j = [1:4]
        disp([i,j])
        disp(sum(sum(A(i:i+2,j:j+2))))
    end
end
