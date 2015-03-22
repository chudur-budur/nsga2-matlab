
% clear all workspace variables
clear all;

% global variables that may be used here
global popsize ;
global nreal ;
global min_realvar ;
global max_realvar ;
global nobj ;
global ncon ;
global ngen ;
global pcross_real ;
global pmut_real ;

% load algorithm parameters
load_input_data('input_data/zdt2.in');
% mod for debugging purposes --
% popsize =  12;
% nreal = 3 ;
% min_realvar = min_realvar(1:nreal,:);
% max_realvar = max_realvar(1:nreal,:);
% pcross_real = 1.0 ;
% pmut_real = 1.0 ;
pprint('\nInput data successfully entered, now performing initialization\n\n');

obj_col = nreal + 1 : nreal + nobj ;

% this is the objective function that we are going to optimize
obj_func = @zdt2 ;
child_pop = zeros(popsize, nreal + nobj + ncon + 3);
mixed_pop = zeros(2 * popsize, nreal + nobj + ncon + 3);

% initialize population
parent_pop = initialize_pop(12345);
pprint('Initialization done, now performing first generation\n\n');
% pprint('initial pop:\n', parent_pop);
parent_pop = evaluate_pop(parent_pop, obj_func);
% pprint('initial pop evaluated:\n', parent_pop);
parent_pop = assign_rank_and_crowding_distance(parent_pop);
% pprint('initial pop evaluated and ranked:\n', parent_pop);

% plot it
plotpf(1, parent_pop, false);

for i = 2:ngen
    fprintf('gen = %d\n', i)
    child_pop = selection(parent_pop, child_pop);
    child_pop = mutation_pop(child_pop);
    child_pop(:,obj_col) = 0;
    % pprint(sprintf('[main gen = %d] child pop before eval:\n', i), child_pop);
    child_pop = evaluate_pop(child_pop, obj_func);
    % pprint(sprintf('[main gen = %d] child pop evaluated:\n', i), child_pop);
    mixed_pop = merge(parent_pop, child_pop);
    % pprint(sprintf('[main gen = %d] mixed_pop:\n',i), mixed_pop);
    parent_pop = fill_nondominated_sort(mixed_pop);
    % pprint(sprintf('[main gen = %d] new parent_pop:\n',i), parent_pop);
    
    % plot them
    plotpf(i, parent_pop);    
end
pprint('done\n');
