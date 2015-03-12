
% clear all workspace variables
clear all;

% global variables that may be used here
global popsize ;
global nreal ;
global nobj ;
global ncon ;

% load algorithm parameters
load_input_data('input_data/zdt1.debug.in');
pprint('\nInput data successfully entered, now performing initialization\n\n');

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

% plot the obj values
% obj_vals = parent_pop(:,nreal+1:nreal+nobj);
% strValues = strtrim(cellstr(num2str([obj_vals(:,1) obj_vals(:,2)],'(%.3f,%.3f)')));
% scatter(obj_vals(:,1), obj_vals(:,2));
% text(obj_vals(:,1),obj_vals(:,2),strValues,'VerticalAlignment','bottom');

parent_pop = assign_rank_and_crowding_distance(parent_pop);
pprint('initial pop ranked:\n', parent_pop);

child_pop = selection(parent_pop, child_pop);
child_pop = mutation_pop(child_pop);
pprint('child pop:\n', child_pop);
child_pop = evaluate_pop(child_pop, obj_func);
pprint('child pop evaluated:\n', child_pop);
mixed_pop = merge(parent_pop, child_pop);
% parent_pop = fill_nondominated_sort(mixed_pop);

