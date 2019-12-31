setwd("../logCabin/")
logCabin <- function(pathIn, pull = c("Name", 
                                       "User",
                                       "Partition",
                                       "Nodes",
                                       "Cores",
                                       "GPUs",
                                       "State",
                                       "Submit",
                                       "Start",
                                       "End",
                                       "Reserved walltime",
                                       "Used walltime",
                                       "Used CPU time",
                                       "% User \\(Computation\\)",
                                       "% System \\(I/O\\)",
                                       "Mem reserved",
                                       "Max Mem used",
                                       "Max Disk Write",
                                       "Max Disk Read"))
{
  #Pull outfiles
  outfiles <- list.files(pathIn, pattern = ".out",full.names = TRUE)
  outlist <- list()
  for(i in seq_along(outfiles)){
    tmp <- readLines(outfiles[i])
    #grep for strings in 'pull', collapse to modify and multi-match pattern
    reg <- grep(paste("^",pull, sep = "",collapse = " *:|"), tmp)
    #null out files with no profile data
    if(length(reg) == 0){
      outlist[[i]] <- NULL
      next
    }
    #Format for split on colon, trim whitespace
    split <- strsplit(tmp[reg], ": ")
    trim <- lapply(split, trimws)
    #subset second position of split list elements, name them as first position of split list elements
    outlist[[i]] <- setNames(sapply(trim, function(x)x[2]),sapply(trim, function(x)x[1]))
    #Add additional column using file name - req good cluster naming practices to be useful
    outlist[[i]] <- c("jobID" = gsub("\\.out$","",basename(outfiles[i])),outlist[[i]])
  }
  #Remove nulls and bind
  outlist[sapply(outlist, is.null)] <- NULL
  res <- do.call("rbind",outlist)
  return(res)
}

#examples
all <- logCabin("./test")
some <- logCabin("./test", pull = c("User","Reserved walltime","Used walltime","Mem reserved","Max Mem used"))


