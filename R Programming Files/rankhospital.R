rankhospital <- function(state, outcome, num) {
  
  outcomes <- read.csv("outcome-of-care-measures.csv", na.strings = "Not Available", stringsAsFactors = FALSE)
  
  outcomelist <- c("heart attack", "heart failure", "pneumonia")
  
  if(all(state != outcomes$State)) {
    stop("invalid state")
    
      } else if(all(outcome != outcomelist)) {
        stop("invalid outcome")
        
          } else {
              myindex <- c("heart attack" = 11, "heart failure" = 17, "pneumonia" = 23)
              ordered.outcomes <- outcomes[order(outcomes[,myindex[[outcome]]], outcomes[,2]),]
              split.ordered.outcomes <- split(ordered.outcomes[,c(2, myindex[[outcome]])],ordered.outcomes[,7])
              lapply_clean <- lapply(split.ordered.outcomes, na.omit)
              lapply(lapply_clean[[state]]["Hospital.Name"], function(data){
                  if(num == "best"){
                  data[1]
                  } else if(num == "worst"){
                    data[nrow(lapply_clean[[state]]["Hospital.Name"])]
                  } else data[num]
                })
              }
}