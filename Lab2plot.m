clear all 
close all;
clc
x=[0:0.001:2*pi];
y = sin(x);
plot(x, y);
xlabel('x (radians)');
ylabel('sin(x)');
title('Sine Function');
hold
y=0;
plot(x,z)

hold on;
 z=cos(x);
plot(x, z);
legend('sin(x)', 'cos(x)');
