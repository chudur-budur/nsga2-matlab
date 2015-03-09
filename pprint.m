function pprint(message, data)
%   A pretty printer for arbitrary data. It takes two arguments, 
%   first is message, and the data (matrix/array). If there is no
%   data, only the message will be printed.

fprintf(message)
if (exist('data', 'var')) 
    disp(data)
end

