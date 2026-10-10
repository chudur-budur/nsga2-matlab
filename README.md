nsga2-matlab
============

A very fast, almost 90% vectorized implementation of NSGA-II algorithm in MATLAB.

Possibly, it's the fastest in the town.

>NOTE: This is the MATLAB/OCTAVE implementation of [the original NSGA-II code](http://www.egr.msu.edu/~kdeb/codes/nsga2/nsga2-gnuplot-v1.1.6.tar.gz).

## Clone


```bash
git clone https://github.com/chudur-budur/nsga2-matlab
```

## How to use

Open the `nsga2-matlab` folder in MATLAB/OCTAVE and just run the `nsga2.m` file, simple.

A number of benchmark multi-objective optimization problems are defined in `problemdef` folder.
Each problem's corresponding standard algorithmic parameters are saved in `input_data` folder.

E.g. For `zdt1`, the problem is defined in `problemdef/zdt1.m` and the algorithm parameters
to solve this problem are defined in `input_data/zdt1.in`, etc.

