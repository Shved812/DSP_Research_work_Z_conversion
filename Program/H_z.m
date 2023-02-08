function [outputH] = H_z(z,a,b)
H1=a(1).*(z.^(0));
H2=b(1).*(z.^(0));
for n=2:length(a)
    H1 = H1 + a(n).*(z.^(-(n-1)));
end
for n=2:length(b)
    H2 = H2 + b(n).*(z.^(-(n-1)));
end
% if(H2==0)
%     H2=H1/10000;
% end
H = H1./H2;
outputH = H;
end