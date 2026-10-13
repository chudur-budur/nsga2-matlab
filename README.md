nsga2-matlab
============

A very fast, almost 90% vectorized implementation of NSGA-II algorithm in MATLAB.

Possibly, it's the fastest in the town.

>NOTE: This is the MATLAB/OCTAVE implementation of [the original NSGA-II code](http://www.egr.msu.edu/~kdeb/codes/nsga2/nsga2-gnuplot-v1.1.6.tar.gz).

## Cloning


```bash
git clone https://github.com/chudur-budur/nsga2-matlab
cd nsga2-matlab
```

## Running

#### GUI:

Open the `nsga2-matlab` folder in MATLAB/OCTAVE and just run the `nsga2.m` file, it's the main, simple.

If you want to run it from the CLI (turn off the plotting; `do_plot = false;` in `nsga2.m`, before running it):

#### MATLAB:

```bash
matlab -batch "nsga2"                                # R2019a or newer
matlab -nodisplay -nosplash -r "nsga2; exit"         # older versions
```
`-batch` exits by itself, and its exit code is non-zero if the script throws an error.

#### GNU OCTAVE:

```bash
octave --no-gui --quiet --eval "nsga2"
```

In both cases, if you want to save the population and results, set `do_save = true;` in `nsga2.m`. They will be saved in MATLAB data format `.mat` and the plain text format `.out` in the `nsga2-matlab` folder.

A number of benchmark multi-objective optimization problems are defined in `problemdef` folder.
Each problem's corresponding standard algorithmic parameters are saved in `input_data` folder.

E.g. For `zdt1`, the problem is defined in `problemdef/zdt1.m` and the algorithm parameters
to solve this problem are defined in `input_data/zdt1.in`, etc.

## FAQ

#### 1. What do the values in the files in `input_data` mean?

They are parameters for the algorithm to solve a problem:

```
line 1: population size
line 2: number of generations
line 3: number of objectives
line 4: number of constraints (if no constraints, it's 0)
line 5: number of design variables
line 6+n: lower and upper bound of n design variables, per line
line 6+n+1: probability of crossover
line 6+n+2: probability of mutation
line 6+n+3: eta parameter for simulated binary crossover
line 6+n+4: eta parameter for polynomial mutation
```

See `load_input_data.m` for the details.

#### 2. How do I define my own problem and parameter file for it?

Let's say you want to solve this multi-objective optimization
problem:

$$
\begin{aligned}
\min \quad & f_1(\mathbf{x}) = x_1^2 + x_2^2 \\
\min \quad & f_2(\mathbf{x}) = (x_1 - 1)^2 + 20 (x_2 - 2)^2 \\
\text{subject to} \quad & -5 \le x_i \le 5, \quad i = 1, 2
\end{aligned}
$$

Write a function to define the problem in `problemdef/example.m`:

```matlab
function [parent_pop] = example(parent_pop)

global nreal ;

x = parent_pop(:,1:nreal);
f1 = (x(:,1) .^ 2.0) + (x(:,2) .^ 2.0);
f2 = ((x(:,1) - 1.0) .^ 2.0) + (20.0 .* ((x(:,2) - 2.0) .^ 2.0));

parent_pop(:, (nreal+1)) = f1;
parent_pop(:, (nreal+2)) = f2;
end
```

Define the algorithm parameters in `input_data/example.in`:

```
100
100
2
0
2
-5 5
-5 5
0.9
0.5
10
10
0
1
1
2
```

Then refer to the parameter file at the top after the `global`
declarations in `nsga2.m`:

```matlab
load_input_data('input_data/example.in');
```

and then, the function in `obj_func`:

```matlab
obj_func = @example;
```

Now run `nsga2.m` file to solve it.
