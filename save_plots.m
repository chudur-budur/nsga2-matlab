%% SAVE_PLOTS  Saves one pdf plot per generation from all_pop.mat.
%
%   Script to make plots from all the snapshots
%   Run nsga2.m with do_save = true first, so all_pop.mat exists, then
%   make sure the .in file below is the same one used for that run.
%
%   For every generation it loads gen_<gen> from all_pop.mat, puts the
%   columns back into the population layout used by show_plot()
%   (save_pop() reorders them), plots it, and saves
%   plots/gen_<gen>.pdf. The plots folder is cleared first.
%
%   xlist and flist below pick the variables and objectives to plot.
%
%   This script is not tuned well, there are some
%   extra gaps in the subplots generated in the pdfs.

addpath(genpath('./input_data'));   % this is where all the algorithm parameters are
load_input_data('input_data/zdt1.in');
load('all_pop.mat');

global nobj ;
global ngen ;
global nreal ;
global nbin ;
global sumnbits ;
global ncon ;

% number of variable columns, real or binary
if(nreal > 0)
    nvar = nreal ;
elseif(nbin > 0)
    nvar = sumnbits ;
end

xlist = [1 3 4]; % set of design variables to plot
flist = 1 : nobj; % set of objectives to plot
data = [];
            
if(exist('plots', 'file'))            
    delete('plots/*');    
else
    mkdir('plots');    
end

fpos = get(gcf, 'Position');
set(gcf,'Position',[fpos(1) fpos(2) 1000 400]);
set(gcf,'Color','w');
set(gcf, 'Visible', 'on');
for gen = 1:ngen
    eval(sprintf('data = gen_%d;', gen));
    data = [ ...
            data(:, nobj + ncon + 1 : nobj + ncon + nvar), ... % vars
            data(:, 1 : nobj), ... % nobj
            data(:, nobj + 1 : nobj + ncon), ... % ncons          
            data(:, nobj + ncon + nvar + 1 : end) ... % rest
            ]; 
    show_plot(gen, data, false, xlist, flist);
    set(gcf, 'PaperPosition', [0 0 10 4]); 
    set(gcf, 'PaperSize', [10 4]); 
    saveas(gcf, sprintf('plots/gen_%d', gen), 'pdf');
end

clear all ;