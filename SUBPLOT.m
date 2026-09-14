clear all;
close all;
clc 
x=[0:0.001:2*pi];
y = sin(x);
 z=cos(x);

subplot(2,1,1)
plot(x, z);
legend( 'cos(x)');
hold on
subplot(2,1,2)
plot(x, y);
legend('sin(x)');
