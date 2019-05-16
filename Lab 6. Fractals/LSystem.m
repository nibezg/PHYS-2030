function [f]=LSystem(s,sRec,n)
if (n==0) 
    f=s;
else
    j=1;
    for i=1:length(s)
       for t=1:length(sRec)
          if s(1,i)==sRec{t,1}
              if length(sRec{t,2})==1
                 f(1,j)=sRec{t,2};
                 j=j+1;
              else
                 for k=j:j+length(sRec{t,2})-1
                    f(1,k)=sRec{t,2}(k-j+1);
                 end
                 j=k+1;
              end
              
          end
       end
    end
    s=f;
    s=horzcat(sRec{end,2},s);
    [f]=LSystem(s,sRec,n-1);
end  