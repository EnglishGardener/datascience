# Matrix inversion is usually a costly computation and there may be some benefit
# to caching the inverse of a matrix rather than compute it repeatedly. The
# following two functions are used to cache the inverse of a matrix and 
# compute the inverse of a matrix when the inverse is not available.

# makeCacheMatrix creates a list containing a function to
# 1. set the value of the matrix
# 2. get the value of the matrix
# 3. set the value of inverse of the matrix
# 4. get the value of inverse of the matrix
makeCacheMatrix <- function(x = matrix()) {
  inverse <- NULL
  set <- function(y) {
    x <<- y
    inverse <<- NULL
  }
  get <- function() x
  setInverse <- function(solve) inverse <<- solve
  getInverse <- function() inverse
  list(set = set, get = get,
       setInverse = setInverse,
       getInverse = getInverse)
}

# The cacheSolve function returns the inverse of the matrix. It first checks if
# the inverse has already been computed. If so, it returns the cached result 
# directly and skips the computation. If not, it computes the inverse, sets the 
# value in the cache via setInverse function.

# This function assumes that the matrix is always invertible.

cacheSolve <- function(x, ...) {
  inverse <- x$getInverse()
  if(!is.null(inverse)) {
    message("getting cached data")
    return(inverse)
  }
  data <- x$get()
  inverse <- solve(data, ...)
  x$setInverse(inverse)
  inverse
}

## Sample run:
## > x = rbind(c(1, -1/4, 1), c(-1/4, 1, -1), c(-1, 1, 1/4))
## > m = makeCacheMatrix(x)
## > m$get()
##        [,1]  [,2]  [,3]
##  [1,]  1.00 -0.25  1.00
##  [2,] -0.25  1.00 -1.00
##  [3,] -1.00  1.00  0.25

## No cache in the first run
## > cacheSolve(m)
##          [,1]       [,2]       [,3]
##  [1,] 0.7207207  0.6126126 -0.4324324
##  [2,] 0.6126126  0.7207207  0.4324324
##  [3,] 0.4324324 -0.4324324  0.5405405

## Retrieving from the cache in the second run
## > cacheSolve(m)
## getting cached data.
##          [,1]       [,2]       [,3]
##  [1,] 0.7207207  0.6126126 -0.4324324
##  [2,] 0.6126126  0.7207207  0.4324324
##  [3,] 0.4324324 -0.4324324  0.5405405
## > 