clc 
clear all 
close all 
 % let us assume a=-1 b=2
 % then check f(a)*f(b)<0 if yes then c=(a+b)/2
 a = -1; 
b = 2; 
f=@(x) x^3-x-1;
f(a)*f(b)
% yes our assumed values are correct we got <0 so now c = a+b/2
c1 = (a + b) / 2;
f(c1)

% as f(c1) !=0 so we check the further conditions 
% if f(c1)*f(a) <0 so root lies between a and c1
% then c2=a+c1/2
%other wise c2=c1+b/2

err = [];          % store errors
iter = 0;

while abs(f(c1)) > 0.0105   %absolute value as value can be negative as well

    iter = iter + 1;
    c_old = c1;    % store previous value

    if f(c1)*f(a) < 0
        b = c1;   %shrink the range
        c2 = (a + c1)/2;
    else
        a = c1;     %shrink the range
        c2 = (c1 + b)/2;
    end

    c1 = c2;
    err(iter) = abs(c1 - c_old);   % error calculation
end

c1

% Plot error
figure
plot(err, '-o')
xlabel('Iteration')
ylabel('Error')
legend('24051751')
title('Error Plot')
grid on 

