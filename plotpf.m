function plotpf(gen, pop)
%   This function plots the front, stolen from KeLi's code.

    global nreal ;
    global nobj ;  
    objs = pop(:,nreal+1:nreal+nobj);
  
    str = sprintf('gen = %d', gen);

    hold off; 
    subplot(1,1, 1);
    if nobj == 2
        plot(objs(:,1), objs(:,2), 'ro', 'MarkerSize', 4);
        xlabel('f1', 'FontSize', 6);
        ylabel('f2', 'FontSize', 6);
        % strValues = strtrim(cellstr(num2str([objs(:,1) objs(:,2)],'(%.3f,%.3f)')));
        % text(objs(:,1),objs(:,2),strValues,'VerticalAlignment','bottom');
    else
        plot3(objs(:,1), objs(:,2), objs(:,3), 'ro', 'MarkerSize', 4);
        xlabel('f1', 'FontSize', 6);
        ylabel('f2', 'FontSize', 6);
        zlabel('f3', 'FontSize', 6);
        % strValues = strtrim(cellstr(num2str([objs(:,1) objs(:,2) objs(:,3)],'(%.3f,%.3f,%.3f)')));
        % text(objs(:,1),objs(:,2),objs(:,3),strValues,'VerticalAlignment','bottom');
    end
    title(str, 'FontSize', 8);
    box on;
    drawnow;