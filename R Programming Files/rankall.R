rankall <- function(outcome, num) {
  
  outcomes <- read.csv("outcome-of-care-measures.csv", na.strings = "Not Available", stringsAsFactors = FALSE)
  
  outcomelist <- c("heart attack", "heart failure", "pneumonia")
  

    myindex <- c("heart attack" = 11, "heart failure" = 17, "pneumonia" = 23)
    ordered.outcomes <- outcomes[order(outcomes[,myindex[[outcome]]], outcomes[,2]),]
    split.ordered.outcomes <- split(ordered.outcomes[,c(2, myindex[[outcome]])],ordered.outcomes[,7])
    lapply_clean <- lapply(split.ordered.outcomes, na.omit)
    
    lapply(lapply_clean, function(data){
        df.prep <- data[num,1]
        df.prep
        data.frame(hospital = unlist(df.prep), row.names = names(df.prep))
        
    })
}