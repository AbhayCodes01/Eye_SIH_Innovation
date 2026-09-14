syms x y(x)

Dy = x + y(x)^2;   % Use y(x) explicitly
x0 = 0;
y0 = 1;

% First derivative
y_1 = subs(Dy, [x y(x)], [x0 y0]);

% Second derivative using chain rule
D2y = diff(Dy, x);
D2y = subs(D2y, diff(y(x),x), Dy);   % substitute y' from equation

y_2 = subs(D2y, [x y(x)], [x0 y0]);

% Third derivative
D3y = diff(D2y, x);
D3y = subs(D3y, diff(y(x),x), Dy);

y_3 = subs(D3y, [x y(x)], [x0 y0]);

% Taylor series expansion
Y = y0 ...
    + (x-x0)*y_1 ...
    + ((x-x0)^2*y_2)/factorial(2) ...
    + ((x-x0)^3*y_3)/factorial(3);

simplify(Y)
