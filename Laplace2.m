%% Laplace Transform: y'' + 2y' + 10y = 1 + e^(5t)
%% Initial Conditions: y(0) = 1, y'(0) = 2

clc; clear; close all;
syms t s Y

y0  = 1;   
dy0 = 2;   


F = laplace(1 + exp(5*t), t, s);
disp('F(s) ='); disp(F);


eq = (s^2*Y - s*y0 - dy0) + 2*(s*Y - y0) + 10*Y == F;
disp('s-domain equation:'); disp(eq);

Y_s = solve(eq, Y);
Y_s = simplify(Y_s);
disp('Y(s) ='); disp(Y_s);

y_t = ilaplace(Y_s, s, t);
y_t = simplify(y_t);
disp('y(t) ='); disp(y_t);

syms y(t)
ode  = diff(y,t,2) + 2*diff(y,t) + 10*y == 1 + exp(5*t);
cond = [y(0)==1, subs(diff(y,t),t,0)==2];
y_check = dsolve(ode, cond);
disp('dsolve verification:'); disp(simplify(y_check));

% STEP 7: Plot

t_val = linspace(0, 3, 1000);
y_val = double(subs(y_t, t, t_val));

figure;
plot(t_val, y_val, 'r-', 'LineWidth', 2);
xlabel('Time (t)');
ylabel('y(t)');
title('y'''' + 2y'' + 10y = 1 + e^{5t},  y(0)=1,  y''(0)=2');
grid on;
legend('y(t) with y(0)=1, y''(0)=2');