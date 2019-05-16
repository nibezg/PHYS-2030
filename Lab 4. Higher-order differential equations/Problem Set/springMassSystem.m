function dy = springMassSystem(t,y)

dy = zeros(2,1);    % a column vector
dy(1) = y(2);

k=10; %Spring constant [N/m]
m=1; %Mass [kg]

dy(2)=-k/m.*y(1); %Netwon's law

