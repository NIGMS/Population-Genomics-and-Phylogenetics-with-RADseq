##### Script to add bootstraps from file to a single best tree from paup 
##### run from command line : Rscript bootanno.R besttree.tre bootfile.tre
##### requires .tre ending on best file

library(ape)

#load in trees
best.tree.file <- commandArgs(trailingOnly = TRUE)[[1]] # best tree from SVDQ with command line format
boot.file <- commandArgs(trailingOnly = TRUE)[[2]] #file of bootstrap trees from PAUP with command line format

boottrees <- read.nexus(boot.file) 
besttree<- read.nexus(best.tree.file)

boot <- prop.clades(besttree, boottrees) #calculates bootstrap support on each branch (not nodes because it's unrooted)
boot[is.na(boot)] <- 0 #replace NAs with 0
numboots <- length(boottrees) # nreps of bootstrapping
bootprop <- round((boot/numboots)*100, digits = 2) #gives a proportion of bootstrap support (converts to percentage)

besttree$node.label <- bootprop #put bootstrap values on nodes of the tree
write.tree(besttree, file=gsub(".tre$", "_boot.tre", best.tree.file)) #write new tree file with same name as the best tree with "_boot.tre" added to end
 



