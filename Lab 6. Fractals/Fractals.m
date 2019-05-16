%Koch snowflake
sRec={'F' 'F-F++F-F';'+' '+';'-' '-';'T' 'T'};
[sCMD]=LSystem('F++F++F',sRec,8);
r=[0 0];
lengthF=1;
theta=90;
angleStep=60;
distScale=1/3;
r=Turtle(sCMD,r,lengthF, angleStep, theta,distScale);

%Sierpinski triangle
%sRec={'A' 'B-A-B';'B' 'A+B+A';'+' '+';'-' '-';'T' 'T'};
%[sCMD]=LSystem('A',sRec,7);
%r=[0 0];
%lengthF=1;
%theta=0;
%angleStep=60;
%distScale=1;
%r=Turtle(sCMD,r,lengthF, angleStep, theta,distScale);

%Fractal tree
%sRec={'A' 'AA';'B' 'A[+B]-B';'[' '[';']' ']';'+' '+';'-' '-';'T' 'T'};
%[sCMD]=LSystem('B',sRec,12);
%r=[0 0];
%lengthF=1;
%theta=90;
%angleStep=45;
%distScale=1/3;
%r=Turtle(sCMD,r,lengthF, angleStep, theta,distScale);

%Fractal plant
%sRec={'X' 'F-[[X]+X]+F[+FX]-X';'F' 'FF';'[' '[';']' ']';'+' '+';'-' '-';'T' 'T'};
%[sCMD]=LSystem('X',sRec,7);
%r=[0 0];
%lengthF=1;
%theta=30;
%angleStep=25;
%distScale=1;
%r=Turtle(sCMD,r,lengthF, angleStep, theta,distScale);

%plot(r(:,1),r(:,2),'b.');
axis tight;
