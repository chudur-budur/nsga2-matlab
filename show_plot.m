function [] = show_plot(gen, pop, varargin)
%SHOW_PLOT  Plots the objective space, and optionally the variable space.
%
%   show_plot(gen, pop)
%   show_plot(gen, pop, is_text, xlist, flist, xlim_, ylim_, zlim_)
%
%   This function plots the front, stolen from KeLi and Zhanghu's code.
%   gen = generation count
%   pop = population at generation gen
%   optional parameters:
%       is_text = will show values for each point on the plot, boolean
%       xlist = list of variables to be plotted for the pareto set
%       flist = list of objectives to plot, when nobj > 3
%       xlim_, ylim_, zlim_ = axis limits of the objective plot,
%                             [min max], empty means automatic
%
%   With 2 objectives the front is a 2-d plot, otherwise a 3-d plot of
%   the objectives in flist (the first 3 by default). If xlist is
%   given, the figure is split in two and the right subplot shows the
%   variables in xlist (2 or 3 of them).
%
%   It draws on the current figure (gcf) and calls drawnow, so calling
%   it every generation gives an animation.
%
%   Globals used:
%       nreal, nobj

    global nreal ;
    global nobj ;

	plotMarkerSize = 4;
	labelFontSize = 15;
	titleFontSize = 12;

    p = inputParser;
    addRequired(p, 'gen', @isnumeric);
    addRequired(p, 'pop', @ismatrix);
    addOptional(p, 'is_text', false, @islogical);
    addOptional(p, 'xlist', [], @(x) isvector(x) || isempty(x));
    addOptional(p, 'flist', [], @(x) isvector(x) || isempty(x));
    addOptional(p, 'xlim_', [], @(x) isvector(x) || isempty(x));
    addOptional(p, 'ylim_', [], @(x) isvector(x) || isempty(x));
    addOptional(p, 'zlim_', [], @(x) isvector(x) || isempty(x));
    parse(p, gen, pop, varargin{:});

    if(nobj == 2)
        f = p.Results.pop(:, nreal + [1 2]);
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

    % plot objectives
    if nobj == 2
        plot(f(:,1), f(:,2), 'ro', 'MarkerSize', plotMarkerSize);
        xlabel('f1', 'FontSize', labelFontSize);
        ylabel('f2', 'FontSize', labelFontSize);
        if(~isempty(p.Results.xlim_)); xlim(p.Results.xlim_); end;
        if(~isempty(p.Results.ylim_)); ylim(p.Results.ylim_); end;
        if(p.Results.is_text)
            strValues = strtrim(cellstr(num2str([f(:,1) f(:,2)],'(%.4f,%.4f)')));
            text(f(:,1), f(:,2), strValues, 'VerticalAlignment', 'bottom');
        end
    else
        plot3(f(:,1), f(:,2), f(:,3), 'ro', 'MarkerSize', plotMarkerSize);
        xlabel(sprintf('f%d', flist(1)), 'FontSize', labelFontSize);
        ylabel(sprintf('f%d', flist(2)), 'FontSize', labelFontSize);
        zlabel(sprintf('f%d', flist(3)), 'FontSize', labelFontSize);
        if(~isempty(p.Results.xlim_)); xlim(p.Results.xlim_); end;
        if(~isempty(p.Results.ylim_)); ylim(p.Results.ylim_); end;
        if(~isempty(p.Results.zlim_)); zlim(p.Results.zlim_); end;
        if(p.Results.is_text)
            strValues = strtrim(cellstr(num2str([f(:,1) f(:,2) f(:,3)],...
                                            '(%.4f,%.4f,%.4f)')));
            text(f(:,1), f(:,2), f(:,3),strValues,'VerticalAlignment','bottom');
        end
    end
    title(fstr, 'FontSize', titleFontSize);
    box on;
    drawnow;

    % plot variables
    if(~isempty(p.Results.xlist))
        subplot(1,2,2);
        if(length(xlist) == 2)
            plot(x(:,1), x(:,2), 'ro', 'MarkerSize', plotMarkerSize);
            xlabel('x1', 'FontSize', labelFontSize);
            ylabel('x2', 'FontSize', labelFontSize);
            if(p.Results.is_text)
                strValues = strtrim(cellstr(num2str([x(:,1) x(:,2)],...
                                            '(%.4f,%.4f)')));
                text(x(:,1), x(:,2), strValues, 'VerticalAlignment', 'bottom');
            end
        else
            plot3(x(:,1), x(:,2), x(:,3), ...
                            'ro', 'MarkerSize', plotMarkerSize);
            xlabel(sprintf('x%d', xlist(1)), 'FontSize', labelFontSize);
            ylabel(sprintf('x%d', xlist(2)), 'FontSize', labelFontSize);
            zlabel(sprintf('x%d', xlist(3)), 'FontSize', labelFontSize);
            if(p.Results.is_text)
                strValues = strtrim(cellstr(...
							num2str([x(:,1) x(:,2) x(:,3)],...
                                '(%.4f,%.4f,%.4f)')));
                text(x(:,1), x(:,2), x(:,3), ...
				strValues, 'VerticalAlignment', 'bottom');
            end
        end
        title(xstr, 'FontSize', titleFontSize);
        box on;
        drawnow;
    end
