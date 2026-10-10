function pprint(message, data)
%PPRINT  Prints a message and, optionally, some data.
%
%   pprint(message) prints message with fprintf(), so escape
%   sequences like '\n' work.
%   pprint(message, data) prints the message, then disp(data).
%
%   A pretty printer for arbitrary data. It takes two arguments,
%   first is message, and the data (matrix/array). If there is no
%   data, only the message will be printed.

fprintf(message)
if (exist('data', 'var')) 
    disp(data)
end

