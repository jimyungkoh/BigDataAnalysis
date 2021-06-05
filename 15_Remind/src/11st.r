###############################################
######  K-means Clustering
###############################################

#실습 1. 유럽 25개국 단백질 섭취율 데이터
# protein.csv

food <- read.csv("data/protein.csv")
##read.csv("15_Remind/data/protein.csv")
head(food)
str(food)

## RedMeat, WhiteMeat 기반 3개 그룹으로 클러스터링
grpMeat <- kmeans(food[c("WhiteMeat", "RedMeat")], centers=3)
grpMeat

## 결과 확인
o <- order(grpMeat$cluster); o

## 시각화
plot(food$Red, food$White, type="n", xlim=c(3, 19), xlab="Red Meat",
    ylab="White Meat")
text(x=food$Red, y=food$White, labels= food$Country, col=grpMeat$cluster)


## 전체 섭취원을 기준으로 7개 그룹으로 클러스터링
grpProtein <- kmeans(food[-1], centers = 7)
o <- order(grpProtein$cluster)
data.frame(grpProtein$cluster[o], food$Country[o])

## 시각화
plot(food$Red, food$White, type="n", xlim=c(3,19), xlab="Red Meat",
    ylab = "White Meat")
text(x=food$Red, y=food$White, labels=food$Country, col=grpProtein$cluster)


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# 실습 2. iris 데이터
str(iris)
iris2 <- iris[-5]
head(iris2)

## 3개 그룹으로 군집화
irisSpc <- kmeans(iris2, 3)

##결과 확인
table(iris$Species, irisSpc$cluster)

##시각화
par(mfrow=c(1,2))

##플로팅
plot(iris[c("Sepal.Length", "Sepal.Width")],
    col=irisSpc$cluster, main = "irisSepal")

irisSpc$centers #중심점 확인
points(irisSpc$centers[, c("Sepal.Length", "Sepal.Width")],
    col = 1:3, pch = 8, cex =2)

plot(iris2[c("Petal.Length", "Petal.Width")],
    col=irisSpc$cluster, main="irisPetal")

points(irisSpc$centers[, c("Petal.Length", "Petal.Width")],
        col = 1:3, pch = 8, cex = 2)

##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# 참고: 최적의 k 찾기 --> the Elbow method
# tot.withiness : Total within-cluster(intra-cluster distances) sum of
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

tot <- c(1:20)
for(i in 1:20){
    res <- kmeans(iris2, 1)
    tot[1] <- res$tot.withinss
}

plot(c(1:20), tot, type="b",
    main="Optimal k",
    xlab="number of clusters",
    ylab="Total within-cluster SS")


######################################################################
# DBSCAN
######################################################################

library(fpc)

#실습 1. toy dataset
## 원형, 구형, 선형 등 다양한 형태의 군집과 잡음으로 구성된
## multishapes 데이터셋 사용
## 제공 패키지: factoextra

library(ggplot2)
library(factoextra)
str(multishapes)
plot(multishapes$x, multishapes$y)

#k-means 군집화를 한다면?
df <- multishapes[-3]
km.res <- kmeans(df, 5)

#결과 시각화: factoextra::fviz_cluster
##ggpot2 기반의 클러스터링 시각화 함수

fviz_cluster(km.res, df, geom="point")

#DBSCAN: 대표적 밀도 기반 군집화 알고리즘
ds <- dbscan(df, eps=0.15, MinPts = 5)
library(dbscan)
#결과 시각화
fviz_cluster(ds, df, geom="point")


#kNNdistplot():Fast calculation of the k-nearest neighbor distances
#   for a dataset represented as a matrix of points.
kNNdistplot(df, k= 5)

##결과 0.15 정도가 eps로 적당하다~!
##인자 k: number of nearest neighbors used for the distance calculation.

#실습 2. iris 데이터
iris2 <- iris[, -5]
ds <- dbscan(iris2, eps=0.42, MinPts=5)
table(ds$cluster, iris$Species)

#시각화
fviz_cluster(ds, iris2, geom = "point")

########################################################
## HierarcHical Clustering
########################################################

#실습 1. iris 데이터셋을 이용한 계층형 군집화

iris2

## 계층형 군집화 함수: hclust()
## 거리 계산: dist() default=euclidean
## 유사도 측정 방법: method 인자 값 -> single, complete, average

hc <- hclust(dist(iris2), method= "average")
hc

##시각화

plot(hc, lables = iris$Species, hang = -1)
rect.hclust(hc, k=3)

##클러스터 분할
ghc <- cutree(hc, k=3)
ghc
table(iris$Species, ghc)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# 실습 2. 계층형 군집화를 이용해 적절한 군집 수를 확인하고
#   k-means 알고리즘을 적용해 군집별로 시각화

## 데이터: ggplot2::diamonds
dia <- ggplot2::diamonds
dim(dia)

## 1000개 샘플링
t <- sample(1:nrow(dia), 1000)
test <- dia[t,]
dim(test)
str(test)
mydia <- test[c("price", "carat", "depth", "table")]
head(mydia)

## 계층형 군집화
result <- hclust(dist(mydia), method="average")
plot(result, hang=-1)    ### hang = -1 ->  line from the bottom

##3개 군집화
result2 <- kmeans(mydia, 3)

##데이터에 클러스터 할당
mydia$cluster <- result2$cluster
head(mydia)