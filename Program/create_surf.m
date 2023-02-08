function [outputAx1] = create_surf(X,Y,Z,ax1)
    delete(ax1)
    ax1 = axes('Units','pixels','Position',[75,200,460,350]);
    meshz(X,Y,Z);
    view(3);
    zoom on;
    pan on;
    rotate3d(ax1);
    title('Transfer function')
    xlabel('\Re')
    ylabel('\Im')
    zlabel('log_{10} (|H(s)|)')
outputAx1 = ax1;
end