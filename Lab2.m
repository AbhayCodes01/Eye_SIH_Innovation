clc 
clear all;
close all;

A =[1,2;3,4];
B=[3,1;5,2];
C =[1,1;2,2];
D=(A*B) + transpose(C);

E =inv(A);
F = det(B);
G = adjoint(A);


