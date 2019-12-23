

P_ball = -m*g*d/L/(J/R^2+m)/s^2;

Kp = 4.12;
Ki = 0.2;
Kd = 3.5;
C = pid(Kp,Ki,Kd);
sys_cl=feedback(C*P_ball,1);

t=0:0.01:5;
step(0.25*sys_cl)