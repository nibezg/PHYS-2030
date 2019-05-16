clear all;
x0=0.1; %Initial point
NSettle=50; %Number of iterations for system's behavior to stabilize
N=500; %Number of iterations after NSettlem, which is assumed to be the stabilized regime
r=linspace(0.5,4,1000); %r values
rPick=4; %r value for cobweb diagram

gIt=@(x,rP)rP*x.*(1-x); %Discrete Logistic Equation

%Plot of x vs r

figure(1)
subplot(2,1,1)
hold on

for j=1:length(r) %for each r value 
    x=zeros([1,NSettle+N]); %Initialize array to store x_n values
    rSet=ones([1,N+1])*r(j); %Initialize array of the same length as x array, but having the same value of r  
    
    %Fill x with computed values for logistic equation
    x(1)=x0;
        for i=2:NSettle+N
            x(i)=gIt(x(i-1),r(j)); %Iteration map for discrete logistic equation
        end        
plot(rSet,x(1,NSettle:NSettle+N),'.b') %Show the plot of computed x_n vs the same value of r (this way the spread in values can readily be seen for respective value of r)
end
title('Discrete form of Logistic equation: x_n+1=r*x_n(1-x_n)');
xlabel('r');
ylabel('x');
hold off


%Cobweb Diagram

subplot(2,1,2)

hold on

%Procedure to show cobweb diagram
plot(x,x,sort(x),gIt(sort(x),rPick),'Linewidth',3);
y0=gIt(x0,rPick);
line([x0,x0],[0,y0],'Color',[0 0 0],'Linewidth',0.1);
for i=1:length(x)
   line([x0,y0],[y0,y0],'Color',[0 0 0],'Linewidth',0.1); %Vertical line
   line([y0,y0],[y0,gIt(y0,rPick)],'Color',[0 0 0],'Linewidth',0.1); %Horizontal line
   x0=y0;
   y0=gIt(y0,rPick);
end
line([(rPick-1)/rPick,(rPick-1)/rPick],[0,(rPick-1)/rPick],'Color',[1 0 0],'Linewidth',2); %Indicate the fixed point for given r
title(['Cobweb diagram for r=' num2str(rPick)]);
xlabel('x');
ylabel('y');
hold off
