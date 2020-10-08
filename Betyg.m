TrePercent = [56.1 57.8 65.0 47.2 54.0 77.7 27.4 62.0 57.1 36.2 46.5 55.3 31.1 24.7 51.5];
avgTre = mean(TrePercent);

FyraPercent = [31.4 27.9 25.0 31.1 30.1 16.8 37.0 26.7 22.2 34.0 32.4 30.7 48.9 43.6 30.6];
avgFyra = mean(FyraPercent);

FemPercent = [12.4 14.3 10.0 21.7 15.9 5.6 35.6 11.2 20.7 29.8 21.1 14.0 20.0 31.7 18.0];
avgFem = mean(FemPercent);

avgMe = mean([4 5 5 4 4 4 5 3 4 3 4 3 4 3 3 4 4 4]);

n = size(TrePercent,2);
assert(n == size(FyraPercent,2));
assert(n == size(FemPercent,2));
combveccommand = 'A1';
for i =[1:n]
    eval(strcat('A', num2str(i), '=[3,4,5];'));
    if(i>1)
        combveccommand = strcat(combveccommand, ', ', 'A', num2str(i));
    end
end
eval(strcat('gradeCombinations = combvec(', combveccommand ,');'));
means = mean(gradeCombinations, 1);
%%
probabilityOfGradeCombinations = zeros(1,size(gradeCombinations,2));
for i = [1:size(gradeCombinations,2)]
    probability = 1;
    for j = [1:15]
        current = gradeCombinations(j,i);
        if(current==3)
            probability = probability*TrePercent(j)/100;
        elseif(current == 4)
            probability = probability*FyraPercent(j)/100;
        else
            probability = probability*FemPercent(j)/100;
        end
    end
    probabilityOfGradeCombinations(i) = probability;
end
%%
possibleMeans = [];
probabilityOfMean = [];
for i = [1:size(means,2)]
    if(ismember(means(i), possibleMeans))
        currentIndex = find(possibleMeans == means(i));
        probabilityOfMean(currentIndex) = probabilityOfMean(currentIndex) + probabilityOfGradeCombinations(i);
    else
        possibleMeans = [possibleMeans, means(i)];
        probabilityOfMean = [probabilityOfMean, probabilityOfGradeCombinations(i)];
    end
end
%%
bar(possibleMeans, probabilityOfMean)
%%
wantedMeanIndices = find(possibleMeans>=avgMe);
sum(probabilityOfMean(wantedMeanIndices))