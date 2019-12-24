%% Ball Balancing Beam
clear; clc;
format compact
%%
% Code Written By: Erik Alvarado
% Still working on. 
% Class: Control Systems MECA 482
%
% Due Date: 12/13/2019
%% Initialize Variables
g =-9.81;   % Gravity [m/s^2]
m =0.0027;  % Mass of Ball [kg]
R =0.02;    % Radius of Ball [m]
d =0.05;    % Servo Arm Length [m]
L =.4;      % Length of Beam [m]
J =6.3e-7;  % Ball Moment of Intertia [kg*m^2]
            % x = Ball Position
            % alpha = Beam Angle
            % theta = Servo Angle
%% Simulink
open_system('SimulinkBallBallancingBeam')
set_param('SimulinkBallBallancingBeam', 'SimulationCommand','start')
%{
[A,B,C,D] = linmod('SimulinkBallBallancingBeam');
[num,den] = ss2tf(A,B,C,D)
sys=tf(num,den)
%damp(sys);
step(num,den)
%%

Kp = 2.5 %10;
Ki = 0 %10;
Kd = 1 %30;
C = pid(Kp,Ki,Kd);
sys_cl=feedback(C*sys,1); % This could be arduino feedback?
step(0.20*sys_cl) % Target
%}
%% Implement Arduino
% Starter % Not Stand Alone
%{ 
a = arduino('COM5','Mega2560','Libraries',{'Servo','Ultrasonic'}); % Initialize Arduino & Include Libraries
s = servo(a,'D9'); % Create Servo
se = ultrasonic(a,'D7','D6'); % Create Sensor

current_pos = readPosition(s) % Read Servo Angle

val = readDistance(se)./10;
sprintf('Current distance is %.4f cm', val) % Read Sensor Distance

% Rotate servo
for angle = .1:0.1:.58
    writePosition(s, angle);
    current_pos = readPosition(s);
    current_pos = current_pos*180;
    fprintf('Current motor position is %d degrees\n', current_pos);
    
    val = readDistance(se)./10;
    fprintf('Current distance is %.4f cm\n\n', val)
    
    pause(2);
end
%}




