
% clear all workspace variables
clear all;

% global variables that may be used here
global popsize ;
global nreal ;
global nobj ;
global ncon ;
global ngen ;

% load algorithm parameters
load_input_data('input_data/zdt1.debug.in');
pprint('\nInput data successfully entered, now performing initialization\n\n');

obj_col = nreal + 1 : nreal + nobj ;

% this is the objective function that we are going to optimize
obj_func = @zdt1 ;
child_pop = zeros(popsize, nreal + nobj + ncon + 3);
mixed_pop = zeros(2 * popsize, nreal + nobj + ncon + 3);

% initialize population
parent_pop = initialize_pop(123456);
pprint('Initialization done, now performing first generation\n\n');
pprint('initial pop:\n', parent_pop);
parent_pop = evaluate_pop(parent_pop, obj_func);
pprint('initial pop evaluated:\n', parent_pop);
parent_pop = assign_rank_and_crowding_distance(parent_pop);
pprint('initial pop evaluated and ranked:\n', parent_pop);

% plot it
% plotpf(i,parent_pop);

% for i = 2:ngen
%     fprintf('gen = %d\n', i)
%     child_pop = selection(parent_pop, child_pop);
%     child_pop = mutation_pop(child_pop);
%     % pprint(sprintf('[main gen = %d] child pop before eval:\n', i), child_pop);
%     child_pop = evaluate_pop(child_pop, obj_func);
%     % pprint(sprintf('[main gen = %d] child pop evaluated:\n', i), child_pop);
%     mixed_pop = merge(parent_pop, child_pop);
%     % pprint(sprintf('[main gen = %d] mixed_pop:\n',i), mixed_pop);
%     parent_pop = fill_nondominated_sort(mixed_pop);
%     % pprint(sprintf('[main gen = %d] new parent_pop:\n',i), parent_pop);
%     
%     % plot them
%     plotpf(i, parent_pop);    
% end
pprint('done\n');
