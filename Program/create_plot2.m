function [outputAx3] = create_plot2(X,Y,ax3)
        delete(ax3);
        ax3 = axes('Units','pixels','Position',[625,190,460,150]);
        p3 = plot(X,Y);
        xlim ([min(X),max(X)]);%([0,360*pi/180]);
        ylim ([min(Y),max(Y)+0.1]);
        title('FCH');
        grid on;
        xlabel('\omega')
        ylabel('\phi')
outputAx3 = ax3;
end