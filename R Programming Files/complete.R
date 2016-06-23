complete <- function(directory, id = 1:332) {
            files_full <- list.files(directory,full.names=TRUE)
            dat <- data.frame()
            for (i in id) {		
                  good <- complete.cases(read.csv(files_full[i]))
                  dat <- rbind(dat,cbind(read.csv(files_full[i])[1,"ID"],length(read.csv(files_full[i])[good,1])))
            }
            colnames(dat) <- c("id","nobs")
            dat
}