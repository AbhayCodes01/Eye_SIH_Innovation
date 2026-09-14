
% using gpt method 
%clc;
clear;
close all;

x = input('Enter the values of x as an array: ');
y = sind(x);

h = x(2) - x(1);
n = length(x);
u = (32 - x(1)) / h;

xy = zeros(n,n+1);
xy(:,1) = x';
xy(:,2) = y';

% ✅ Forward difference computation
for j = 3:n+1
    for i = 1:n-j+2
        xy(i,j) = xy(i+1,j-1) - xy(i,j-1);
    end
end

disp(xy);

coeff = zeros(2,n);
for i = 1:n
    if i == 1
        coeff(1,i) = 1;
    else
        coeff(1,i) = (u - i + 2) * coeff(1,i-1);
    end
    coeff(2,i) = factorial(i-1);
end

aa = xy(1,2:end) .* coeff(1,:);
f  = sum(aa ./ coeff(2,:));

fprintf('Interpolated value at x = 32 is %f\n', f);
% now backward
% Newton-Gregory Backward Interpolation
clear;
close all;
clc;

x = input('Enter the values of x as an array: ');
y = sind(x);

h = x(2) - x(1);
n = length(x);

% value at which interpolation is required
u = (32 - x(n)) / h;

xy = zeros(n, n+1);
xy(:,1) = x';
xy(:,2) = y';

% ✅ Forward difference table (used to extract backward differences)
for j = 3:n+1
    for i = 1:n-j+2
        xy(i,j) = xy(i+1,j-1) - xy(i,j-1);
    end
end

disp(xy);

% coefficient calculation for backward formula
coeff = zeros(2,n);
for i = 1:n
    if i == 1
        coeff(1,i) = 1;
    else
        coeff(1,i) = (u + i - 2) * coeff(1,i-1);
    end
    coeff(2,i) = factorial(i-1);
end

% backward interpolation uses last row differences
aa = zeros(1,n);
for i = 1:n
    aa(i) = xy(n-i+1, i+1);
end

f = sum((aa .* coeff(1,:)) ./ coeff(2,:));

fprintf('Interpolated value at x = 32 is %f\n', f);
