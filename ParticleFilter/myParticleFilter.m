
%-----------------------------
% Establish the time vector
T = 0.01;
N = 1000000;
t = (0:N-1)*T;

%-------------------
%set up initial bins
max = 5; min = -5;
bins = min:0.1:max;


%-----------------------------
% Generate the acceleration pdf
Avar = 1;  Amean = 0;

Astdv = sqrt(Avar);
At = Astdv*randn(1,N) + Amean;
At = At - mean(At) + Amean;


Ahist = hist(At,bins);
Ahist = Ahist/sum(Ahist);
figure(2); plot(bins,Ahist,'.-');

%initialize variables
x = 0; v = 0;
d_update = [];
v_update = [];

%------------
%Take random samples
for j=1:1000
    %grab a new element at random
    r = datasample(1:length(Ahist),1);

    d_update = [d_update, x + v + 0.5*Ahist(r)];
    v_update = [v_update, v + Ahist(r)];
end

%--------------
%arrange from lowest to highest
d_updateSorted = sort(d_update);
v_updateSorted = sort(v_update);

%Plot?
figure(1); 
subplot(2,1,1);
plot(d_updateSorted, '.-');
xlabel('Location (timestep 1)'); 

subplot(2,1,2);
plot(v_updateSorted, '.-');
xlabel('Velocity (timestep 1)'); 

%---------------
%Timestep 2:


