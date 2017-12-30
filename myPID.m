%-------------------------------------------------------------
% Created: 11/18/2014 By Kwadwo Gray, Elizabeth Brennan, Deanna Jacobson
% and Josh Beckwith

% Purpose: This function creates a transfer function that describes a PID
% discrete system. 
%
% Variables: 
%   a - a SINGLE sample of the input signal, it is NOT a full samples
%   vector
%   T - the sample time 
%   Kp - Parameter for 'a'
%   Ki - Parameter for the integral of 'a'
%   Kd - Parameter for the derivative of 'a'
%   b = the output function from the transfer function

% function b = myPID( ( Kp, Ki, Kd, T, a)
%-------------------------------------------------------------


function b = myPID( Kp, Ki, Kd, T, a)

persistent Istate a0;
if nargin == 0; 
    Istate =0;
    a0 = 0; 
    b = [];
    return
end

Istate = Istate + a;
b = Kp*a + Ki*(T*Istate) +Kd*((a -a0)/T);
a0 = a;
    

end

