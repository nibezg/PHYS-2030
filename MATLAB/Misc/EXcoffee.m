% ### EXcoffee.m ###    11.16.14    {C. Bergevin}
% [modified version of EXrandomWalk2D.m motivated by the problem shown in
% Giordano (1997) Fig.7.18ff]
clear;
% -------------
N= 30;      % one plus sqrt of total # of (independent) walkers (each starts at unique x,y point about origin)
M= 10000;      % Total # of steps for each walker
method= 2;  % see comments above
BND= 10;    % bounding limits for initial grid of walkers at t=0
axisLim= 100;   % size of coffee cup
diffC= 5;   % diffusion const. (i.e., scaling factor for step size)
framerate= 1/30;    % pause length [s] for animation
Sgrid= 8;           % grid spacing for entropy calculation
% -------------
% +++
space= (2*BND)/N;
[X,Y]= meshgrid(-BND:space:BND,-BND:space:BND);
E= size(X,1); % # of elements

SgridX= linspace(-axisLim,axisLim,Sgrid);   % set grid bounds for entropy calc.
SgridY= linspace(-axisLim,axisLim,Sgrid);

figure(1); clf;
% +++
% To do
% - apply boundary condition (i.e., ensure no steps past walls)
% - fix entropy calc. (i.e., if prob.=0??)
for r= 1:M
    
    if method==1
        % random L/R and U/D step with equal probability
        tempX= rand(E,E);   tempY= rand(E,E);  % determine random vals.
        temp2X= tempX<0.5;  temp2Y= tempY<0.5;  % determine L vs R and U vs D
        X(temp2X)= X(temp2X)+1; X(~temp2X)= X(~temp2X)-1;
        Y(temp2Y)= Y(temp2Y)+1; Y(~temp2Y)= Y(~temp2Y)-1;
    else
        % sample step from normal distribution
        stepX= randn(E,E); stepY= randn(E,E);
        X= X+ diffC*stepX;  Y= Y+ diffC*stepY;
        % verify step is not past walls; if so, bounce back in opposite direction
        [aa,bb]= find(abs(X)>axisLim);
        X(aa,bb)= X(aa,bb)-2*diffC*stepX(aa,bb);
        %if(~isempty(aa)),   return; end
        if(max(abs(X(:))>axisLim)), return;  end
    end
    % visualize
    figure(1)
    plot(X,Y,'k.','MarkerSize',5); axis([-axisLim axisLim -axisLim axisLim]); pause(framerate);
    % do binning to determine 'probability' distribution 
    histS= hist2(X(:),Y(:),SgridX,SgridY)/E; % use external function hist2.m; and normalize to a probability
    histS= histS(:);    % convert to a single column vector
    zeroI= ~histS==0; % need to filter out states with zero elements so to avoid computational error (since 0*log(0)= NaN)
    S(r)= -sum(histS(zeroI).*log(histS(zeroI))); % calculate entropy (S) 
end;

figure(2)
plot(S);
xlabel('time step'); ylabel('entropy');

