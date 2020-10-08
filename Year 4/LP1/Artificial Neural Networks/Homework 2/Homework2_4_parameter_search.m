clear;
trainingSet = load('training_set.csv')';
validationSet = load('validation_set.csv')';


for M1 = 1:10
    for M2 = 1:10
        for learningRate = [0.01, 0.02, 0.05, 0.1]
            W1 = randomWithinRange([M1, 2], -0.2, 0.2);
            T1 = zeros(M1, 1);
            W2 =  randomWithinRange([M2, M1], -0.2, 0.2);
            T2 = zeros(M2, 1);
            W3 = randomWithinRange([1, M2], -0.2, 0.2);
            T3 = 0;

            t = 0;
            % Save validation error values at 100 uniformly distributed points
            errorArray = zeros(1, 100);
            errorCounter = 1;
            [~,~,~,time1hours,time1min,time1sec] = datevec(now);
            [~,~,~,time2hours,time2min,time2sec] = datevec(now);
            while time2hours*3600 + time2min*60 + time2sec - time1hours...
                    *3600 - time1min*60 - time1sec <= 100
                patternNumber = randi([1 length(validationSet)]);
                input = trainingSet(1:2, patternNumber);
                target = trainingSet(3, patternNumber);
                V1 = g(-T1 + W1*input);
                V2 = g(-T2 + W2*V1);
                output = calculateOutput(input, W1, T1, W2, T2, W3, T3);
                delta3 = gPrime(-T3 + W3*V2)*(target-output);
                delta2 = gPrime(-T2 + W2*V1).*(W3'*delta3);
                delta1= gPrime(-T1 + W1*input).*(W2'*delta2);
                if(time2hours*3600 + time2min*60 + time2sec - time1hours...
                    *3600 - time1min*60 - time1sec > 95)
                    errorArray(errorCounter) = validationError(validationSet, ...
                        W1, T1, W2, T2, W3, T3);
                end
                W1 = W1 + learningRate*delta1*input';
                W2 = W2 + learningRate*delta2*V1';
                W3 = W3 + learningRate*delta3*V2';
                T1 = T1 - learningRate*delta1;
                T2 = T2 - learningRate*delta2;
                T3 = T3 - learningRate*delta3;
                [~,~,~,time2hours,time2min,time2sec] = datevec(now);
                t = t+1;
            end
            meanError = mean(errorArray);

            disp(['M1 = ', num2str(M1), ', M2 = ', num2str(M2), ...
                ' learningRate = ', num2str(learningRate), ...
                ', mean error = ', num2str(meanError), ...
                ', number of iterations = ', num2str(t), '.']);
        end
    end
end
             


%%
function error = validationError(validationSet, W1, T1, W2, T2, W3, T3)
    pVal = length(validationSet);
    errorSum = 0;
    for i = 1:pVal
        input = validationSet(1:2,i);
        output = calculateOutput(input, W1, T1, W2, T2, W3, T3);
        target = validationSet(3,i);
        errorSum = errorSum + abs(sign(output)-target);
    end
    error = errorSum./(2.*pVal);
end

function g = g(x)
    g = tanh(x);
end

function gPrime = gPrime(x)
    %Derivative of tanh is sech^2
    gPrime = 1-(tanh(x)).^2;
end

function output = calculateOutput(input, W1, T1, W2, T2, W3, T3)
    V1 = g(-T1 + W1*input);
    V2 = g(-T2 + W2*V1);
    output = g(-T3 + W3*V2);
end

function r = randomWithinRange(size, min, max)
    r = (max - min).*rand(size) + min;
end
