###########################################
# K-means Clustering
###########################################

# 실습 1. 유럽 25개국 단백질 섭취율 데이터
## https://www.biz.uiowa.edu/faculty/jledolter/DataMining/datatext.html
## protein.csv

food <- read.csv("11_Clustering/data/protein.csv")
head(food)
str(food)

## RedMeat, WhiteMeat 기반 3개 그룹으로 클러스터링
grpMeat <- kmeans(food[c("WhiteMeat", "RedMeat")], centers=3)
grpMeat

## 결과 확인
o <- order(grpMeat$cluster)
o
data.frame(grpMeat$cluster[o], food$Country[o])

##시각화
plot(food$Red, food$White, type="n", xlim=c(3,19), xlab="Red Meat",
    ylab="White Meat")
text(x=food$Red, y=food$White, labels=food$Country,
    col=grpMeat$cluster)

## 전체 섭취원을 기준으로 7개 그룹으로 클러스터링
grpProtein <- kmeans(food[-1], centers = 7)
o <- order(grpProtein$cluster)
o <- order(grpProtein$cluster)
data.frame(grpProtein$cluster[o], food$Country[o])

##시각화
plot(food$Red, food$White, type="n", xlim=c(3,19), xlab="Red Meat",
    ylab="White Meat")
text(x=food$Red, y=food$White, labels=food$Country,
    col=grpProtein$cluster)


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# 실습 2. iris 데이터
str(iris)
iris2 <- iris[-5]
head(iris2)

## 3개 그룹으로 군집화
irisSpc <- kmeans(iris2, 3)


## 결과 확인
table(iris$Species, irisSpc$cluster)

## 시각화
par(mfrow=c(1,2))

## 플로팅
plot(iris[c("Sepal.Length", "Sepal.Width")],
    col=irisSpc$cluster,
    main="irisSepal")

irisSpc$centers #중심점 확인
points(irisSpc$centers[, c("Sepal.Length", "Sepal.Width")],
        col = 1:3, pch = 8, cex = 2)

plot(iris2[c("Petal.Length", "Petal.Width")],
    col=irisSpc$cluster,
    main="irisPetal")

points(irisSpc$centers[, c("Petal.Length", "Petal.Width")],
        col = 1:3, pch = 8, cex = 2)

##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# 참고: 최적의 k 찾기 --> the Elbow method
# tot.withinss: Total within-cluster(intra-cluster distances) sum of 
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

tot <- c(1:20)
for(i in 1:20){
    res <- kmeans(iris2, 1)
    tot[i] <- res$tot.withinss
}

plot(c(1:20), tot, type="b",
    main="Optimal k",
    xlab="number of clusters",
    ylab="Total within-cluster SS")