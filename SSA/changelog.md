# Changelog

## SSA


|Date   |Name   |New File or Revision   |File Name   |Branch   |Changes   |Problems Remaining   |
|:-:|:---:|:---:|:---:|:---:|:---:|:---:|
| May 26, 2015  | Ella  | New File  | TauLeapVectorized  |  Master |  Vectorized the loops |  Make compatible for more than 3 reactions |
| May 26, 2015  | Ella  | New File  | SSATestTauLeap  | Master  | Uses vectorization to calc. tau leap faster. Added an additional symbol for plotting 5 simulation.  | Method to prevent a substance from depletion. Consistency between simulations.  |
| May 27, 2015  | Chris/Ella  | Revision  | SSATestTauLeap  | Master |  Changed colours to ['b','r','g'] for [x1,x2,y] plots. Also added a list of symbols randomly selected when plotting. Changed symbol plot size to 12. | Incorporate modified poisson for determining critical reactions.  |
| May 27, 2015  | Ella |  New File |  genRj | Master  | Determines critical reations. Outputs a vector of 0's and 1's indicating which reactions are critical.   |  Integrating with main program. Using the outputed variable to determine whether tau generation needs to include critical reactions. Using Vectorization. |
| May 28, 2015  | Chris  |New File   |  Smallep_1sim.fig |  Master | Added figure of a plot with a small epsilon  | Speed up time |
|   |   |   |   |   |   |   |
|   |   |   |   |   |   |   |
|   |   |   |   |   |   |   |
|   |   |   |   |   |   |   |
|   |   |   |   |   |   |   |
|   |   |   |   |   |   |   |
|   |   |   |   |   |   |   |
|   |   |   |   |   |   |   |

