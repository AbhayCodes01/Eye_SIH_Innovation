clc;
clear all;
close all;
 syms Vd;
 Io=2.0*(10^-6);
 K=1.38*(10^-23);
 T=300;
 q = 1.602*(10^-19);

 f =@(Vd) Io*(exp((q*Vd)/K*T)-1);
 Vd = [-1: 0.2: 0.6];
 Id = f(Vd);
plot(Vd, Id);
xlabel('Voltage (V)');
ylabel('Current (A)');
title('Current-Voltage Characteristics');
grid on;
ylim([min(Id) max(Id)]);