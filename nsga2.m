rng(123456, 'twister');
popsize = 100 ;
nobj = 2 ;
nreal = 30;
% no. of design variables, no. of objectives,  rank, constr violation, crowding distance
ncols = nreal + nobj + 3 ; 
parent_pop = zeros(popsize, ncols);
rnd_real = rand(popsize, nreal);
parent_pop(:,1:nreal) = rnd_real;
% disp(parent_pop);
parent_pop = zdt1(parent_pop, nreal);
% disp(parent_pop);
objvals = parent_pop(:, 31:32);
scatter(objvals(:,1), objvals(:,2));
