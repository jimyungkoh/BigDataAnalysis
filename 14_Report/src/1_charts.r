#나무지도=================================
#install.packages("treemap")
library(treemap)

# 1. 데이터: treemap::GNI2014 - 2014년 국가별 GNI
data(GNI2014)
head(GNI2014)
?GNI2014
str(GNI2014)

treemap(GNI2014,#데이터(데이터프레임)
        index=c("continent", "iso3"),   # 타일배치
        vSize = "population",   #타일의 면적
        vColor = "GNI", #타일의 색깔
        type = "value", #타일의 색 결정 유형
        bg.labels = "yellow", #대륙 레이블의 배경색
        title="World GNI")

# 2. 데이터: treemap::state.x77 - 미국 각 주별 통계 정보
##  타일의 면적은 주의 면적(Area), 타일의 색깔은 주의 소득(Income)
head(state.x77)
?str(state.x77)
str(state.x77)
## 주 이름이 행이름. 이를 변수로 추가
st <- data.frame(state.x77)
head(st)
st <- data.frame(st, stname=rownames(st))

treemap(st,#데이터(데이터프레임)
        index=c("stname"),   # 타일배치
        vSize = "Area",   #타일의 면적
        vColor = "Income", #타일의 색깔
        type = "value", #타일의 색 결정 유형
        title="US States Area and Income")

#다중 상자도표 ===================================
# 1. 데이터: 서울시 2017년 일별 기온 변화
ds <- read.csv("14_Report/data/seoul_temp_2017.csv")
head(ds)

##  월별 기온 변화
##  일일 온도를 월 기준으로 집계하여 평균 계산: aggregate
##  이상치의 영향을 줄이기 위해 mean 대신 median 사용
month.avg <- aggregate(ds$avg_temp, #집계 대상
                        by= list(ds$month), #집계 기준
                        median)[2]  #집계 함수, 두번째 열(집계 결과)만
month.avg

## 순위에 따라 상자의 색을 다르게 채우기 위해 월평균 기온 순위 계산(내림차순)
odr <- rank(-month.avg)
odr

## 월별 기온 분포 시각화
boxplot(avg_temp~month, data=ds,
        col=heat.colors(12)[odr],
        ylim=c(-20,40), ylab="기온",
        xlab="월", main="서울시 월별 기온 분포 (2017)")


# 2. 데이터: airquality - 뉴욕 1973년 5~9월간 일별 대기 정보
##월별 오존농도 변화 시각화
head(airquality)

## 결측치 제거
air <- airquality[complete.cases(airquality),]

## 순위
month.avg <- aggregate(air$Ozone,
                        by=list(air$Month),
                        median)[2]
month.avg
odr <- rank(-month.avg)
odr


boxplot(Ozone~Month, data=air,
        col=heat.colors(5)[odr],
        ylim=c(0,180), ylab="오존 농도",
        xlab="월", main="NY City Summer Ozone Level")


#방사형 차트 ============================
#install.packages("fmsb")
library(fmsb)

## 방사형 차트를 만들기 위한 데이터 프레임 형태의 데이터 생성
## 1번 행 - 점수 범위의 최대값
## 2번 행 - 점수 범위의 최소값
## 3번 행 - 방사형 차트에 표시할 실제 값
max.score <- rep(100, 5)
min.score <- rep(0, 5)
score <- c(80, 60, 95, 85, 40)
ds <- data.frame(rbind(max.score, min.score, score))
ds
colnames(ds) <- c("국어", "영어", "수학", "물리", "음악")
ds

radarchart(ds)

## 기본 차트 효과/꾸미기
radarchart(ds,  #데이터 프레임
            pcol = "dark green",    #다격형 선의 색
            pfcol = rgb(0.2, 0.5, 0.5, 0.5),    #다각형 내부 색
            plwd = 3,   #다각형 선 두께
            cglcol = "grey",    #거미줄 색
            cglty = 1,  #거미줄 타입
            cglwd = 0.8,    #거미줄 두께
            axistype = 1,   #축의 레이블 타입, default=0(no label), 1(center axis label)
            seg = 4,    #축 눈금 분할
            axislabcol = "grey",    # 축 레이블 색
            caxislabels = seq(0,100,25))    #축 레이블 값
