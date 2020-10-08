function [w1, w2] = DecodeChromosome(chromosome, NH)
    w1 = zeros(NH, 4);
    w2 = zeros(2, NH+1);
    for i = 1:NH*4
        w1(i) = chromosome(i);
    end
    for j = 1:2*(NH+1)
        i = NH*4+j;
        w2(j) = chromosome(i);
    end
end

