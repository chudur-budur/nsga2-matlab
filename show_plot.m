function show_plot(gen, pop, varargin)
%   This function plots the front, stolen from KeLi and Zhanghu's code.
%   gen = generation count
%   pop = population at generation gen
%   optional parameters:
%       is_text = will show values for each point on the plot, boolean
%       xlist = list of variables to be plotted for the pareto set
%       flist = list of objectives to plot, when nobj > 3

    global nreal ;
    global nobj ;
    
    p = inputParser;
    addRequired(p, 'gen', @isnumeric);
    addRequired(p, 'pop', @ismatrix);
    addOptional(p, 'is_text', false, @islogical);
    addOptional(p, 'xlist', [], @isvector);
    addOptional(p, 'flist', [], @isvector);
    parse(p, gen, pop, varargin{:});
    
    if(nobj == 2)
        f = p.Results.pop(:,nreal + [1 2]); 
    elseif(isempty(p.Results.flist))
        f = p.Results.pop(:, nreal + [1 2 3]);
        flist = [1 2 3] ;
    else
        f = p.Results.pop(:, nreal + p.Results.flist);
        flist = p.Results.flist ;
    end       
    
    if(~isempty(p.Results.xlist))
        xlist = p.Results.xlist ;
        x = p.Results.pop(:, nreal + xlist);        
    end
  
    fstr = sprintf('objective space, gen = %d', p.Results.gen);
    xstr = sprintf('variable space, gen = %d', p.Results.gen);
    
    if(p.Results.gen == 1)        
        if(~isempty(p.Results.xlist))
            cpos = get(gcf, 'Position');
            set(gcf,'Position',[cpos(1) cpos(2) 1000 400]);
        end
    end

    hold off; 
    if(~isempty(p.Results.xlist))
        subplot(1,2,1);
    end
    if nobj == 2
        plot(f(:,1), f(:,2), 'ro', 'MarkerSize', 4);
        xlabel('f1', 'FontSize', 6);
        ylabel('f2', 'FontSize', 6);
        if(p.Results.is_text)
            strValues = strtrim(cellstr(num2str([f(:,1) f(:,2)],'(%.4f,%.4f)')));
            text(f(:,1), f(:,2), strValues, 'VerticalAlignment', 'bottom');
        end
    else        
        plot3(f(:,1), f(:,2), f(:,3), ...
                            'ro', 'MarkerSize', 4);        
        xlabel(sprintf('f%d', flist(1)), 'FontSize', 6);
        ylabel(sprintf('f%d', flist(2)), 'FontSize', 6);
        zlabel(sprintf('f%d', flist(3)), 'FontSize', 6);
        if(p.Results.is_text)
            strValues = strtrim(cellstr(num2str([f(:,1) f(:,2) f(:,3)],...
                                            '(%.4f,%.4f,%.4f)')));
            text(f(:,1), f(:,2), f(:,3), ...
                            strValues, 'VerticalAlignment', 'bottom');
        end
    end
    title(fstr, 'FontSize', 8);
    box on;
    drawnow;
    
    if(~isempty(p.Results.xlist))
        subplot(1,2,2);
        if(length(xlist) == 2)
            plot(x(:,1), x(:,2), 'ro', 'MarkerSize', 4);
            xlabel('x1', 'FontSize', 6);
            ylabel('x2', 'FontSize', 6);
            if(p.Results.is_text)
                strValues = strtrim(cellstr(num2str([x(:,1) x(:,2)],...
                                            '(%.4f,%.4f)')));
                text(x(:,1), x(:,2), strValues, ...
                                'VerticalAlignment', 'bottom');
            end
        else
            plot3(x(:,1), x(:,2), x(:,3), ...
                            'ro', 'MarkerSize', 4);        
            xlabel(sprintf('x%d', xlist(1)), 'FontSize', 6);
            ylabel(sprintf('x%d', xlist(2)), 'FontSize', 6);
            zlabel(sprintf('x%d', xlist(3)), 'FontSize', 6);
            if(p.Results.is_text)
                strValues = strtrim(cellstr(...
                        num2str([x(:,1) x(:,2) x(:,3)],...
                                '(%.4f,%.4f,%.4f)')));
                text(x(:,1), x(:,2), x(:,3), ...
                                strValues, 'VerticalAlignment', 'bottom');
            end 
        end
        title(xstr, 'FontSize', 8);
        box on;
        drawnow;
    end