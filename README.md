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

They are parameters for the algorithm to solve a problem. For example,
if it's a real-valued problem, the parameters will look like this:

```
line 1: population size
line 2: number of generations
line 3: number of objectives
line 4: number of constraints (if no constraints, it's 0)
line 5: number of real-valued design variables
line 6 to 5+n: lower and upper bound of n design variables, per line
line 6+n: probability of crossover
line 6+n+1: probability of mutation
line 6+n+2: eta parameter for simulated binary crossover
line 6+n+3: eta parameter for polynomial mutation
line 6+n+4: 0 (no binary design variable)
```

If you have a binary-valued problem:

```
line 1: population size
line 2: number of generations
line 3: number of objectives
line 4: number of constraints (if no constraints, it's 0)
line 5: 0 (no real-valued design variable)
line 6: number of binary design variables
line 7 to 6+n: number of bits, lower bound, upper bound of n design variables, per line
line 7+n: probability of crossover
line 8+n: probability of mutation
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

## Differences from the original C code

- **Crowding distance.** The C code gives infinite distance only to the minimum end of each objective (`crowddist.c`). This version gives it to both ends, as in the NSGA-II paper (Deb et al., 2002). Results are the same for 2 objectives but can differ for 3 or more.
- **Test problems follow their published definitions**, not two bugs in the C code's `problemdef.c`:
  - **TNK:** the C code has a sign typo in the second constraint. This version uses the published constraint, (x₁ − 0.5)² + (x₂ − 0.5)² ≤ 0.5. It also guards against division by zero on x₂, the actual divisor, instead of x₁.
  - **ZDT5:** the C code counts only the first 4 bits of each 5-bit variable (`j < 4`), so one case of the formula never happens. This version counts all 5 bits.
- **Random numbers.** The C code has its own random number generator (`rand.c`). This version uses MATLAB/Octave's built-in Mersenne Twister, so a run can't be reproduced bit-for-bit against the C code, even with the same seed.
- **Input files.** The `.in` files here don't include the C code's gnuplot display settings at the end. Files from the C code still load, because those trailing lines are ignored.
