# Time Series Forecasting with SARIMA
Forecasting retail sales of a using ARIMA models in R.

### Project Overview
The goal of this project is to explore and forecast weekly retail sales of a global superstore to provide create actionable insights regarding customer behavior. Autoregressive integrated moving average (ARIMA) models will be used for this analysis, following a Box-Jenkings methodology.

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

*Interpreting Plots/Tests*
- Time Series Plot:
  - Shows a clear annual trend. The LOESS smooth line might show a possible weak multiplicative seasonal effect, despite weekly fluctuations seeming to not increase with sales values.
- Decomposition Plots:
  -  The seasonality is smaller than the remainder​
  -  Remainder is unstructured
- ACF and PACF Plots:
  - The ACF plot indicats exponential decay and a one-year cyclical pattern, suggesting the series might be stationary and suitable for an autoregressive model. 
  - Both ACF and PACF plot show some seasonality at around 52 weeks 
  - ACF plot shows exponential decay, indicating stationarity and that an AR model might be appropriate 
  - The PACF plot shows 2 significant lags, so maybe an AR(2) model
- Normal Q-Q Plot
  - Clearly Non-normal distribution



