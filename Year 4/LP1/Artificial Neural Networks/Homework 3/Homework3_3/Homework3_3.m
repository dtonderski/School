%% Initialization
clear;
%% Patterns
patterns = [[-1;-1;-1;-1;-1;-1;-1;-1;-1], ...
            [ 1;-1;-1; 1;-1;-1; 1;-1;-1], ...
            [-1; 1;-1;-1; 1;-1;-1; 1;-1], ...
            [-1;-1; 1;-1;-1; 1;-1;-1; 1], ...
            [ 1; 1;-1; 1; 1;-1; 1; 1;-1], ...
            [-1; 1; 1;-1; 1; 1;-1; 1; 1], ...
            [ 1;-1; 1; 1;-1; 1; 1;-1; 1], ...
            [ 1; 1; 1; 1; 1; 1; 1; 1; 1], ...
            [ 1; 1; 1;-1;-1;-1;-1;-1;-1], ...
            [-1;-1;-1; 1; 1; 1;-1;-1;-1], ...
            [-1;-1;-1;-1;-1;-1; 1; 1; 1], ...
            [ 1; 1; 1; 1; 1; 1;-1;-1;-1], ...
            [-1;-1;-1; 1; 1; 1; 1; 1; 1], ...
            [ 1; 1; 1;-1;-1;-1; 1; 1; 1]];
        
possiblePatterns = zeros(9,512);
for i = 1:512
    possiblePatterns(:,i) = DecimalToState(i);
end

patternsDecimal = zeros(1, 14);
for i = 1:14
    patternsDecimal(i) = StateToDecimal(patterns(:,i));
end
%% Parameters
M = 16; % Hidden Neurons
N = 9;  % Input
weightMatrix                =   -1+2*rand(M,N);
thetaV                      =   -1+2*rand(1,N);
thetaH                      =   -1+2*rand(M,1);
max_epochs                  =   1000;
p                           =   14;
beta                        =   1;
iterationLength             =   100;
eta                         =   0.01;
divergenceArray             =   zeros(1, max_epochs);
repeatsPerPattern           =   2;
verboseGlobal               =   0;
%% Training
for iEpoch = 1:max_epochs
    disp(iEpoch)
    verbose = 0;
    if(verbose && mod(iEpoch, 100) == 0)
        fprintf('Epoch is %d.', epoch);
    end
    deltaWeight = zeros([size(weightMatrix), 14]);
    deltaThetaV = zeros([size(thetaV), 14]);
    deltaThetaH = zeros([size(thetaH), 14]);
    for mu = 1:14
        pattern = patterns(:,mu);
        v = pattern;
        for t = 1:iterationLength
            v = RunIteration(v, weightMatrix, beta, thetaV, thetaH);
        end
        deltaWeight(:,:,mu)  =  eta*(tanh(weightMatrix*pattern - thetaH)*pattern' - tanh(weightMatrix*v - thetaH)*v');
        deltaThetaV (:,:,mu) = -eta*(pattern - v);
        deltaThetaH (:,:,mu) = -eta*(tanh(weightMatrix*pattern - thetaH) - tanh(weightMatrix*v - thetaH));
    end
    weightMatrix = weightMatrix + sum(deltaWeight,3);
    thetaV       = thetaV +       sum(deltaThetaV,3);
    thetaH       = thetaH +       sum(deltaThetaH,3);

    divergenceArray(iEpoch) = GetKullbackLeiblerDivergence(weightMatrix, ...
        repeatsPerPattern, possiblePatterns, ...
        patternsDecimal, beta, thetaV, thetaH);
end

%% Plotting
clf
figure(1)
plot(divergenceArray);

%%
figure(2)
clf
middleAndRightColumnIndices = [2 3 5 6 8 9];

for iPattern = 0:13
    v = patterns(:,iPattern+1);
    v(middleAndRightColumnIndices) = 0;
    for iteration = 1:10
        subplot(14,10,iPattern*10+iteration);
        PlotPattern(v);
        v = RunIteration(v, weightMatrix, beta, thetaV, thetaH);
    end
end
%% Functions
function divergence = GetKullbackLeiblerDivergence(weightMatrix, ...
    repeatsPerPattern, possiblePatterns, ...
    patternsDecimal, beta, thetaV, thetaH)
    
    frequency = zeros(512, 1);
    for t = 1:512*repeatsPerPattern
        v = possiblePatterns(:,ceil(t/repeatsPerPattern));
        for i = 1:10
            v = RunIteration(v, weightMatrix, beta, thetaV, thetaH);
        end
        decimalRepresentation = StateToDecimal(v);
        frequency(decimalRepresentation) = frequency(decimalRepresentation) + 1;
    end

    frequencySum = 512*repeatsPerPattern;
    PB = frequency/frequencySum;
    PData = 1/14;
    divergence = 0;
    for mu = 1:14
        patternIndex = patternsDecimal(mu);
        divergence = divergence+PData*log(PData/PB(patternIndex));
    end
end

function v = RunIteration(v, weightMatrix, beta, thetaV, thetaH)
    b_h = (weightMatrix*v) - thetaH;
    h   = GetNextNeuronState(b_h,beta);
    b_v = (h*weightMatrix) - thetaV;
    v   = GetNextNeuronState(b_v, beta);
end


function number = StateToDecimal(state)
    state(state==-1) = 0;
    number = 1;
    for j = 1:9
        number = number + state(j)*2^(9-j);
    end
end

function state = DecimalToState(number)
    number = number-1;
    state = zeros(9, 1);
    for j = 1:9           
        state(10-j) = mod(number,2);
        number = floor(number/2);
    end
    state(state == 0) = -1;
end

function s = GetNextNeuronState(b, beta)
    b = b';
    p = 1./(1+exp(-2*b*beta));
    s = zeros(size(b));
    for i = 1:length(p)
        r = rand;
        if r > p(i)
            s(i) = 1;
        else
            s(i) = -1;
        end
    end
end

function PlotPattern(pattern)
    image = reshape(pattern, 3, 3)';
    for x = 1:3
        for y = 1:3
            if image(y,x) == 1
                rectangle('Position', [x-1, 3-y, 1, 1], 'FaceColor',[0 0 0]);
            elseif image(y,x) == 0
                rectangle('Position', [x-1, 3-y, 1, 1], 'FaceColor',[0.7 0.7 0.7]);
            elseif image(y,x) == -1
                rectangle('Position', [x-1, 3-y, 1, 1], 'FaceColor',[1 1 1]);
            end
            rectangle('Position', [x-1, 3-y, 1, 1], 'EdgeColor', [0.5 0.5 0.5]);
        end
    end
    xlim([0 3])
    ylim([0 3])
end
