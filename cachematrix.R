## Functions to Calculate and Cache Matrix Inversion

## Usage:
## m <- matrix(c(1,0,0,2),nrow=2, ncol=2)
## ma <- makeCacheMatrix(m)
## mb <- cacheSolve(ma)         // First Use
## mb <- cacheSolve(ma)         // Cached Use

## Need the MASS Package to use the ginv() function to invert matrices
library(MASS)

## Function anologous to a Class in Object-Oriented Programming Languages
## Defines the Set and Get Inverse Functions for a Matrix
## Use the Matrix Cache when called after the first time
makeCacheMatrix <- function(x = matrix()) {
    m <- NULL
    set <- function(y) {
        x <<- y
        m <<- NULL
    }
    get <- function() x
    setinv <- function(ginv) m <<- ginv
    getinv <- function() m
    list(set = set, get = get,
         setinv = setinv,
         getinv = getinv)
}

## cacheSolve = Matrix Inversion with Caching
## Returns the cached inverted matrix if available from previous calls
## It first calls the getinv function from the above function that return the matrix m
## if the matrix m is not null, it returns the cached value
## Otherwise, it calls teh setinv function to get the matrix' inverse which it caches and returns
cacheSolve <- function(x, ...) {
    m <- x$getinv()
    if(!is.null(m)) {
        message("getting cached data")
        return(m)
    }
    data <- x$get()
    m <- ginv(data, ...)
    x$setinv(m)
    m
}






