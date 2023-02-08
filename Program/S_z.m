function [outputS] = S_z(z,a,b)
S1=a(1).*(z.^(0));
S2=b(1).*(z.^(0));
for n=2:length(a)
    S1 = S1 + a(n).*(z.^(-(n-1)));
end
for n=2:length(b)
    S2 = S2 + b(n).*(z.^(-(n-1)));
end
% if(H2==0)
%     H2=H1/10000;
% end
S = S1./S2;
outputS = S;
end