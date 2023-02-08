function [outputAx2] = create_plot1(X,Y,ax2)
        delete(ax2);
        ax2 = axes('Units','pixels','Position',[625,400,460,150]);
        p2 = plot(X,Y);
        xlim ([min(X),max(X)]);%([0,360*pi/180]);
        ylim ([min(Y),max(Y)+0.1]);
        title('AFC');
        grid on;
        xlabel('\omega')
        ylabel('dB')
outputAx2 = ax2;
end