%% =================================================================
%% Third-Order ODE Solution Using Laplace Transform
%% ODE:  y''' + 6y'' + 11y' + 6y  =  1 + e^(2t) + sin(t)
%% ICs:  y(0)=1,  y'(0)=1,  y''(0)=2
%% =================================================================
clear; clc; close all;

% --- Step 1: Declare symbolic variables ---
syms t s Y
y0   = 1;    % y(0)
dy0  = 1;    % y'(0)
ddy0 = 2;    % y''(0)

% --- Step 2: Laplace transform of the forcing function f(t) ---
f_t = 1 + exp(2*t) + sin(t);
F_s = laplace(f_t, t, s);
disp('F(s) = Laplace{f(t)} ='); disp(F_s);

% --- Step 3: Build the s-domain algebraic equation ---
% L{y'''} = s^3*Y - s^2*y(0) - s*y'(0) - y''(0)
% L{y''}  = s^2*Y - s*y(0) - y'(0)
% L{y'}   = s*Y   - y(0)
% L{y}    = Y
lhs = (s^3*Y - s^2*y0 - s*dy0 - ddy0) ...
    + 6*(s^2*Y - s*y0 - dy0) ...
    + 11*(s*Y - y0) ...
    + 6*Y;
eq = lhs == F_s;
disp('s-domain equation:'); disp(eq);

% --- Step 4: Solve algebraically for Y(s) ---
Y_s = solve(eq, Y);
Y_s = simplify(Y_s);
disp('Y(s) ='); disp(Y_s);

% --- Step 5: Inverse Laplace transform to get y(t) ---
y_t = ilaplace(Y_s, s, t);
y_t = simplify(y_t);
disp('y(t) ='); disp(y_t);

% --- Step 6: Verify using dsolve (independent check) ---
syms y(t)
ode  = diff(y,t,3) + 6*diff(y,t,2) + 11*diff(y,t) + 6*y == 1 + exp(2*t) + sin(t);
cond = [y(0)==1, subs(diff(y,t),t,0)==1, subs(diff(y,t,2),t,0)==2];
y_check = dsolve(ode, cond);
disp('dsolve() verification:'); disp(simplify(y_check));

% --- Step 7: Plot y(t) ---
% NOTE: e^(2t) makes output grow — keep t range small (0 to 2)
t_val = linspace(0, 2, 1000);
y_val = double(subs(y_t, t, t_val));

figure('Color','k', 'Position',[100 100 900 500]);
plot(t_val, y_val, 'r-', 'LineWidth', 2);
xlabel('Time  t  (seconds)', 'Color','w');
ylabel('y(t)', 'Color','w');
title('Solution of  y'''' + 6y'''' + 11y'' + 6y = 1 + e^{2t} + sin(t)', ...
      'Color','w', 'FontSize',12);
set(gca, 'Color','k', 'XColor','w', 'YColor','w'); grid on;
legend('y(t)  with  y(0)=1,  y''(0)=1,  y''''(0)=2', ...
       'TextColor','w', 'Color','none');