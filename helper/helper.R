#' Create a Term Document Matrix from a large blob of words.
#'
#' the Term Document Matrix is created after the following transformations
#' 1. Convert the complete document to lower case
#' 2. All Numbers are removed
#' 3. All stop words are removed assuming that the doc is in english
#' 4. Punctuations are removed
#' 5. Whitespaces are removed
#'
#' A matrix is returned to the user for further processing

createTDM <-
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



