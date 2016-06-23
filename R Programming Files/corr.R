corr <- function(directory, threshold = 0) {
        files_full <- list.files(directory,full.names=TRUE)
        dat <- data.frame()
        cleandat <- data.frame()
        results <- numeric()
        idx <- 1
                for (i in 1:332) {		
                      dat <- read.csv(files_full[i])
                      good <- complete.cases(dat)
                      cleandat <- dat[good,]
                            if(length(cleandat[,1]) > threshold){
                                      results[idx] <- cor(cleandat[,"nitrate"],cleandat[,"sulfate"])
                            }
                      idx <- idx + 1
                }
        results
} 