###########################################################
# DBSCAN
###########################################################

#패키지 설치
##install.packages("fpc")

library(fpc)

#실습 1. toy dataset
## 원형, 구형, 선형 등 다양한 혀앹의 군집과 잡음으로 구성된
## multishapes 데이터셋 사용
## 제공 패키지: factoextra
#install.packages("devtools")
#devtools::install_github("kassambara/factoextra")
library(factoextra)
str(multishapes)
plot(multishapes$x,multishapes$y)

#k-means 군집화를 한다면?
df <- multishapes[-3] 
km.res <- kmeans(df, 5)

# 결과 시각화: factoextra::fviz_cluster
## ggplot2 기반의 클러스터링 시각화 함수
fviz_cluster(km.res, df, geom="point")

# DBSCAN
ds <- dbscan(df, eps=0.15, MinPts=5)

#결과 시각화
fviz_cluster(ds, df, geom="point")

##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# 참고: eps, MinPts(4~5개를 추천)
## MinPts는 휴리스틱에 의해 4~5개를 추천
## eps는 elbow method --> 포인트의 k 인접 이웃 거리 계산
##install.packages("dbscan")
library(dbscan())
kNNdistplot(df, k=5) ### 결과: 0.15 정도가 eps로 적당하다~!

# 실습 2. iris 데이터
iris2
ds <- dbscan(iris2, eps=0.42, MinPts=5)
table(ds$cluster, iris$Species)

#시각화
fviz_cluster(ds, iris2, geom="point")