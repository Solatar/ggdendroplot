% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/geom_dendro.R
\name{geom_dendro}
\alias{geom_dendro}
\title{create a dendrogram in ggplot2}
\usage{
geom_dendro(
  clust,
  xlim = NULL,
  ylim = NULL,
  pointing = "updown",
  dendrocut = NULL,
  groupCols = NULL,
  axis.labels = TRUE,
  failsafe = TRUE,
  ...
)
}
\arguments{
\item{clust}{hclust object.}

\item{xlim}{vector with 2 numbers, on the x axis the dendrogram will beginn at the first number and end at the second.}

\item{ylim}{vector with 2 numbers, on the y axis the dendrogram will beginn at the first number and end at the second.}

\item{pointing}{string, either "side" or "updown" (default) to indicate where the dendrogram should point.}

\item{dendrocut}{integer, to use different colors in the dendrogram. The integer defines from which cluster downwards the color coding should occur. Imagine a line beeing drawn at that point. All clusters that originate from a cluster at that line will have the same color. The higher the integer the less colors you will see. Colors are preset but can also be defined by the user in the groupCol arguement.}

\item{axis.labels}{boolean, whether or not the axis should show the column names of data. This adds another layer to define the axis labels.}

\item{failsafe, }{boolean, if TRUE prevents the user from reversing the order of the dendrogram. That is solely because the hmReady function provides a data.frame the will have x and y values according to the original order of the dendrogram.}

\item{...}{Other arguments passed on to \code{\link[ggplot2:layer]{layer()}}. These are
often aesthetics, used to set an aesthetic to a fixed value, like
\code{colour = "red"} or \code{size = 3}. They may also be parameters
to the paired geom/stat.}

\item{groupCol}{character vector, each string should define a color. Defines the colors to be used if dendrocut is defined.}
}
\value{
a list of several ggplot2 layer objects (geom_path for the dendrogram) that can directly be added to a ggplot2 object
}
\description{
Imports:
ggplot2
}
\details{
the function uses geom_path for the dendrogram, so ... takes all arguements that geom_path would also take, such as color, size, etc.
}
\examples{
library(ggdendroplot)
library(ggplot2)

#test data.frame
df <- matrix(c(rnorm(64, mean=0), rnorm(64, mean=1)), ncol = 8, dimnames=list(
  rownames=paste0("trait",seq(16)),
  colnames=paste0("sample",seq(8))
))

#calculate a distance matrix and perform hierarchical clustering and rows and/or columns
rowclus <- hclust(dist( df ))
colclus <- hclust(dist( t(df) ))

#produce the graph
ggplot() + 
  geom_dendro(colclust)

#add a heatmap
ggplot() + 
  geom_tile(data=hm, aes(x=x, y=y, fill=value)) +
  geom_dendro(colclus, ylim=c(16.5, 20))

#make it pretty
ggplot() + 
  geom_tile(data=hm, aes(x=x, y=y, fill=value)) +
  scale_fill_gradientn(colors=hmGradient(), limits=c(-4,4)) + 
  geom_dendro(colclus, ylim=c(16.5, 20), dendrocut=6, groupCols = c("red","blue","black")) +
  geom_dendro(rowclus, xlim=c(8.5, 10), pointing="side", dendrocut=10) + 
  scale_x_continuous(expand=c(0,0), breaks=hm$x, labels=hm$variable) + 
  scale_y_continuous(expand=c(0,0), breaks=hm$y, labels=hm$rowid) +
  theme_hm()+ 
  theme(axis.title=element_blank()) 

#Note that in geom_dendro, this order is reversed if the limits are defined accordingly (if the first number is greater than the second), e.g.:
ggplot() + geom_dendro(colclust, xlim=c(3,0))

#=================================
#other plot examples
ggplot() + geom_dendro(colclust, pointing="side")
ggplot() + geom_dendro(colclust, ylim=c(3,0))
ggplot() + geom_dendro(colclust, size=2, color="blue", linetype="dashed")
ggplot() + geom_dendro(colclust, size=4, lineend="round")
ggplot() + geom_dendro(colclust, axis.labels = F)
 
}
