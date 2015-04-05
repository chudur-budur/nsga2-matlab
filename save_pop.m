function [] = save_pop(gen, current_pop, varargin)
%   This function saves the pop in a file/matrix
%   parameters:
%       gen = current generation
%       pop = current population to save
%       is_burst = dump everything in one file or not, boolean
%       extra_options = to save the final pop, say 'final'
%                       to save the best pop, say 'best'

global nreal ;
global nobj ;
global ncon ;

rank_col = nreal + nobj + ncon + 2 ;

pop = [current_pop(:, nreal + 1 : nreal + nobj), ...
        current_pop(:, nreal + nobj + 1 : nreal + nobj + ncon), ...
        current_pop(:, 1 : nreal), ...
        current_pop(:, nreal + nobj + ncon + 1 : end)];

p = inputParser;
addRequired(p, 'gen', @isnumeric);
addRequired(p, 'pop', @ismatrix);
addOptional(p, 'is_burst', false, @islogical);
expectedOptions = {'final','best'};
addOptional(p, 'extra', '', @(x) any(validatestring(x,expectedOptions)));
parse(p, gen, pop, varargin{:});

data = sortrows(pop, rank_col);
best_data = pop((pop(:, rank_col) == 1),:);

if(strcmp(p.Results.extra, 'final'))    
    print_header(gen, 'final_pop.out', 'final', 'w');
    dlmwrite('final_pop.out', data, '-append', 'delimiter', ' ', ...
        'precision', '%.4f');
    eval('final_pop = data ;');
    save('final_pop.mat', 'final_pop');
    return ;
elseif(strcmp(p.Results.extra, 'best'))    
    print_header(gen, 'best_pop.out', 'best', 'w');
    dlmwrite('best_pop.out', best_data, '-append', 'delimiter', ' ', ...
        'precision', '%.4f');
    eval('best_pop = data ;');
    save('best_pop.mat', 'best_pop');
    return ;
elseif(~p.Results.is_burst)    
    if(gen == 1)    
        print_header(gen, 'all_pop.out', 'all', 'w');
        dlmwrite('all_pop.out', data, '-append', 'delimiter', ' ', ...
            'precision', '%.4f');
        eval('gen_1 = data;');
        save('all_pop.mat', 'gen_1');
    else
        print_header(gen, 'all_pop.out', 'all', 'a');
        dlmwrite('all_pop.out', data, '-append', 'delimiter', ' ', ...
            'precision', '%.4f');
        eval(sprintf('gen_%d = data;', gen));
        save('all_pop.mat', sprintf('gen_%d', gen), '-append');
    end
else
    if(gen == 1)
        if(exist('snapshots', 'file'))            
            delete('snapshots/*');           
        else
            mkdir('snapshots');        
        end
    end
    file_name = sprintf('snapshots/all_pop_gen_%d.out', gen);
    print_header(gen, file_name, 'all', 'w');
    dlmwrite(file_name, data, '-append', 'delimiter', ' ');
end
end

function [] = print_header(gen, file_name, header, option)

global nreal ;
global nobj ;
global ncon ;
global nbin ;

file = fopen(file_name, option);
if(strcmp(header, 'all'))
    if(gen == 1)
        fprintf(file, '# This file contains the data of all generations\n');
        fprintf(file, '# of objectives = %d, # of constraints = %d, ', ...
            nobj, sum(ncon));
        fprintf(file, '# of real_var = %d, # of bits of bin_var = %d, ', ...
            nreal, sum(nbin)); 
        fprintf(file, 'constr_violation, rank, crowding_distance\n');
        fprintf(file, '# gen = %d\n', gen);
    else
        fprintf(file, '\n# gen = %d\n', gen);    
    end
elseif(strcmp(header, 'final')) 
    fprintf(file, '# This file contains the data of final population\n');
    fprintf(file, '# of objectives = %d, # of constraints = %d, ', ...
        nobj, sum(ncon));
    fprintf(file, '# of real_var = %d, # of bits of bin_var = %d, ', ...
        nreal, sum(nbin)); 
    fprintf(file, 'constr_violation, rank, crowding_distance\n');
    fprintf(file, '# gen = %d\n', gen);    
elseif(strcmp(header, 'best'))
    fprintf(file, '# This file contains the data of best population\n');
    fprintf(file, '# of objectives = %d, # of constraints = %d, ', ...
        nobj, sum(ncon));
    fprintf(file, '# of real_var = %d, # of bits of bin_var = %d, ', ...
        nreal, sum(nbin)); 
    fprintf(file, 'constr_violation, rank, crowding_distance\n');
    fprintf(file, '# gen = %d\n', gen);
end
fclose(file);
end