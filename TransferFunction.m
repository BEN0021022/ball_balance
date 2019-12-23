

% mass of Ping Pong ball (kg)
m =  0.0027; 
%radius of ball (m)
R = 0.0201;  
% gravitational const. (m/s^2)
g = -9.81;
% Length of beam to pivot point (m)
L = 0.2; 
% lever arm offset
d = 0.05; 
% Moment of inertial of ball
J = 6.2e-7;

s = tf('s');

G_ball = -m*g*d/L/(J/R^2+m)/s^2