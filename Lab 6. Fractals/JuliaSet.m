N=60;
gridSize=[-1.5 -1.5;1.5 1.5];
gridSpacing=[0.005 0.005];
maxZ=100;
[x,y]=meshgrid(gridSize(1,1):gridSpacing(1):gridSize(2,1),gridSize(1,2):gridSpacing(2):gridSize(2,2));
c=-0.52155623121-0.65453453*1i;
z=x+1i.*y;
k=z;
for i=1:N
    z=z.^2+c;
    k(abs(z)<maxZ) = i;
end
contourf(x,y,k)
