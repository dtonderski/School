function [w1, w2] = DecodeChromosome(chromosome, numberOfHiddenNeurons)
    w1 = zeros(numberOfHiddenNeurons, 4);
    w2 = zeros(2, numberOfHiddenNeurons+1);
    for i = 1:numberOfHiddenNeurons*4
        w1(i) = chromosome(i);
    end
    for j = 1:2*(numberOfHiddenNeurons+1)
        i = numberOfHiddenNeurons*4+j;
        w2(j) = chromosome(i);
    end
end

