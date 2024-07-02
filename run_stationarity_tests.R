"run_stationarity_tests" = function(time_series) {
  # Run tests and store the results
  adf_none = adfTest(time_series, type='nc')
  adf_constant = adfTest(time_series, type="c")
  adf_trend = adfTest(time_series, type="ct")
  kpss_level = kpss.test(time_series)
  kpss_trend = kpss.test(time_series, null="Trend")
  
  # Extract p-values and statistics
  p_values = c(adf_none@test$p.value, adf_constant@test$p.value, 
               adf_trend@test$p.value, kpss_level$p.value, kpss_trend$p.value)
  
  test_statistics = c(adf_none@test$statistic, adf_constant@test$statistic, 
                      adf_trend@test$statistic, kpss_level$statistic, kpss_trend$statistic)
  
  
  # Determine stationarity at 95% confidence interval
  # ADF test: null hypothesis is non-stationary, reject null if p-value < 0.05
  # KPSS test: null hypothesis is stationary, reject null if p-value < 0.05
  stationarity = c(ifelse(p_values[1] < 0.05, "Stationary", "Non-Stationary"),
                   ifelse(p_values[2] < 0.05, "Stationary", "Non-Stationary"),
                   ifelse(p_values[3] < 0.05, "Stationary", "Non-Stationary"),
                   ifelse(p_values[4] < 0.05, "Non-Stationary", "Stationary"),
                   ifelse(p_values[5] < 0.05, "Non-Stationary", "Stationary"))
  
  # Create a data frame
  test_results = data.frame(
    Test = c("ADF (zero-mean)", "ADF (single-mean)", "ADF (time-trend)", 
             "KPSS (level)", "KPSS (trend)"),
    Statistic = test_statistics,
    P_Value = p_values,
    Stationarity = stationarity)
  
  # Print the data frame
  print(test_results)
}