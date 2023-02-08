clc;clear;close all;
% test
% 1 -1.62 1
% 0.62 0.92 1
%(z^2-1.62*z+1)/(z^2+0.92*z+0.62)

% RC-diff
%1 -0.5478 -0.2477 -0.1120 -0.0507

% RC-int
% 0 0.06
% 1 -0.93

% Digital res
% 1
% 1 -1.1442 0.9474

% Filter Battervort
% 0.1311 0.2622 0.1311
% 1 -0.7478 0.2722

% Rejectorn filter
% 1.9474 -2.2894 1.9474
% 2 -2.2894 1.8948

%%
    
f=figure('NumberTitle','off','Name','Complex viewer','Position',[150,125,1200,600],...
    'MenuBar','none','Resize','off');
ax1 = axes('Units','pixels','Position',[75,200,460,350]);
ax2 = axes('Units','pixels','Position',[625,400,460,150]);
ax3 = axes('Units','pixels','Position',[625,190,460,150]);

t = input(['What kind of conversion do you need? :\n' ...
    '    1) Z-conversion\n    2) Laplas-conversion\n' ...
    '    3) Laplas-conversion with Z-coefficient\n'], 's');
%%
switch t
    case '1'
    
    t = input('Enter the vector zeros coefficients :\n', 's');
    zr = str2num(t);
    t = [num2str(zr(1))];
    for k = 2:length(zr)
        if(zr(k)>=0)
            t=strcat(t,'+');
        end
        t=strcat(t,num2str(zr(k)),'z^',num2str(k-1));
    end
    disp([t,newline]);
    
    t = input('Enter the vector poles coefficients :\n', 's');
    pl = str2num(t);
    t = [num2str(pl(1))];
    for k = 2:length(pl)
        if(pl(k)>=0)
            t=strcat(t,'+');
        end
        t=strcat(t,num2str(pl(k)),'z^',num2str(k-1));
    end
    disp([t,newline]);
    
    [th,r] = meshgrid((0:1:360)*pi/180,0:0.01:1.5);
    [X,Y] = pol2cart(th,r);
    z=X+1i*Y;
    Hz = H_z(z,zr,pl);    
    ax1 = create_surf(X,Y,log10(abs(Hz)),ax1);
    drawnow
    
    r_eq = 1.0;
    while r_eq>0
        [th,r] = meshgrid((0:1:360)*pi/180,0:0.01:1.5);
        [X,Y] = pol2cart(th,r);
        ax1 = create_surf(X,Y,log10(abs(Hz)),ax1);
        hold on        
        [th_c, r_c] = meshgrid((0:1:360)*pi/180-pi,(r_eq:0.05:r_eq));
        [X,Y]=pol2cart(th_c,r_c);
        for k=-3.5:0.5:1%min(min(log10(abs(Hz)))):0.5:max(max(log10(abs(Hz))))
            plot3(X,Y,(X*0+k));
        end
        hold off
        
        AFC = log10(abs(H_z((X+1i*Y),zr,pl)));
        ax2 = create_plot1(th_c,AFC,ax2);
        FCH = angle(H_z((X+1i*Y),zr,pl));
        ax3 = create_plot2(th_c,FCH,ax3);

        t = input('Enter the radius of FFR:\n', 's');
        r_eq = str2num(t);
        if(~(r_eq > 0))
            continue;
        end
        if(r_eq>1.01)
            disp(['Solution r out of range',newline,'r must be 0<r<1',newline]);
            continue;
        end
    end
