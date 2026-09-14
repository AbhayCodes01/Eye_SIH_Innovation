clc 
clear all 
close all 

% let us assume a=-1 b=2
a = -1; 
b = 2; 

f = @(x) x^3 - x - 1;

f(a)*f(b)

% false position initial value
c1 = a - (f(a)*(b-a)) / (f(b)-f(a));
f(c1)

err = [];
iter = 0;

while abs(f(c1)) > 0.0105

    iter = iter + 1;
    c_old = c1;

    if f(c1)*f(a) < 0
        b = c1;
    else
        a = c1;
    end

    c2 = a - (f(a)*(b-a)) / (f(b)-f(a));
    c1 = c2;

    err(iter) = abs(c1 - c_old);
end

c1

% Plot error
figure
plot(err,'-o')
xlabel('Iteration')
ylabel('Error')
legend('24051751')
title('Error Plot')
grid on
