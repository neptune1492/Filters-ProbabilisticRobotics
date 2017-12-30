%-------------------------------------------------------------
% Created: 12/13/14 by Elizabeth Brennan
%
% Revision History: None
%
% Purpose: This function performs the Kalman Filter process
%
% Variables: 
%   T       - time step duration
%   x       - current state matrix
%   P       - state knowledge matrix
%   z       - measurement matrix from IR and AC sensors
%   u       - acceleration input
%   y       - output matrix of updated state
%   
% function [x P y] = myKF( T, x, P, z, u )

function [ x P y ] = myKF( T, x, P, z, u )

persistent A B H R Q C D I

if (nargin == 1)
    %Initialize
    x = [0; 0]; %Define initial distance at 0, and initial velocity at 0 
    y = [0; 0];
    I = eye(2); %Identity matrix, 2x2 because there are 2 state variables
    A = [1 T; 0 1]; %Matrix for splitting out 2 state variables
    B = [T; T]; %Examples use [T 1]. [T; T] produces better results.
   
    
    H = [1 0]; %Used with current state matrix to compare against measured value
    C = [1 0; 0 1]; %Used in output equation
    D = [0; 0];%Used in Output equation; Prevents output from being affected by acceleration
    
    Q = [0.000001 0; 0 0]; %Process error variance; Determined through experimentation 
    R = [0.16 0; 0 0]; %Measurement error variance; Determined by taking weighted avg of initial variances of sensors
    
    P = [99999 0; 0 0]; %Initial state covariance; Perfect knowledge of distance (99999), no knowledge of velocity (0)
    
    return;

elseif (nargin > 5) %Check for error
    x = []; P = []; y = [];
    return;
    
else %Normal operation of Kalman Filter
    
    %After dist = 3, Q and R need to be tweaked for performance
    if (x(1,1) > 3)        
        Q = [0.0001 0; 0 0]; %Adjust Q to rely a little bit more on the measurements
        R=[0.3 0; 0 0]; %Determined by weighted average
    end
    
    %Prediction
    x = A*x + B*u;
    P = A*P*A' + [1 0]*Q*[1;0]; %Updating P, converting Q to scalar
    
    if (isempty(z) ~= 1) %Continue with innovation and update model
        %innovation equations
        
        %Combine the sensors results, in a weighted average. Weights 
        %determined by considering the average variance of each sensor
        %through a side-study
        z = [0.7 0.3]*z; 
        
        e = z - H*x; %Compare the sensor's measure to predicted
        s = H*P*H' + [1 0]*R*[1;0]; %Add state variance to state matrix
    
        %Update equations
        K = P*H'/s;
        x = x + K*e;
        P = (I - K*H)*P;
    
    end
    
    %Output
    y = C*x + D*u;
    
end

end

