## Running solve function to create the inverse of a matrix
## and caching results to improve process speed when run same calc in the future

## This is the cache for the matrix. Create list of functions to retrieve 
## the matrix and its inverse

makeCacheMatrix <- function(x = matrix()) {
          s = NULL
          set = function(y) {
                  x <<- y
                  s <<- NULL
          }
          get = function() x
          setsol = function(solve) s <<- solve
          getsol = function() s
          list(set = set, get = get,
                  setsol = setsol,
                  getsol = getsol)
}


## Calls the matrix from the function and either retrieves it from the cache or
## creates the inverse

cacheSolve <- function(x, ...) {
        ## Return a matrix that is the inverse of 'x'
          s = x$getsol()
          if(!is.null(s)) {
                  message("getting cached data")
                  return(s)
          }
          mat = x$get()
          s = solve(mat, ...)
          x$setsol(s)
          s
}
