library(ggplot2)
#plot 함수
head(cars)
plot(cars,type='p', main="cars")
plot(cars,type='l', main="cars")
plot(cars)

#예제 데이터
df <- read.csv("C:/Users/JimyungKoh/Desktop/R_project/5_Rchart/data/example_studentlist.csv",
                stringsAsFactors=T)
str(df)

df$name <- as.character(df$name)
df$grade <- as.factor(df$grade)

#plot - 1변수 사용
plot(df$age)
plot(df$bloodtype)

#plot - 2변수 사용
## x, y 축 모두 수치형 -> 산점도(두 변수 간 상관관계)
plot(df$age, df$height)
## x 변수 팩터형, y 변수 수치형 -> 상자도표: x를 이루는 레벨별 y의 분포
plot(df$bloodtype, df$height)
plot(df$height, df$bloodtype)
## x, y 축 모두 팩터형 -> 모자이크도표
plot(df$gender, df$bloodtype)
plot(df$height - df$age)

#데이터 프레임 전체 넣기
plot(df)

#barplot-막대 차트(명목형 변수의 빈도수를 나타내는 차트)

##tapply(주어진 함수를 그룹별로 각 자료 값에 적용하는 함수) 이용하여
height <- tapply(df$height, df$bloodtype, mean); height

##막대차트(plot() 함수도 막대 차트 표현이 가능하지만, 레벨별 빈도수 표현만 가능)
barplot(height)

#boxplot
##상자도표 boxplot 그리기
boxplot(df$height)
##그룹별 상자도표 그리기(혈액형별 키 차트)
boxplot(df$height~df$bloodtype) 

#hist(히스토그램 그리기; breaks는 간격 조정시 사용[10은 구간을 10개로 나눔을 의미함])
hist(df$height)
hist(df$height, breaks = 10)
hist(df$height, breaks = seq(155, 185, 10))

#저수준 차트 함수
plot(df$weight~df$height, ann = F)
##title() 함수를 이용해 제목, x축, y축 레이블 표시
##xlab, ylab: x,y 축에 사용할 문자열
title(main = "A대학 B학과생 몸무게와 키의 상관관계",
        xlab = "키",
        ylab = "몸무게")
grid()
m.height <- mean(df$height)
m.height
abline(v = m.height, col = "red")

#par(): partition (한 화면에 여러 차트 그리기)
##차트 공간 분할: 2행 3열; 원래대로 돌리려면 par(mfrow=c(1,1))
par(mfrow = c(2, 3))

plot(df$weight, df$height)
plot(df$gender, df$height)
barplot(table(df$bloodtype))
boxplot(df$height)
boxplot(df$height~df$bloodtype)
hist(df$height, breaks=seq(155, 185, 10))

par(mfrow=c(1,1))

#line chart
##난수 생성; runif() 함수: 난수 생성;
##round 함수: 소수점 이하 자리수 표현(두번째 인자 생략시 정수자리 표현) 
ts1 <- round(runif(30) * 100); ts1
ts2 <- round(runif(30) * 100); ts2

##정렬(오름차순)
ts1 <- sort(ts1)
ts2 <- sort(ts2)
ts1;ts2

##차트 그리기(선 차트 그리고 lines() 함수를 이용해 라인을 추가)
plot(ts1, type = 'l')
lines(ts2, lty = 'dashed', col = "red")

############################################
#ggplot2
##보다 쉽고 개념적으로 차트를 만들 수 있는 ggplot2 패키지
##일관된 기초 문법, 직관적인 함수 제공
##레이어 추가 방식(1단계: 배경 설정(축), 2단계: 그래프 추가(점, 막대, 선),
## 3단계: 설정 추가(축 범위, 색, 표식))
############################################
library(ggplot2)
##좌표계 설정 및 차트 추가
ggplot(data = mpg, aes(x = displ, y = hwy) + geom_point() + geom_line())

g1 <- ggplot(data = mpg, aes(x = displ, y = hwy))
g2 <- geom_point(color = "red", size = 4)
g3 <- geom_line(color = "blue", size = 1)

g1 + g2
g1 + g3
g1 + g2 + g3

#축, 제목 설정
g1 + g2 +
        xlim(3,6) + ylim(10,50) + xlab("displacement") + ylab("highway") +
        ggtitle("displacement vs. highway", subtitle = "from ggplot2::mpg")


#테마 설정
str(pressure)
?pressure
d1 <- pressure
head(d1)

g_bg <- ggplot(d1, aes(x = temperature, y = pressure)) +
  ggtitle("pressure vs. temperature") +
  xlab("온도") + ylab("압력")
