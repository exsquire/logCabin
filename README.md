# logCabin
The house that logs built. Compiles profile data from SLURM outfile directory into an R matrix.

**Purpose:** Parallel array jobs can generate hundreds/thousands of outfiles containing useful profile data. Having this data in a matrix format makes summarizing and optimizing job performance easy.  

**Method:** Iteratively grep SLURM profile keywords from outfile directory, text-process, and combine into matrix. 

**Suggested Use:** 
- cd to relevant project folder
- Open interactive R session
- source logCabin.R or copy-paste function
- ```logDF <- logCabin("./logDirectory") ```
- ```write.csv(logDF, "./desired/location/logDF.csv") ```

**OR**

- modify code: 
    - remove setwd() and #examples, leaving only the function
    - set pathIn parameter default to "./", ```pathIn = "./"```  
    - Replace ```return(res)``` with ```write.csv(logDF, "./desired/location/logDF.csv")```
    - cd to relevant logs folder
    - on commandline ```> Rscript logCabin.R```
               


