#패키지 설치 및 로드: igraph
install.packages("igraph")
library(igraph)

# 그래프 생성-----------------------------------------------------
## 간단한 그래프: graph_formula(), graph_from_literal()
## 작은 그래프를 빨리 그리기 위한 함수

g1 <- graph.formula(A-B-C, B-D, E-F-G, H, I); plot(g1)

g2 <- graph.formula(A+-B+-C, B+-D, E+F+-+G, H, I); plot(g2)

g3 <- graph_from_literal("this is" +- "a simple" -+ "graph here"); plot(g3, main="g3")

##인접행렬로 그래프 생성: graph_adjacency()

adjmatrix <- matrix(c(0,1,1,0,
                    0,0,0,1,
                    0,0,0,1,
                    0,0,0,0),
                    byrow=T, nrow=4)
adjmatrix
ga <- graph.adjacency(adjmatrix, mode="direct", weighted=NULL); plot(ga, main="ga")

# 그래프 속성 ----------------------------------------------------------------------------
V(g1) #노드 목록
E(g1) #링크 목록
E(g2)
get.edgelist(g1)
get.edgelist(g2)
vcount(g1) #노드 수
ecount(g1) #링크 수
is.directed(g1) #방향성 여부
is.directed(g2) #방향성 여부

V(ga)$name <- c("M1", "M2", "M3", "M4")
plot(ga)

V(ga)$label.cex=2
V(ga)$label.color="red"
V(ga)$size=30
V(ga)$color="yellow"
plot(ga)

E(ga)$width=4
E(ga)$color="green"
plot(ga)

plot(ga, vertex.label.cex=2, vertex.label.color="green",
    vertex.size=30, vertex.color="red", edge.width=4, edge.color="blue")

#가중치 방향 그래프
w.matrix <- matrix(c(0,1,0,0,0,0,
                    0,0,2,0,0,0,
                    0,0,0,0,3,0,
                    0,2,0,0,0,0,
                    0,0,0,3,0,1,
                    0,0,0,0,0,0), byrow=T, nrow=6,
                    dimnames=list(c("A","B", "C", "D", "E", "F"),
                                 c("A","B", "C", "D", "E", "F")))
w.matrix

gw <- graph.adjacency(w.matrix, mode="directed", weighted=T)
plot(gw, vertex.label.cex=1, vertex.size=30, vertex.color="cyan",
    edge.label.cex=1, edge.label.color="red", edge.arrow.size=0.5,
    edge.label=E(gw)$weight, edge.width=E(gw)$weight)

#연습: 표1의 친구 관계를 인접 행렬로 생성하고 그래프로 시각화하시오.
f.matrix <- matrix(c(0,1,0,0,0,0,0,0,
                    1,0,1,0,1,1,0,0,
                    0,1,0,0,0,0,0,0,
                    0,0,0,0,1,0,0,0,
                    0,1,0,1,0,1,1,0,
                    0,1,0,0,1,0,1,0,
                    0,0,0,0,1,1,0,1,
                    0,0,0,0,0,0,1,0), byrow=T, nrow=8,
                    dimnames=list(c("철수","갑돌", "현수", "지윤", "나래", "영희", "시원", "영숙"),
                                 c("철수","갑돌", "현수", "지윤", "나래", "영희", "시원", "영숙")))
f.matrix
gf <- graph.adjacency(f.matrix, mode="undirected", weighted=T)
plot(gf, main="Friends Network",
    vertex.label.cex=1, vertex.label.color="navy", vertex.size=30, vertex.color="skyblue",
    edge.width=2, edge.color="blue")

# 그래프 지표 함수 -----------------------------------------------------------------
g <- graph.formula(A-B-D, C-D-F, E-D-F, E-F)
plot(g)

degree(g)
graph.density(g)
closeness(g)
betweenness(g)
eigen_centrality(g)$vector

plot(gw)
degree(gw)
degree(gw, mode="in")
degree(gw, mode="out")

plot(gf)
degree(gf)
graph.density(gf)
closeness(gf)
betweenness(gf)
eigen_centrality(gf)$vector
