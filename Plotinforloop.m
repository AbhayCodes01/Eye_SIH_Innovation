clc
clear all 
close all 
 x(1)=0;
 y(1)=cos(x(1));
 h=0.01;
 for i=1:628
     x(i+1) = x(i) + h; 
    y(i+1) = cos(x(i+1));
 end
 plot(x, y);
xlabel('x values');
ylabel('cos(x)');
title('Cosine Function Plot');
grid on;
