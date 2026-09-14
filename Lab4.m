% root of the equation using newton Rapehson method    
f=@(x) x^3-0.165*x^2 + 0.004;
% f_dash = diff(f); % cant use it here for somereason so manual 
f_dash=@(x) 3*x^2 - 2*0.165*x;
X0=0.05;
f(X0)
f_dash(X0)
iter =0;
err=[];
X1=X0;

 while (f(X1)~=0)
  iter = iter+1
     X1=X0 - f(X0)/f_dash(X0)
     err(iter)=abs(f(X1))
     X0=X1;
 end

 X1
%now plotting the error
plot(err,'-o')
xlabel('Iteration')
ylabel('Error')
legend('24051751')