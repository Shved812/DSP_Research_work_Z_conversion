function [outputS] = S_s(s,a,b)
S1=a(1).*(exp(-(0).*s));
S2=b(1).*(exp(-(0).*s));
for n=2:length(a)
    S1 = S1 + a(n).*(exp(-(n-1).*s));
end
for n=2:length(b)
    S2 = S2 + b(n).*(exp(-(n-1).*s));
end
% if(H2==0)
%     H2=H1/10000;
% end
S = S1./S2;
outputS = S;
end