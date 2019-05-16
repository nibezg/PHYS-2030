function dy = lorenzSys(t,y)

dy = zeros(3,1);  % a column vector

sigma=10;
rho=28;
beta=8/3;

dy(1) = sigma*(y(2)-y(1));
dy(2)=y(1)*(rho-y(3))-y(2);
dy(3)=y(1)*y(2)-beta*y(3);

