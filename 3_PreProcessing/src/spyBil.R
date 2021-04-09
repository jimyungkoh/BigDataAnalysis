#install.packages("magrittr")
library(quantmod)
library(PerformanceAnalytics)
library(magrittr)

ticker=c('SPY', 'TLT')
getSymbols(ticker)

prices= do.call(cbind,
                lapply(ticker, function(x) Ad(get(x))))
rets=Return.calculate(prices) %>% na.omit()

cor(rets)

portfolio = Return.portfolio(R=rets,
                             weights = c(0.6,0.4),
                             rebalance_on = 'months',
                             verbose = TRUE)
portfolios=cbind(rets, portfolio$returns) %>%
  setNames(c('SPY', 'TLT', '30대 70'))

charts.PerformanceSummary(portfolios, main='30대 70 포트폴리오')
