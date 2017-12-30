function [movement, probability] = HistogramFunction(x0, v0, Abins, Aprobability, inPoints, inProbability)
%Multiply array1 by each element of array1

n=1;
numPts = length(Abins); %Calculate length of acceleration pdf vector
lenSq = numPts*numPts; %when we've multiplied everything, the vector will be 
                        %the squared length of the acceleration vector

%initialize with appropriate sizes 
movement = zeros(1, lenSq);
probability = zeros(1, lenSq);

if inPoints==0
    movement = zeros(1, numPts);
end

for i=1:numPts
    %multiply the whole array1 by the current element of array1 (i)
    for j = 1:length(inPoints)
        if inPoints == 0 %If this is the first round 
            movement(1,n) = x0 + v0 + 0.5*[Abins(i)];
            movement(2,n) = v0 + [Abins(i)];
            probability = Aprobability;
        else
            movement(1,n) = inPoints(1, j) + inPoints(2, j) + 0.5*[Abins(i)];
            movement(2,n) = inPoints(2, j) + [Abins(i)];
            %Multiply elementwise the probabilities
            probability(n) = [inProbability(i) * inProbability(j)];
        end  
        n=n+1; 
    end
end
n=0;

end

