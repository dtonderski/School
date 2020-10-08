STARTING_POINT = [1;2];
STEP_LENGTH = 0.0001;
THRESHOLD = 1e-6;
MU_SEQUENCE = [1,10,100,1000];

currentPoint = STARTING_POINT;
tic

for mu = MU_SEQUENCE
    xStar = RunGradientDescent(currentPoint,mu,STEP_LENGTH,THRESHOLD);
    disp(xStar)
    disp(mu)
end

toc