g_lt <- geom_line(color = "blue", size = 1)
g_pt <- geom_point(color = "red", size = 2)

g_bg + g_lt + g_pt + theme_bw()
g_bg + g_lt + g_pt + theme_dark()

g_theme <- theme(plot.title = element_text(size = 20, color = "violetred"),
                axis.title.x = element_text(size = 15, face = "bold"),
                axis.title.y =
                element_text(size = 15, angle = 0, face = "italic"))

g_bg + g_lt + g_pt + theme_bw() + g_theme

# aes 설정 
str(Orange)
?Orange

ggplot(Orange, aes(x=age, y=circumference, color=Tree))+
  geom_line()+
  ggtitle("color=Tree")+
  theme(plot.title=element_text(size=20, color="blue"))

ggplot(Orange, aes(x=age, y=circumference))+
  geom_line(aes(color=Tree))+
  ggtitle("color=Tree")+
  theme(plot.title=element_text(size=20, color="blue"))

g_bg <- ggplot(Orange, aes(x=age, y=circumference))
g_line <- geom_line(aes(color=Tree))
g_theme <- theme(plot.title=element_text(size=20, color="blue"))

#범례 설정
g_bg+g_line+g_theme+ggtitle("범례 지우기")+
  theme(legend.position = "none")

g_bg+g_line+g_theme+
  geom_point(aes(shape=Tree), size=3)+
  ggtitle("두 종류의 범례(선+점)")
  
g_bg+g_line+g_theme+
  geom_point(aes(shape=Tree), size=3)+
  ggtitle("두 종류의 범례 중 shape 삭제")+
  guides(shape=FALSE)

g_bg+g_line+g_theme+
  geom_point(aes(shape=Tree), size=3)+
  ggtitle("두 종류의 범례 중 shape 삭제")+
  scale_shape_discrete(guide=FALSE)

g_bg+g_line+g_theme+
  ggtitle("범례 타이틀 삭제")+
  guides(color=guide_legend(title=NULL))


g_bg+g_line+g_theme+
  ggtitle("범례 타이틀 삭제")+
  theme(legend.title=element_blank())


g_bg+g_line+g_theme+
  ggtitle("범례 타이틀 설정")+
  theme(legend.title = element_text(size=20, face="bold", color="red"))+
  scale_color_discrete(name="나무종류")

label <- paste0("Tree", 1:5)
label

g_bg+g_line+g_theme+
  ggtitle("범례 레이블 및 위치 지정")+
  scale_color_discrete(name="나무종류", labels=label)+
  theme(legend.position = "top",
        legend.background = element_rect(fill="gainsboro"))

#막대 차트(평균 막대 차트를 위한 요약 테이블)
library(dplyr)

df_mpg <- mpg %>%
  group_by(drv) %>%
  summarise(mean_hwy=mean(hwy))

df_mpg

#차트 생성
ggplot(df_mpg, aes(x=drv,y=mean_hwy)+geom_col())

#크기 순 정렬
ggplot(df_mpg, aes(x = reorder(drv,- mean_hwy), y = mean_hwy))+
  geom_col()

#빈도 막대 차트
ggplot(mpg,aes(x=drv))+geom_bar()

#선차트
?economics
str(economics)
ggplot(data=economics, aes(x=date, y=unemploy))+geom_line()

#상자도표
ggplot(mpg,aes(x=drv,y=hwy))+geom_boxplot()

##########################################################
### 예제 데이터로 다양한 차트 그리기
##########################################################

df <- read.csv("C:/Users/JimyungKoh/Desktop/R_project/5_Rchart/data/example_studentlist.csv",
                stringsAsFactors=T); df

g1 <- ggplot(df, aes(x=height, y=weight, color=bloodtype))
g1 + geom_line() + geom_point()
g1 + geom_line(size=1) + geom_point(size=10)

#차트 분할: Facet grid
g1 + geom_point(size=5) + geom_line(size=1) + facet_grid(.~gender)
g1 + geom_point(size=5) + geom_line(size=1) + facet_grid(gender~.)

#y축 범위 자유롭게 표현
g1 + geom_point(size=5) + geom_line(size=1) +
  facet_grid(gender~., scales = "free")

#막대 차트
g <- ggplot(df, aes(x=bloodtype, fill=gender))
g + geom_bar()

g + geom_bar(position = "dodge") #옆으로 표현하고 싶으면 인자 "dodge"
g + geom_bar(position = "fill") #상대 빈도로 표현하고 싶으면 인자 "fill"!