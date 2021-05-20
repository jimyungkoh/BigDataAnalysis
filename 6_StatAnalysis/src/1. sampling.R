#1 단순 임의 추출
#1-1 비복원 추출
str(iris)
dt <- iris$Petal.Length
dt
sample(dt, 10)


#1-2 복원 추출 replace에 'T' 값을 주면 복원 추출이 됌
sample(dt, 10, replace = T)

sample(1:5, 5)
sample(1:5, 5, replace = T)


#2 층화 임의 추출: sampling::strata
##층화 임의 추출법: 모집단이 몇 개의 계층(stratum)으로 구성되어 있을 때 각 계층 원소로부터 임의 추출
##install.packages("sampling")
library(sampling)

##2-1 strata, method='srswor' simple random sampling without replacement : 비복원 단순 임의 추출
## strata(dataframe or matrix, stratanames= "층화 추출에 사용할 변수들", size= "각 층의 크기",
##   method는 데이터를 추출하는 방법으로, 다음 4가지 중 하나로 지정한다.
## - srswor : 비복원 단순 임의 추출(Simple Random Sampling WithOut Replacement)
## - srswr : 복원 단순 임의 추출(Simple Random Sampling With Replacement)
## - poisson : 포아송 추출
## - systematic : 계통 추출
?strata
x <- strata(iris, stratanames =
            c("Species"), size=c(3, 3, 3), method="srswor")
x

getdata(iris, x)

##2-2 층마다 다른 수의 표본 추출 : method='srswr' : 복원 단순 임의 추출

strata(iris, stratanames = c("Species"), size=c(3, 2, 1), method="srswr")


#3 계통 추출 :  doBy::sample_by
##계통 임의 추출법: 무작위로 나열된 표본에서 일정한 시간, 공간적 간격을 두고 표본 추출
## 인자 systematic=T 로 계통 추출 수행
###install.packages("doBy")
library(doBy)
#?doBy

x <- data.frame(x = 1:10); x
sample_by(x, formula = ~1, frac = 0.5, systematic = T)
### '~'' 우측에 나열한 이름에 따라 데이터가 그룹으로 묶음
### frac=0.1: 추출할 샘플 비율 기본값은 10%
### replace: 복원 추출 여부
### data=parent.frame(): 데이터를 추출할 데이터 프레임
### systematic=FALSE: 계통 추출을 사용할지 여부

sample_by(iris, formula = ~Species, frac = 0.1, systematic = T)
