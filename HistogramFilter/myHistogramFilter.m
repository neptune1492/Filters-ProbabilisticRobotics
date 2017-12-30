function [] = myHistogramFilter()
%-----------------------------
% Establish the time vector
T = 0.01;
N = 1000000;
t = (0:N-1)*T;

%-----
%Set up histogram parameters:
samples = 3;
bins = -samples:.5:samples;

%-----------------
%Initialize starting points
x0=0; 
v0=0;

%-----------------------------
% Generate the accelerations - Monte Carlo
Avar = 1;  Amean = 0;

Astdv = sqrt(Avar);
At = Astdv*randn(1,N) + Amean;
At = At - mean(At) + Amean;


Ahist0 = hist(At,bins);
Ahist0 = Ahist0/sum(Ahist0);
figure(2); plot(bins,Ahist0,'.-'); title('Acceleration Distribution');

%---------------------------
%Timestep 1
%start, x0, v0, Abins, Aprobability, inPoints, inProbability
[movement1, probability1] = HistogramFunction(x0,v0, bins, Ahist0, 0, 0);
figure(3); title('Pose Distribution');
subplot(5,1,1);
plot(movement1(1,:), probability1);
xlabel('Location (timestep 1)'); ylabel('Probability');


%Timestep2
[movement2, probability2] = HistogramFunction(x0,v0,bins, Ahist0, movement1, probability1);
figure(3);
subplot(5,1,2);
plot(movement2(1,:), probability2);
xlabel('Location (timestep 2)'); ylabel('Probability');


%Timestep3
[movement3, probability3] = HistogramFunction(x0,v0,bins, Ahist0,movement2, probability2);
figure(3);
subplot(5,1,3);
plot(movement3(1,:), probability3);
xlabel('Location (timestep 3)'); ylabel('Probability');


%Timestep4
[movement4, probability4] = HistogramFunction(x0,v0,bins, Ahist0,movement3, probability3);
figure(3);
subplot(5,1,4);
plot(movement4(1,:), probability4);
xlabel('Location (timestep 4)'); ylabel('Probability');


%Timestep5
[movement5, probability5] = HistogramFunction(x0,v0,bins, Ahist0,movement4, probability4);
figure(3);
subplot(5,1,5);
plot(movement5(1,:), probability5);
xlabel('Location (timestep 5)'); ylabel('Probability');

%---------------------
%Plot velocities:
figure(4);
subplot(5,1,1);
plot(movement1(2,:), probability1);
xlabel('Velocity (timestep 1)'); ylabel('Probability');


subplot(5,1,2);
plot(movement2(2,:), probability2);
xlabel('Velocity (timestep 2)'); ylabel('Probability');


subplot(5,1,3);
plot(movement3(2,:), probability3);
xlabel('Velocity (timestep 3)'); ylabel('Probability');

subplot(5,1,4);
plot(movement4(2,:), probability4);
xlabel('Velocity (timestep 4)'); ylabel('Probability');

subplot(5,1,5);
plot(movement5(2,:), probability5);
xlabel('Velocity (timestep 5)'); ylabel('Probability');

%-----------------
%MEASUREMENT PDF:
zbins= -10:2.5:20;
Zvar = 10;  Zmean = 5;

Zstdv = sqrt(Zvar);
Zt = Zstdv*randn(1,N) + Zmean;
Zt = Zt - mean(Zt) + Zmean;


Zhist0 = hist(Zt,zbins);
Zhist0 = Zhist0/sum(Zhist0);
figure(5); plot(zbins,Zhist0,'.-'); title('Distribution'); xlabel('Location'); ylabel('Probability');

%--------------------------------------
%Add measurement
[movement6, probability6] = HistogramFunction(x0,v0,zbins, Zhist0,movement1, probability1);
figure(6);
subplot(2,1,1);
plot(movement1(1,:), probability1);
xlabel('Location (timestep 1)'); ylabel('Probability');

subplot(2,1,2);
plot(movement6(1,:), probability6);
xlabel('Location After Update(timestep 1)'); ylabel('Probability');
end




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


