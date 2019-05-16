function dy = DuffingOsc(t,y)

dy = zeros(2,1);    % a column vector
dy(1) = y(2);

m=1; %Mass [kg]
a=10; %Spring constant [N/m]
b=15; %Damping constant [kg/s]
d=2; %Damping constant [kg/s]

dy(2)=-a/m.*y(1)-b/m.*y(1).^3-d/m.*y(2); %Netwon's law

