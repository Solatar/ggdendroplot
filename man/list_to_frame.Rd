% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/list_to_frame.R
\name{list_to_frame}
\alias{list_to_frame}
\title{create a data.frame from a named list}
\usage{
list_to_frame(setlist)
}
\arguments{
\item{setlist}{a named list of character vectors.}
}
\value{
a data.frame. Each column represents an item from the input list. Each row is a string that was present in the input lists. For each row, the items get a value of how many times the contained this rowname.
}
\description{
create a data.frame from a named list
}
\examples{
library(ggdendroplot)

set1 <- rownames(subset(mtcars, mpg>18))
set2 <- rownames(subset(mtcars, qsec>18))
set3 <- rownames(subset(mtcars, cyl<5))
carset <- list(highMpg=set1, highQsec=set2, lowCyl=set3)

df <- list_to_frame(carset)

}
