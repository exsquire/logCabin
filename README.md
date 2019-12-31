# logCabin
The house that logs built. Compiles profile data from SLURM outfile directory into an R matrix.

**Purpose:** Parallel array jobs can generate hundreds/thousands of outfiles containing useful profile data. Having this data in a matrix format makes summarizing and optimizing job performance easy.  

**Method:** Iteratively grep SLURM profile keywords from outfiles, text process, and combine into matrix. 


