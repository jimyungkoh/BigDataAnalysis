#1 단순 임의 추출
#1-1 비복원 추출
str(iris)
dt <- iris$Petal.Length
dt
sample(dt, 10)


#1-2 복원 추출
sample(dt, 10, replace = T)

sample(1:5, 5)
sample(1:5, 5, replace = T)


#2 층화 임의 추출: sampling::strata
install.packages("sampling")
library(sampling)

##2-1 strata, method='srswor' simple random sampling without replacement : 비복원 단순 임의 추출
?strata
x <- strata(iris, stratanames = c("Species"), size=c(3, 3, 3), method="srswor")
x

getdata(iris, x)

##2-2 층마다 다른 수의 표본 추출 : method='srswr' : 복원 단순 임의 추출
strata(iris, stratanames = c("Species"), size=c(3, 2, 1), method="srswr")


#3 계통 추출 :  doBy::sample_by
## 인자 systematic=T 로 계통 추출 수행
###install.packages("doBy")
library(doBy)

x <- data.frame(x = 1:10); x
sample_by(x, formula = ~1, frac = 0.5, systematic = T)
sample_by(iris, formula = ~Species, frac = 0.1, systematic = T)
