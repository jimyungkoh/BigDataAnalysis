#1 기술 통계
df <- read.csv("6_StatAnalysis/data/example_studentlist.csv")
df

attach(df)
View(df)
## 평균
mean(height)

##중앙값
median(height)

## 범위
range(height)

## 사분위
quantile(height)

## 사분위범위 IQR
IQR(height)

## 평균, 중앙값, 최소값, 최대값, Q1, Q3 한번에 보기
summary(height)

## 분산
var(height)

## 표준편차(Standard Deviation)
sd(height)

## 표준화
scale(height)

## 변동계수 : 함수가 따로 없어 계산해 줌. 표준편차 / 평균
sd(height) / mean(weight)
sd(weight) / mean(height)

## 공분산
var(height, weight)
cov(height, weight)

## 상관계수
cor(height, weight)

### 결측치가 포함된 데이터의 상관계수
cor(height, weight, na.rm=T) ## 오류
cor(height, weight, use="complete.obs")

df2 <- df
df2[2, "height"] <- NA
df2[4, "weight"] <- NA
cor(df2$height, df2$weight)
cor(df2$height, df2$weight, use = "complete.obs")
cor(df2$height, df2$weight, use = "pairwise.complete.obs")

#2 분할표 작성 : table, xtabs
table(iris$Species)
xtabs(data=iris, ~Species)

d <- data.frame(x = c("1", "2", "2", "1"),
                y = c("A", "B", "A", "B"),
                num = c(3, 5, 8, 7))
d

d1 <- data.frame(x = c("1", "2", "2", "1", "1"),
                 y = c("A", "B", "A", "B", "B"))

d1

xtabs(data = d1, ~ x + y)
xtabs(data = d, num ~ x + y)
d

## 합계산 : margin.table
xt <- xtabs(data = d, num ~x + y)
xt
margin.table(xt, 1) # 행단위
margin.table(xt, 2) # 열열단위
margin.table(xt) # 전체 셀의 합

## 비율 계산 : prop.table
xt
prop.table(xt, 1) # 행방향 비율
prop.table(xt, 2) # 열방향 비율
prop.table(xt) # 전체 중 각 셀 값의 비율

#3 상관분석
?economics
eco <- as.data.frame(ggplot2::economics)
str(eco)
cor(eco$unemploy, eco$pce)

## 상관행렬
car_cor <- cor(mtcars)
round(car_cor, 2)

## 히트맵(상관행렬 그리기)
###install.packages("corrplot")
library(corrplot)

corrplot(car_cor)
corrplot(car_cor, method = "number")

corrplot(car_cor,
    method = "color",
    type = "lower",
    addCoef.col = "black",
    tl.col = "gray",
    tl.srt = 45,
    diag = F)