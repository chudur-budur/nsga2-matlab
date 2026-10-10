function load_input_data (datafile)
%LOAD_INPUT_DATA  Reads the algorithm parameters from a .in file.
%
%   load_input_data(datafile) reads datafile (e.g. 'input_data/zdt1.in')
%   and populates the global variables listed below, then prints them.
%   This is similar to the original nsga2 c code's main() function
%   where the program starts by reading the algorithm parameters.
%
%   The file has one value per line (bounds are on the same line),
%   in this order --
%
%       popsize
%       ngen
%       nobj
%       ncon
%       nreal
%   if nreal > 0:
%       min_realvar(1) max_realvar(1)       <- one line per variable
%       ...
%       pcross_real
%       pmut_real
%       eta_c
%       eta_m
%   else (binary):
%       nbin
%       nbits(1) min_binvar(1) max_binvar(1)  <- one line per variable
%       ...
%       pcross_bin
%       pmut_bin
%
%   Globals set:
%       popsize, ngen, nobj, ncon, nreal, min_realvar, max_realvar,
%       pcross_real, pmut_real, eta_c, eta_m, nbin, nbits, min_binvar,
%       max_binvar, pcross_bin, pmut_bin
%
%   Note: popsize should be a multiple of 4, since selection() makes
%   four children at a time.

global popsize ;
global ngen ;
global nobj ;
global ncon ;
global nreal ;
global min_realvar ;
global max_realvar ;
global pcross_real ;
global pmut_real ;
global eta_c ;
global eta_m ;
global nbin ;
global nbits ;
global min_binvar ;
global max_binvar ;
global pcross_bin ;
global pmut_bin ;

data = dlmread(datafile);

% the first five values are common to both encodings
popsize = data(1,1);
ngen = data(2,1);
nobj = data(3,1);
ncon = data(4,1);
nreal = data(5,1);
if (nreal ~= 0)
    % real-coded problem, cur_index walks down the file
    cur_index = 6 ;
    min_realvar = data(cur_index:(cur_index + nreal)-1, 1);
    max_realvar = data(cur_index:(cur_index + nreal)-1, 2);
    cur_index = cur_index + nreal ;
    pcross_real = data(cur_index, 1);
    pmut_real = data(cur_index + 1, 1);
    cur_index = cur_index + 2;
    eta_c = data(cur_index, 1);
    eta_m = data(cur_index + 1, 1);
else
    % binary-coded problem
    nbin = data(6,1);
    cur_index = 7 ;
    nbits = data(cur_index:(cur_index + nbin)-1, 1);
    min_binvar = data(cur_index:(cur_index + nbin)-1, 2);
    max_binvar = data(cur_index:(cur_index + nbin)-1, 3);
    cur_index = cur_index + nbin ;
    pcross_bin = data(cur_index, 1);
    pmut_bin = data(cur_index + 1, 1);
end

% print everything that was read
fmt = [ 'popsize: ',		num2str(popsize)        ]; disp(fmt)
fmt = [ 'ngen: ',           num2str(ngen)           ]; disp(fmt)
fmt = [ 'nobj: ',           num2str(nobj)           ]; disp(fmt)
fmt = [ 'ncon: ',           num2str(ncon)           ]; disp(fmt)
fmt = [ 'nreal: ',          num2str(nreal)          ]; disp(fmt)
fmt = [ 'min_realvar: ',	num2str(min_realvar')	]; disp(fmt)
fmt = [ 'max_realvar: ',	num2str(max_realvar')	]; disp(fmt)
fmt = [ 'pcross_real: ',	num2str(pcross_real)	]; disp(fmt)
fmt = [ 'pmut_real: ',		num2str(pmut_real)      ]; disp(fmt)
fmt = [ 'eta_c: ',          num2str(eta_c)          ]; disp(fmt)
fmt = [ 'eta_m: ',          num2str(eta_m)          ]; disp(fmt)
fmt = [ 'nbin: ',           num2str(nbin)           ]; disp(fmt)
fmt = [ 'nbits: ',          num2str(nbits')         ]; disp(fmt)
fmt = [ 'min_binvar: ',		num2str(min_binvar')	]; disp(fmt)
fmt = [ 'max_binvar: ',		num2str(max_binvar')	]; disp(fmt)
fmt = [ 'pcross_bin: ',		num2str(pcross_bin)     ]; disp(fmt)
fmt = [ 'pmut_bin: ',		num2str(pmut_bin)       ]; disp(fmt)

end

