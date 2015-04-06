
% clear all workspace variables
clear all;

addpath(genpath('./input_data'));   % this is where all the algorithm parameters are
addpath(genpath('./problemdef'));   % this is where all the problems are defined
addpath(genpath('./rand'));         % this is where all the legacy rng related stuffs are.
                                    % NOT VECTORIZED, DO NOT USE, SLOW !!!

% global variables that may be used here
global popsize ;
global nreal ;
global nobj ;
global ncon ;
global ngen ;

% load algorithm parameters
load_input_data('input_data/sch2.in');
pprint('\nInput data successfully entered, now performing initialization\n\n');

% for debugging puproses 
% global min_realvar ;
% global max_realvar ;
% popsize = 4 ;
% nreal = 3 ;
% ngen = 400 ;
% min_realvar = min_realvar(1:nreal);
% max_realvar = max_realvar(1:nreal);

obj_col = nreal + 1 : nreal + nobj ;

% this is the objective function that we are going to optimize
obj_func = @sch2 ;
child_pop = zeros(popsize, nreal + nobj + ncon + 3);
mixed_pop = zeros(2 * popsize, nreal + nobj + ncon + 3);

% you need to warm-up the cache if you need to do profiling
% for k = 1:50000
%     tic(); elapsed = toc();
% end

tic;
% initialize population
parent_pop = initialize_pop(0.12345);
pprint('Initialization done, now performing first generation\n\n');
parent_pop = evaluate_pop(parent_pop, obj_func);
parent_pop = assign_rank_and_crowding_distance(parent_pop);

% plot the pareto front
show_plot(1, parent_pop, false, [1 2 3]);

do_save = false ;
% save the current pop
if(do_save)
    save_pop(1, parent_pop, false);
end

for i = 2:ngen
    fprintf('gen = %d\n', i)
    child_pop = selection(parent_pop, child_pop);
    child_pop = mutation_pop(child_pop);
    child_pop(:,obj_col) = 0;
    child_pop = evaluate_pop(child_pop, obj_func);
    mixed_pop = merge_pop(parent_pop, child_pop);
    parent_pop = fill_nondominated_sort(mixed_pop);
    
    % plot the current pareto front
    show_plot(i, parent_pop, false, [1 2 3]);        
    
    % save the current pop
    if(do_save)
        save_pop(i, parent_pop, false);
    end
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
