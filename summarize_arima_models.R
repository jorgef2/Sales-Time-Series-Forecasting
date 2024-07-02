"summarize_arima_models" <- function(...){
  models <- list(...)
  
  get_sarima_order <- function(model) {
    non_seasonal_orders <- model$arma[c(1, 6, 2)] # p, d, q
    seasonal_orders <- model$arma[c(3, 7, 4)]    # P, D, Q
    seasonal_period <- model$arma[5]             # s
    
    return(paste0("SARIMA(", 
                  non_seasonal_orders[1], ",", 
                  non_seasonal_orders[2], ",", 
                  non_seasonal_orders[3], ")(", 
                  seasonal_orders[1], ",", 
                  seasonal_orders[2], ",", 
                  seasonal_orders[3], ")[", 
                  seasonal_period, "]"))
  }
  
  model_summaries <- lapply(models, function(model) {
    # Number of parameters
    num_params <- length(model$coef)
    
    # AIC
    aic <- AIC(model)
    
    # BIC
    bic <- BIC(model)
    
    # Sigma^2
    sigma2 <- model$sigma2
    
    # Residual autocorrelation (first lag)
    residuals <- residuals(model)
    autocorr <- acf(residuals, plot = FALSE)
    ACF1 <- autocorr$acf[2]
    
    # Ljung-Box test
    lb_test <- Box.test(residuals, lag = 10, type = "Ljung-Box")
    lb_pvalue <- lb_test$p.value
    
    return(data.frame(
      Num_Params = num_params,
      AIC = aic,
      BIC = bic,
      Sigma2 = sigma2,
      ACF1 = ACF1,
      Ljung_Box_pvalue = lb_pvalue
    ))
  })
  
  # Combine all summaries into one data frame
  summary_table <- do.call(rbind, model_summaries)
  
  # Set row names to the SARIMA orders
  rownames(summary_table) <- sapply(models, get_sarima_order)
  
  return(summary_table)
}

