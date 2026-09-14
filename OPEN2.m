%% =================================================================
%% Script 3: Full Comparison and Verification Plot
%% =================================================================
clear; clc; close all;

syms t s Y
y0=1; dy0=1; ddy0=2;

% Reproduce Y(s) and y(t) from Script 1
F_s = laplace(1 + exp(2*t) + sin(t), t, s);
lhs = (s^3*Y - s^2*y0 - s*dy0 - ddy0) ...
    + 6*(s^2*Y - s*y0 - dy0) ...
    + 11*(s*Y - y0) ...
    + 6*Y;
Y_s   = solve(lhs == F_s, Y);
y_t   = simplify(ilaplace(simplify(Y_s), s, t));

% dsolve for verification
syms y(t)
ode  = diff(y,t,3)+6*diff(y,t,2)+11*diff(y,t)+6*y == 1+exp(2*t)+sin(t);
cond = [y(0)==1, subs(diff(y,t),t,0)==1, subs(diff(y,t,2),t,0)==2];
y_ds = simplify(dsolve(ode, cond));

% Evaluate numerically
t_val  = linspace(0, 2, 1000);
y_lap  = double(subs(y_t,  t, t_val));
y_dsolve = double(subs(y_ds, t, t_val));

% Compute error
err = abs(y_lap - y_dsolve);
fprintf('Max absolute error between methods: %.2e\n', max(err));

figure('Color','k','Position',[50 50 1100 750]);

% Top panel: full solution
subplot(2,1,1);
plot(t_val, y_lap, 'r-', 'LineWidth', 2.5);
set(gca,'Color','k','XColor','w','YColor','w'); grid on;
title('y(t)  —  Solution via Laplace Transform','Color','w','FontSize',12);
xlabel('Time (s)','Color','w'); ylabel('y(t)','Color','w');
xline(0,'--','Color',[0.5 0.5 0.5],'LineWidth',1);
text(0.05, 0.85, 'y(0)=1   y''(0)=1   y''''(0)=2', ...
     'Units','normalized','Color','y','FontSize',10);

% Bottom panel: Laplace vs dsolve overlay
subplot(2,1,2);
plot(t_val, y_lap,    'r-',  'LineWidth',2.5, 'DisplayName','Laplace Method'); hold on;
plot(t_val, y_dsolve, 'b--', 'LineWidth',1.5, 'DisplayName','dsolve() Check');
set(gca,'Color','k','XColor','w','YColor','w'); grid on;
title('Verification: Laplace vs dsolve()','Color','w','FontSize',12);
xlabel('Time (s)','Color','w'); ylabel('y(t)','Color','w');
legend('TextColor','w','Color','none','Location','best');