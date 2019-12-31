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
  outfiles <- list.files(pathIn, pattern = ".out",full.names = TRUE)
  outlist <- list()
  for(i in seq_along(outfiles)){
    tmp <- readLines(outfiles[i])
    reg <- grep(paste("^",pull, sep = "",collapse = " *:|"), tmp)
    if(length(reg) == 0){
      outlist[[i]] <- NULL
      next
    }
    #Check if matches are sequential
    stopifnot(all(abs(diff(reg)) == 1))
    
    pos <- reg[1]
    
    split <- strsplit(tmp[pos:length(tmp)], ": ")
    trim <- lapply(split, trimws)
    outlist[[i]] <- setNames(sapply(trim, function(x)x[2]),sapply(trim, function(x)x[1]))
    outlist[[i]] <- c("jobID" = gsub("\\.out$","",basename(outfiles[i])),outlist[[i]])
  }
  
  outlist[sapply(outlist, is.null)] <- NULL
  res <- do.call("rbind",outlist)
  return(res)
}

test <- logCabin("test")



