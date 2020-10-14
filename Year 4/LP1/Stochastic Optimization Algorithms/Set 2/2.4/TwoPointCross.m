function [newChromosome1, newChromosome2] = TwoPointCross(chromosome1,chromosome2)
chromosome1length = length(chromosome1);
chromosome2length = length(chromosome2);

chromosome1point1 = randi([0,chromosome1length/4])*4;
chromosome1point2 = randi([0,chromosome1length/4])*4;
chromosome1points = sort([chromosome1point1, chromosome1point2]);
chromosome1point1 = chromosome1points(1);
chromosome1point2 = chromosome1points(2);

chromosome2point1 = randi([0,chromosome2length/4])*4;
chromosome2point2 = randi([0,chromosome2length/4])*4;
chromosome2points = sort([chromosome2point1, chromosome2point2]);
chromosome2point1 = chromosome2points(1);
chromosome2point2 = chromosome2points(2);


% The below if-statements are unreadable. However, they were needed, as I
% wanted both crossover-points to be 0, i.e. for them to be before the 
% chromosome. The if-statements can be understood by first looking at the
% cases where neither of the crossover points are 0. Then, if a crossover
% point is 0, we remove the part that would generate an error. For example,
% to get from the first if-statement to the second one, we remove the part
% 'chromosome2(chromosome2point1+1:chromosome2point2)', as it would
% generate an error with chromosome2point2 == 0.
if chromosome1point1 ~= 0 && chromosome2point2 ~= 0
    newChromosome1 = [chromosome1(1:chromosome1point1); ...
        chromosome2(chromosome2point1+1:chromosome2point2); ...
        chromosome1(chromosome1point2+1:end)];
    
elseif chromosome1point1 ~= 0 && chromosome2point2 == 0
    newChromosome1 = [chromosome1(1:chromosome1point1); ...
            chromosome1(chromosome1point2+1:end)];
        
elseif chromosome1point1 == 0 && chromosome2point2 ~= 0
    newChromosome1 = [chromosome2(chromosome2point1+1:chromosome2point2); ...
            chromosome1(chromosome1point2+1:end)];

elseif chromosome1point1 == 0 && chromosome2point2 == 0
    newChromosome1 = [chromosome1(chromosome1point2+1:end)];
end

% Now, time for the second chromosome.

if chromosome2point1 ~= 0 && chromosome1point2 ~= 0
    newChromosome2 = [chromosome2(1:chromosome2point1); ...
        chromosome1(chromosome1point1+1:chromosome1point2); ...
        chromosome2(chromosome2point2+1:end)];
    
elseif chromosome2point1 ~= 0 && chromosome1point2 == 0
    newChromosome2 = [chromosome2(1:chromosome2point1); ...
        chromosome2(chromosome2point2+1:end)];
    
elseif chromosome2point1 == 0 && chromosome1point2 ~= 0
    newChromosome2 = [chromosome1(chromosome1point1+1:chromosome1point2); ...
        chromosome2(chromosome2point2+1:end)];
    
elseif chromosome2point1 == 0 && chromosome1point2 == 0
    newChromosome2 = [chromosome2(chromosome2point2+1:end)];
end

end