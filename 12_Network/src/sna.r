# 그래프 데이터 시각화 ###########################################
## 실습 데이터 포함 패키지: networkdata
##devtools::install_github("schochastics/networkdata")
library(networkdata)

# 1. covert_28
str(covert_28)
vertex_attr(covert_28)
plot(covert_28, main = "런던 갱단의 범죄 네트워크")

plot(covert_28, main = "런던 갱단의 범죄 네트워크",
    vertex.shape="circle", vertex.size= V(covert_28)$Convictions+5,
    vertex.color=c("white", "red")[V(covert_28)$Prison+1], #1: 화이트, 2: 레드
    edge.color="orange", edge.arrow.size=0.5,
    edge.width=E(covert_28)$weight)

#2. movie_89 --------------------------------------------------------
vertex_attr(movie_89)
plot(movie_89, main="Batman Returns Characters",
    vertex.label.dist=0, vertex.shape="none", vertex.label.cex=0.7,
    edge.color="orange", edge.arrow.size=1, edge.curved=0.3)

# 소셜 네트워크 분석 #################################################
# 1. 미드 그레이 아나토미(Grey's Anatomy) 주인공들 간 연인 관계 데이터--------
ga.data <- read.csv("12_Network/data/ga_edgelist.csv")
dim(ga.data)
head(ga.data)

ga <- graph.data.frame(ga.data, directed = F)
summary(ga)
plot(ga)

## 차수가 높은 노드 강조하기: 크기, 색상(차수가 높을수록 진한색 표현)
sort(degree(ga), decreasing = T)

### heat.colors(n): n개의 컬러 히트맵(옅은색 -> 진한색 순)
### rev: 벡터의 순서를 거꾸로(reverse). 큰 숫자에 진한색 할당
de <- degree(ga)
de.colors <- rev(heat.colors(max(de)))
plot(ga, vertex.size=de*5, vertex.color=de.colors[de])

# 2. 석사 학위 논문 지도교수들 간 네트워크 분석--------------------------------------
supervisor <- read.table("12_Network/data/supervisor.txt", sep="\t", header=T)
head(supervisor, 10)
str(supervisor)

gs <- graph.data.frame(supervisor, directed=F)
plot(gs)
summary(gs)

## 지도 편수가 3 미만인 노드는 제거, 편수에 비례하여 노드 크기 표현
degree(gs)

gs1 <- delete.vertices(gs, V(gs)[degree(gs) < 3])
V(gs1)$size = degree(gs1)/3
plot(gs1)
summary(gs1)

## 논문 등급(Grade)이 8 이상이면 링크의 색을 빨간색으로, 미만이면 회색으로
E(gs1)$color <- ifelse(E(gs1)$Grade >= 8, "red", "gray")
plot(gs1)

##논문 특생(Spec)에 따라 x는 빨간색, y는 파란색, 나머지는 회색

E(gs1)$color <- ifelse(E(gs1)$Spec=="X", "red",
                        ifelse(E(gs1)$Spec=="Y", "blue", "gray"))
plot(gs1)

## 중심성 지표 확인
head(sort(degree(gs), decreasing = T),10)
head(sort(round(closeness(gs),4), decreasing = T),10)
head(sort(round(betweenness(gs),4), decreasing = T),10)
head(sort(round(eigen_centrality(gs)$vector,4), decreasing = T),10)

## 논문 편수에 관계없이 지도 교수들 간 단순 네트워크 표현
## simplify(): 차수를 제거하고 관계의 유무만 표현
gsimple <- simplify(gs)
plot(gsimple)
degree(gsimple)
plot(gsimple, vertex.size=degree(gsimple))

head(sort(degree(gsimple), decreasing = T),10)
head(sort(round(closeness(gsimple),4), decreasing = T),10)
head(sort(round(betweenness(gsimple),4), decreasing = T),10)
head(sort(round(eigen_centrality(gsimple)$vector,4), decreasing = T),10)

## 커뮤니티 탐색: cluster_walktrap
wc <- cluster_walktrap(gsimple)
plot(wc, gsimple)
sort(membership(wc))

