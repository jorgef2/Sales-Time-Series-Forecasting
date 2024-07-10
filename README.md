# Time Series Forecasting with SARIMA
Forecasting retail sales using ARIMA models in R.

### Project Overview
The goal of this project is to explore and forecast weekly retail sales of a global superstore to provide actionable insights regarding customer behavior. Autoregressive integrated moving average (ARIMA) models will be used for this analysis, following a Box-Jenkings methodology.

### Data Sources
The primary dataset for this analysis comes from kaggle. The dataset consists of retail sales for a global superstore over a 4-year period between January 2015 through December of 2018. There are 9,800 rows, and each row represents an individual sales order and includes information about the order including the order date, ship date, shipping method, customer information, product information, and the sale price. The raw dataset an irregular time series with multiple sale orders on some days and no sale orders on others. The data will be aggregated into a weekly regular time series to facilitate this analysis.
[Download here](https://www.kaggle.com/datasets/apoorvaappz/global-super-store-dataset).

### Tools
- R - [Download here](https://cran.r-project.org/bin/windows/base/)

### Data Cleaning/Preparation
In the initial data preparation phase, I performed the following tasks:
1. Data loading and inspection
2. Data Formatting
3. Aggregating data into weekly time series

### Exploratory Data Analysis
EDA to find meaningful relationships to aid in choosing a direction of investigation. These preliminary visualizations included:
- Bar charts of sales by category (Technology, Furniture, Office Supplies)
- Density plots of log(sales)
- Sales time plots with different aggregations (daily, weekly, monthly)
- Sales per month-of-year and day-of-month

### Analyzing Total Weekly Sales for Normality, Stationarity, and Seasonality
After exploring the data, the most interesting direction of analysis for me was forecasting total sales with a weekly aggregation. The analysis began with an evaluation of the normality, trends, stationarity, and seasonality of the time series using relevant visualizations and tests, shown below:
![grid_plot](https://github.com/jorgef2/Sales-Time-Series-Forecasting/assets/135895624/7dff39fc-0ba4-44e3-9cfe-04a662a3304d)
![ADF_KPSS_tests](https://github.com/jorgef2/Sales-Time-Series-Forecasting/assets/135895624/e674f73f-fe33-4b1c-9b47-059218f96a4f)
![t-test](https://github.com/jorgef2/Sales-Time-Series-Forecasting/assets/135895624/223a2269-9e32-4194-91ba-7cd6e6577721)

*Interpreting Plots*
- Time Series Plot:
  - Shows a clear annual trend. The LOESS smooth line might show a possible weak multiplicative seasonal effect, despite weekly fluctuations seeming to not increase with sales values.
- Decomposition Plots:
  -  The seasonality is smaller than the remainder​
  -  Remainder is unstructured
- ACF and PACF Plots:
  - The ACF plot indicates exponential decay and a one-year cyclical pattern, suggesting the series might be stationary and suitable for an autoregressive model. 
  - Both ACF and PACF plots show some seasonality at around 52 weeks 
  - ACF plot shows exponential decay, indicating stationarity and that an AR model might be appropriate 
  - The PACF plot shows 2 significant lags, so maybe an AR(2) model
- Normal Q-Q Plot
  - Clearly Non-normal distribution
 
*Interpreting Tests*
- KPSS test indicates it is not level stationary.​
- 1st Differences t-test: Mean of the first differences is not significantly different from zero ​
  - Any trend in the original series is likely stochastic rather than deterministic.​
 
### 2-Stage Difference
![2diff_grid_plot](https://github.com/jorgef2/Sales-Time-Series-Forecasting/assets/135895624/38f60888-9ae0-4621-b405-139a709a3b67)

Considering the 52-week cyclical pattern identified in the ACF plot, a second-order differencing of the series was performed to determine the parameters for a potential SARIMA model, shown above.
- The distribution is now more normal (jarque-bera test cannot reject normality)​
- ACF Plot: Significant spikes at lags 1 and 52 ​
- PACF Plot: Several significant lags, but mostly decreasing; significant spike at lag 51 ​
- EACF: Looks like ARMA(0,1) ​

Altogether these plots seem to indicate a SARIMA(0,1,1)(0,1,1)[52] model ​

### Model Fitting & Diagnostics
Next, I began building some models. The first one tried was the one outlined on the previous slide. I then iterated through a bunch of different model architectures. The following table shows some of the best performing models, including those that included a Box-Cox transform and those that did not.  
![models_diagnostics](https://github.com/jorgef2/Sales-Time-Series-Forecasting/assets/135895624/eb4fecdc-fec7-4efb-af7b-043f550cad78)

Models with Box-Cox transformation (λ = 0.84) have significantly lower AIC and BIC values compared to those without. Given the data, the λ transformed SARIMA(0,1,1)(0,1,1)[52] seems to be the best overall model – it has the lowest AIC, BIC, and a reasonably good p-value. It is also the most parsimonious, balancing fit and complexity well.

### Backtesting & Forecasts
Based on the backtesting shown below, the SARIMA(0,1,1)(0,1,1)[52] is indeed the best-performing model. An ACF plot of the residuals shows some significant lags, though it appears to be mostly white noise. A 1-year forecast of the sales using this model shows that it seems to capture the overall trend and seasonality well.
![final](https://github.com/jorgef2/Sales-Time-Series-Forecasting/assets/135895624/d1bc0a50-6ce4-44f0-ad15-fa5fe9736d59)

