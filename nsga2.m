
% clear all workspace variables
clear all;

% global variables that may be used here
global nreal ;
global nobj ;

% init rng
rng(123456, 'twister');

% load algorithm parameters
load_input_data('input_data/zdt1.debug.in');
pprint('\nInput data successfully entered, now performing initialization\n\n');

% this is the objective function that we are going to optimize
obj_func = @zdt1 ;

% initialize population
parent_pop = initialize_pop();
pprint('Initialization done, now performing first generation\n\n');
pprint('initial pop:\n', parent_pop);
parent_pop = evaluate_pop(parent_pop, obj_func);
pprint('initial pop evaluated:\n', parent_pop);
obj_vals = parent_pop(:,nreal+1:nreal+nobj);
scatter(obj_vals(:,1), obj_vals(:,2));
