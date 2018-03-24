#' This generates the ngrams for the text corpus
#'
#'
#' This implements the application layer over the text mining layer used
#' for preprocessing. We explore the unigrams, bigrams, trigrams and
#' eventually ngrams
#'
#'
#'

source("scripts/globals.R")
source("helper/helper.R")




t1 <- Sys.time()
x<- get.ngrams(dat, 2)
t2 <- Sys.time()




#' Gets the ngram info as a list of class character
#'
#' Takes in a file of cleansed strings

get.ngrams <- function(txt, n) {

  #'@param txt text corpus
  #'@param n ngram

  group.numbers <- get.group.numbers(number.workers, length(txt))

  corpus.txt <- as.data.frame(group.numbers)

  corpus.txt$txt <- txt

  clusters <- create_cluster(number.workers, quiet = TRUE)

  group.corpus.txt <- multidplyr::partition(corpus.txt, group.numbers)

  group.corpus.txt <-
  group.corpus.txt %>%
    cluster_library("multidplyr") %>%
    cluster_library("dplyr") %>%
    cluster_assign_value("n", 2) %>%
    cluster_assign_value("t", t)

  group.corpus.txt %>%
    mutate(ntoken <- t(txt)) %>%
    combine()

  return(group.corpus.txt)

}







#' Generate Tokens
#'
#' It takes in a line of text and the ngram detail to give you
#' the parsed string

t <- function(txt, n){

  #' @param txt line of text to split
  #' @param n number of words you want(ngram)

  return(RWeka::NGramTokenizer(txt, RWeka::Weka_control(min = n, max = n, delimiters = " \\r\\n\\t")))

}









