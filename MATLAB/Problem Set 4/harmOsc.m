function dy = harmOsc(t,y)

dy = zeros(2,1);    % a column vector
dy(1) = y(2);

k=10; %Spring constant [N/m]
m=1; %Mass [kg]
b=0.5; %Damping constant [kg/s]

dy(2)=-k/m.*y(1)-b/m.*y(2); %Netwon's law

