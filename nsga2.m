%% NSGA2  Main driver script for the vectorized NSGA-II.
%
%   This script runs the Non-dominated Sorting Genetic Algorithm II
%   (Deb et al., 2002) on one of the test problems in ./problemdef. It is
%   a MATLAB translation of the original nsga2 c-code, with most of the
%   expensive parts (dominance check, crowding distance, SBX, polynomial
%   mutation) vectorized.
%
%   Usage:
%       1. Pick a parameter file from ./input_data and pass it to
%          load_input_data() below, e.g. 'input_data/zdt1.in'.
%       2. Set obj_func to the matching problem in ./problemdef,
%          e.g. @zdt1.
%       3. Set do_plot / do_save as needed and run:
%               >> nsga2
%
%   Population layout:
%       Every population (parent_pop, child_pop, mixed_pop) is a matrix,
%       one individual per row, with the columns arranged like this --
%
%           [ vars | objs | cons | cv | rank | crowd-dist ]
%
%       vars       = nreal real variables, or sumnbits bits if binary
%       objs       = nobj objective values (all minimized)
%       cons       = ncon constraint values (>= 0 means satisfied)
%       cv         = total constraint violation (<= 0, 0 means feasible)
%       rank       = non-domination rank (1 = best front)
%       crowd-dist = crowding distance within the rank
%
%   Main loop (for each generation):
%       selection      -> binary tournament + crossover, makes child_pop
%       mutation_pop   -> polynomial mutation on child_pop
%       evaluate_pop   -> objective and constraint evaluation
%       merge_pop      -> parent_pop + child_pop = mixed_pop (2 * popsize)
%       fill_nondominated_sort -> keep the best popsize individuals by
%                                 rank and then crowding distance
%
%   Outputs (only when do_save is true):
%       all_pop.out / all_pop.mat     = population of every generation
%       final_pop.out / final_pop.mat = final population
%       best_pop.out / best_pop.mat   = rank 1 individuals of the final pop
%
%   All the algorithm parameters are shared through global variables,
%   see load_input_data.m for the full list.

%% clear all workspace variables
clear ;

%% this is where all the algorithm parameters are
addpath(genpath('./input_data'));
% this is where all the problems are defined
addpath(genpath('./problemdef'));

%% global variables that may be used here
global seed
global popsize ;
global nreal ;
global nbin ;
global nbits ;
global sumnbits;
global nobj ;
global ncon ;
global ngen ;

%% load algorithm parameters
% The .in file sets popsize, ngen, nobj, ncon, the variable bounds, and
% the crossover/mutation probabilities and distribution indices.
load_input_data('input_data/zdt1.in');
pprint('\nInput data successfully entered, now performing initialization\n\n');

%% You can use these for debugging and these will override all the values
%% from load_input_data().
% global min_realvar ;
% global max_realvar ;
% popsize = 24 ;
% nreal = 3 ;
% ngen = 400 ;
% min_realvar = min_realvar(1:nreal);
% max_realvar = max_realvar(1:nreal);
% global min_binvar ;
% global max_binvar ;
% nbin = 2;
% nbits = [3;3];
% min_binvar = [0;0];
% max_binvar = [5;5];

%% The column numbers for the objective values.
if(nreal > 0)
    obj_col = nreal + 1 : nreal + nobj ;
elseif(nbin > 0)
    obj_col = sumnbits + 1 : sumnbits + nobj ;
end

%% this is the objective function that we are going to optimize.
% It must match the .in file loaded above. The function takes the whole
% population and fills in its objective and constraint columns.
obj_func = @zdt1 ;

%% allocate memory for pops
% The extra 3 columns are for cv, rank and crowding distance.
if(nreal > 0)
    child_pop = zeros(popsize, nreal + nobj + ncon + 3);
    mixed_pop = zeros(2 * popsize, nreal + nobj + ncon + 3);
elseif(nbin > 0)
    child_pop = zeros(popsize, sumnbits + nobj + ncon + 3);
    mixed_pop = zeros(2 * popsize, sumnbits + nobj + ncon + 3);
end

%% you need to warm-up the cache if you need to do profiling
% for k = 1:50000
%     tic(); elapsed = toc();
% end

%% start nsga2
tic;

% init rng, change the seed to get a different run
seed = 1999;
rng(seed, 'twister');

% initialize population, then evaluate and rank the first generation
parent_pop = initialize_pop();
pprint('Initialization done, now performing first generation\n\n');
parent_pop = evaluate_pop(parent_pop, obj_func);
parent_pop = assign_rank_and_crowding_distance(parent_pop);

%% Unset to stop the plotting on the fly.
% show_plot(gen, pop, is_text, xlist, flist, xlim, ylim, zlim), the 4th
% argument is the list of variables to plot next to the objective space.
do_plot = true ;
% plot the pareto front
if(do_plot); show_plot(1, parent_pop, false, [1 2 3]); end;

%% Set to save the current population.
do_save = false ;
if(do_save); save_pop(1, parent_pop, false); end;

%% main generation loop
for i = 2:ngen
    fprintf('gen = %d\n', i)
    % make the offspring by tournament selection, crossover and mutation
    child_pop = selection(parent_pop, child_pop);
    child_pop = mutation_pop(child_pop);
    % reset the old objective values and evaluate the offspring
    child_pop(:,obj_col) = 0;
    child_pop = evaluate_pop(child_pop, obj_func);
    % combine parents and offspring, then keep the best popsize of them
    mixed_pop = merge_pop(parent_pop, child_pop);
    parent_pop = fill_nondominated_sort(mixed_pop);

    % plot the current pareto front
    % if(do_plot)
    %   show_plot(i, parent_pop, false, [1 2 3], [], ...
    %       [0.0, 1.0], [0.0, 1.0]);
    % end;
    if(do_plot); show_plot(i, parent_pop, false, [1 2 3]); end;

    % save the current pop
    if(do_save); save_pop(i, parent_pop, false); end;
end
toc;
fprintf('Generations finished, now reporting solutions\n');

if(do_save)
    % save the final pop
    save_pop(i, parent_pop, false, 'final');
    % save the best pop
    save_pop(i, parent_pop, false, 'best');
end
fprintf('Routine successfully exited\n');
