########################################################
## HierarcHical Clustering
########################################################

#실습 1. iris 데이터셋을 이용한 계층형 군집화
iris2

## 계층형 군집화 함수: hclust()
## 거리 계산: dist(). default=euclidean
## 유사도 측정 방법: method 인자 값 -> single, complete, average
hc <- hclust(dist(iris2), method="average")
hc

##시각화
plot(hc, lables = iris$Species, hang = -1)
rect.hclust(hc, k=3)

##클러스터 분할
ghc <- cutree(hc, k=3)
ghc
table(iris$Species, ghc)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# 실습 2. 계층형 군집화를 이용해 적절한 군집 수를 확인하고
# k-means 알고리즘을 적용해 군집별로 시각화

## 데이터: ggplot2::diamonds
dia <- ggplot2::diamonds
dim(dia)

## 1000개 샘플링
t <- sample(1:nrow(dia), 1000)
test <- dia[t, ]
dim(test)
str(test)
mydia <- test[c("price", "carat", "depth", "table")]
head(mydia)

## 계층형 군집화
result <- hclust(dist(mydia), method="average")
plot(result, hang=-1) ### hang = -1 ->  line from the bottom

##3개 군집화
result2 <- kmeans(mydia, 3)


##데이터에 클러스터 할당
mydia$cluster <- result2$cluster
head(mydia)


##변수 간 상간관계
cor(mydia[, -5])
plot(mydia[, -5])

## 시각화
plot(mydia$carat, mydia$price, col=mydia$cluster+1)
## 중심점 표시
points(result2$centers[, c("carat", "price")], pch=8, cex=5)

#과제: 오늘 한 코드만이라도 잘 숙지하자.