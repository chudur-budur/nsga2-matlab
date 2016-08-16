Do these first
===============

  1. write all benchmark test functions
    - `ctp1` - `ctp8`    
  3. binary problems `zdt5`
  2. compare with `nsga2-c`, `ecj`, `moea-framework`, `jemtal`, `paradiseo`

Do these later
==============

  3. fine tune the data saving script save_plots.m
    - axis font and size, for latex.
    - reduce extra borders.
    - if possible, get rid off the `show_plots` function totally.
    - look closely into `gcf`, `gca`, `gco` craps.
  4. test `betaq` computation with `bsxfun` in `real_cross`, also couple of other statements that can be optimized with `bsxfun`.
  5. vectorize the functions in `rand` or call the `c` functions using `mex`.
