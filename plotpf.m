function plotpf(gen, pop, is_text)
%   This function plots the front, stolen from KeLi's code.

    global nreal ;
    global nobj ;  
    objs = pop(:,nreal+1:nreal+nobj);
    
    if (~exist('is_text', 'var'))
        is_text = false;
    end
  
    str = sprintf('gen = %d', gen);

    hold off; 
    subplot(1,1,1);
    if nobj == 2
        plot(objs(:,1), objs(:,2), 'ro', 'MarkerSize', 4);
        xlabel('f1', 'FontSize', 6);
        ylabel('f2', 'FontSize', 6);
        if(is_text)
            strValues = strtrim(cellstr(num2str([objs(:,1) objs(:,2)],'(%.4f,%.4f)')));
            text(objs(:,1),objs(:,2),strValues,'VerticalAlignment','bottom');
        end
    else
        plot3(objs(:,1), objs(:,2), objs(:,3), 'ro', 'MarkerSize', 4);
        xlabel('f1', 'FontSize', 6);
        ylabel('f2', 'FontSize', 6);
        zlabel('f3', 'FontSize', 6);
        if(is_text)
            strValues = strtrim(cellstr(num2str([objs(:,1) objs(:,2) objs(:,3)],'(%.4f,%.4f,%.4f)')));
            text(objs(:,1),objs(:,2),objs(:,3),strValues,'VerticalAlignment','bottom');
        end
    end
    title(str, 'FontSize', 8);
    box on;
    drawnow;