%%
    case '2'
    t = input('Enter the vector zeros coefficients :\n', 's');
    zr = str2num(t);
    t = [num2str(zr(1))];
    for k = 2:length(zr)
        if(zr(k)>=0)
            t=strcat(t,'+');
        end
        t=strcat(t,num2str(zr(k)),'s^',num2str(k-1));
    end
    disp([t,newline]);
    
    t = input('Enter the vector poles coefficients :\n', 's');
    pl = str2num(t);
    t = [num2str(pl(1))];
    for k = 2:length(pl)
        if(pl(k)>=0)
            t=strcat(t,'+');
        end
        t=strcat(t,num2str(pl(k)),'s^',num2str(k-1));
    end
    disp([t,newline]);

    [X,Y] = meshgrid((-10:0.1:10),(-10:0.1:10));
    z = X+1j*Y;
    Sz = S_z(z,zr,pl);
    ax1 = create_surf(X,Y,log10(abs(Sz)),ax1);
    drawnow
    
    r_eq = 0;
    while (r_eq<10.1 || r_eq>-10.1)

        [X,Y] = meshgrid((-10:0.1:10),(-10:0.1:10));
        ax1 = create_surf(X,Y,log10(abs(Sz)),ax1);
        hold on
        Y = (-10:0.1:10);
        X = Y*0+r_eq;
        for n=-2:0.25:2%min(min(log10(abs(Sz)))):0.25:max(max(log10(abs(Sz))))
            Z = Y*0+n;
            plot3(X,Y,Z);
        end
        hold off

        AFC = log10(abs(S_z((X+1i*Y),zr,pl)));
        ax2 = create_plot1(Y,AFC,ax2);
        FCH = angle(S_z((X+1i*Y),zr,pl));
        ax3 = create_plot2(Y,FCH,ax3);
            
        t = input('Enter the radius of FFR:\n', 's');
        r_eq = str2num(t);
        if(r_eq>10.1 || r_eq<-10.1)
            disp(['Solution r out of range',newline,'r must be -10<r<10',newline]);
            %continue;
            break
        end
    end
%%
    case '3'
    t = input('Enter the vector zeros coefficients :\n', 's');
    zr = str2num(t);
    t = [num2str(zr(1))];
    for k = 2:length(zr)
        if(zr(k)>=0)
            t=strcat(t,'+');
        end
        t=strcat(t,num2str(zr(k)),'s^',num2str(k-1));
    end
    disp([t,newline]);
    
    t = input('Enter the vector poles coefficients :\n', 's');
    pl = str2num(t);
    t = [num2str(pl(1))];
    for k = 2:length(pl)
        if(pl(k)>=0)
            t=strcat(t,'+');
        end
        t=strcat(t,num2str(pl(k)),'s^',num2str(k-1));
    end
    disp([t,newline]);

    [X,Y] = meshgrid((-10:0.1:10),(-10:0.1:10));
    z = X+1j*Y;
    Ss = S_s(z,zr,pl);
    ax1 = create_surf(X,Y,log10(abs(Ss)),ax1);
    drawnow
    
    r_eq = 0;
    while (r_eq<10.1 || r_eq>-10.1)

        [X,Y] = meshgrid((-10:0.1:10),(-10:0.1:10));
        ax1 = create_surf(X,Y,log10(abs(Ss)),ax1);
        hold on
        Y = (-10:0.1:10);
        X = Y*0+r_eq;
        %temp = linspace(-5,3,15);
        temp = linspace(min(min(log10(abs(Ss)))),max(max(log10(abs(Ss)))),20);
        for n=temp%
            Z = Y*0+n;
            plot3(X,Y,Z);
        end
        hold off

        AFC = log10(abs(S_s((X+1i*Y),zr,pl)));
        ax2 = create_plot1(Y,AFC,ax2);
        FCH = angle(S_s((X+1i*Y),zr,pl));
        ax3 = create_plot2(Y,FCH,ax3);
            
        t = input('Enter the radius of FFR:\n', 's');
        r_eq = str2num(t);
        if(r_eq>10.1 || r_eq<-10.1)
            disp(['Solution r out of range',newline,'r must be -10<r<10',newline]);
            break
        end
    end
%%
    otherwise
end
disp([newline,'END !',newline]);