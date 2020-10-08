function xStar = RunGradientDescent(startingPoint, mu, stepLength, threshold)

    currentPoint = startingPoint;
    while true
        gradient = ComputeGradient(currentPoint(1), currentPoint(2), mu);
        if(norm(gradient) < threshold)
            xStar = currentPoint;
            return
        end
        currentPoint = currentPoint - gradient*stepLength;
    end
end