#' Create a Term Document Matrix from a large blob of words.
#'
#' Term Document Matrix is created after the following transformations
#' 1. Convert the complete document to lower case
#' 2. All Numbers are removed
#' 3. All stop words are removed assuming that the doc is in english
#' 4. Punctuations are removed
#' 5. Whitespaces are removed
#'
#' A matrix is returned to the user for further processing

create.tdm <-
  function(data) {
    ## Accepts character input

    rawdata <- paste(data, collapse = " // ")

    docs <- Corpus(VectorSource(rawdata))

    docs <- tm_map(docs, content_transformer(tolower))

    docs <- tm_map(docs, removeNumbers)

    docs <- tm_map(docs, removeWords, stopwords("english"))

    docs <- tm_map(docs, removePunctuation )

    docs <- tm_map(docs, stripWhitespace)

    tdm <- as.matrix(TermDocumentMatrix(docs))

    return(tdm)

  }



#' I'll take the number of workers you need and the length of the dataframe
#' I'll give you the list containing the group numbers that you can then
#' attach as a column to the
get.group.numbers <- function(number.workers, length.obs){

  group.numbers <- NULL

  if(number.workers <=1) {
    print("Parallel processing not possible.....")
    group.numbers <- -1} # sending -1 if parallel not possible

  else{
    seq.tail <- length.obs %% number.workers

    if(seq.tail == 0){

      first.group.limit <- (length.obs - seq.tail)/number.workers

      group.numbers <- rep(1:number.workers, first.group.limit)

    }

    else{
      first.group.limit <- (length.obs - seq.tail)/number.workers

      first.group <- rep(1:number.workers, first.group.limit)

      second.group <- 1:seq.tail

      group.numbers <- c(first.group, second.group)
    }
  }

  return(group.numbers)

}


