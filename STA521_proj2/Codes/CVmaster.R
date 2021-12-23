# We design two functions of CVmaster for our two types of splitting 
# Before we run the functions, we have to load the respective blocks into R
blocks_1 <- readRDS("./rds/blocks_1.rds")
blocks_2 <- readRDS("./rds/blocks_2.rds")

# For Type-1 splitting:
CVmaster_1 <- function(classifier, features, label, K, loss, prob = 1, neighbor = 5){
  blocks <- blocks_1
  # create folds
  folds <- lapply(1:K, function(k){
    data.frame()
  })
  # split labels to folds
  for(i in 1:2) {
    block <- blocks[[i]]
    n <- nrow(block)
    shuffle <- sample(x = 1:n, size = floor(n * prob))
    size = floor(length(shuffle) / K)
    for(k in 1:K) {
      id <- shuffle[((k-1) * size + 1):(k * size)]
      folds[[k]] <- rbind(folds[[k]], block[id, ])
    }
  }
  # model
  rs <- c()
  for(k in 1:K) {
    train <- folds[-k] %>% reduce(union)
    test <- folds[[k]]
    X_train <- train %>% dplyr::select(features)
    y_train <- train %>% dplyr::pull(label)
    X_test <- test %>% dplyr::select(features)
    y_test <- test %>% dplyr::pull(label)
    
    # logistic regression
    if(classifier == "logi") {
      y_train[y_train == -1] = 0
      fit <- glm(label ~ ., data = bind_cols(X_train, label = y_train), 
                 family = "binomial")
      resp <- predict(fit, newdata = X_test, type = "response")
      pred <- ifelse(resp >= 0.5, 1, -1)
      rs <- c(rs, loss(y_test, pred))
    } 
    # knn
    else if(classifier == "knn") {
      fit <- knn(X_train, X_test, cl = y_train, k = neighbor)
      rs <- c(rs, loss(y_test, fit))
    } 
    # qda
    else if(classifier == "qda") {
      fit <- qda(label ~ ., data = bind_cols(X_train, label = y_train))
      pred <- predict(fit, newdata = X_test)
      rs <- c(rs, loss(y_test, pred$class))
    } 
    # lda
    else if(classifier == "lda") {
      fit <- lda(label ~ ., data = bind_cols(X_train, label = y_train))
      pred <- predict(fit, newdata = X_test)
      rs <- c(rs, loss(y_test, pred$class))
    } 
    # naive bayes
    else if(classifier == "nb") {
      fit <- naiveBayes(label ~ ., data = bind_cols(X_train, label = y_train))
      pred <- predict(fit, newdata = X_test)
      rs <- c(rs, loss(y_test, pred))
    }
    else {
      stop("The classifier is not valid!")
    }
  }
  
  # result
  return(rs)
}

# For Type-2 splitting:
CVmaster_2 <- function(classifier, features, label, K, loss, prob = 1, neighbor = 5){
  blocks <- blocks_2
  # create folds
  folds <- lapply(1:K, function(k){
    data.frame()
  })
  # split blocks to folds
  for(i in 1:16) {
    block <- blocks[[i]]
    n <- nrow(block)
    size = floor(n / K * prob)
    for(k in 1:K) {
      id <- ((k-1) * size + 1):(k * size)
      folds[[k]] <- rbind(folds[[k]], block[id, ])
    }
  }
  # model
  rs <- c()
  for(k in 1:K) {
    train <- folds[-k] %>% reduce(union)
    test <- folds[[k]]
    X_train <- train %>% dplyr::select(features)
    y_train <- train %>% dplyr::pull(label)
    X_test <- test %>% dplyr::select(features)
    y_test <- test %>% dplyr::pull(label)
    
    # logistic regression
    if(classifier == "logi") {
      y_train[y_train == -1] = 0
      fit <- glm(label ~ ., data = bind_cols(X_train, label = y_train), 
                 family = "binomial")
      resp <- predict(fit, newdata = X_test, type = "response")
      pred <- ifelse(resp >= 0.5, 1, -1)
      rs <- c(rs, loss(y_test, pred))
    } 
    # knn
    else if(classifier == "knn") {
      fit <- knn(X_train, X_test, cl = y_train, k = neighbor)
      rs <- c(rs, loss(y_test, fit))
    } 
    # qda
    else if(classifier == "qda") {
      fit <- qda(label ~ ., data = bind_cols(X_train, label = y_train))
      pred <- predict(fit, newdata = X_test)
      rs <- c(rs, loss(y_test, pred$class))
    } 
    # lda
    else if(classifier == "lda") {
      fit <- lda(label ~ ., data = bind_cols(X_train, label = y_train))
      pred <- predict(fit, newdata = X_test)
      rs <- c(rs, loss(y_test, pred$class))
    } 
    # naive bayes
    else if(classifier == "nb") {
      fit <- naiveBayes(label ~ ., data = bind_cols(X_train, label = y_train))
      pred <- predict(fit, newdata = X_test)
      rs <- c(rs, loss(y_test, pred))
    }
    else {
      stop("The classifier is not valid!")
    }
  }
  
  # result
  return(rs)
}