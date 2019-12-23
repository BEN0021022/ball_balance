
%% Initialize editor, clear workspace.
%% Ball and beam simulink 

clc
clear all
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

P_ball = -m*g*d/L/(J/R^2+m)/s^2;

rlocus(P_ball)

sgrid(0.70, 1.9)

axis([-5 5 -2 2])

zo = 0.01;
po = 5;
C=tf([1 zo],[1 po]);

rlocus(C*P_ball)
sgrid(0.70, 1.9)

[k,poles]=rlocfind(C*P_ball)

sys_cl=feedback(k*C*P_ball,1);

t=0:0.01:5;
figure
step(0.25*sys_cl,t)

