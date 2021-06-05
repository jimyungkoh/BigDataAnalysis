#####################################
####### Dicision Tree
#####################################
#패키지 설치 및 로드

library(party)

#1. airquality 데이터셋
str(airquality)

#분류 모델 생성: ctree
##분류 모델: 태양열, 바람, 오존량으로 온도 예측
formula <- Temp ~ Solar.R + Wind + Ozone
air_ctree <- ctree(formula, data = airquality)
air_ctree

#모델 시각화
plot(air_ctree)

#2. iris 데이터셋
##학습 데이터 (70%)와 테스트 데이터(30%)를 나누어 모델 생성

#샘플링으로 데이터 추출
## 1을 0.7, 2를 0.3 가중치를 주어 중복 허용해서 iris 데이터 개수만큼 생성
ind <- sample(2, nrow(iris), replace = T, prob=c(0.7, 0.3))
ind

train <- iris[ind == 1, ]
test <- iris[ind == 2,]
nrow(train); nrow(test)

#분류 모델 생성
formula <- Species  ~ Sepal.Length + Sepal.Width + Sepal.Length + Sepal.Width
formula
iris_ctree <- ctree(formula, data = train)

#모델 시각화
plot(iris_ctree)

#테스트 데이터로 결과 예측
testPred <- predict(iris_ctree, test)
testPred

#예측 결과와 실제 데이터의 정확도 확인
table(testPred, test$Species)
sum(testPred == test$Species)/length(testPred)

#########################
## K-Nearest Neighbor
#########################
#패키지 설치 및 로드

library(class)

#1. fgl data: 6종류의 유리조각(type)
library(MASS)
str(fgl) #RI: 굴절율

#훈련 집합(200개)과 테스트 집합(14개)
n <- nrow(fgl); n
tr_idx <- sample(1:n, 200); tr_idx

#모델 생성할 변수, RI, Al 추출
#훈련집합, 타겟 클래스, 테스트 집합 생성
train <- fgl[tr_idx, c("RI", "Al")]; head(train)
test <- fgl[-tr_idx, c("RI", "Al")]; head(test)
train_class <- fgl[tr_idx, "type"]; train_class
test_class <- fgl[-tr_idx, "type"]; test_class

#knn 모델 생성: 훈련집합, 타겟 클래스, 테스트 집합, 이웃 수
##  knn (train, test, cl, k, l, prob, use.all)
##      train: 훈련 집합 배열
##      test: 테스트 셋의 데이터 프레임 or 배열
##      cl: 타겟 클래스
##      k: 이웃의 수
nn1 <- knn(train=train, cl=train_class, test=test, k=1)
nn5 <- knn(train=train, cl=train_class, test=test, k=5)

#예측 결과
table(test_class, nn1)
table(test_class, nn5)

#성능 평가
res1 <- sum(test_class == nn1)/14; res1
res5 <- sum(test_class == nn5)/14; res5

# 2. iris 데이터 셋
# 훈련 집합(100개), 테스트 집합(50개)
##  knn (train, test, cl, k, l, prob, use.all)
##      train: 훈련 집합 배열
##      test: 테스트 셋의 데이터 프레임 or 배열
##      cl: 타겟 클래스
##      k: 이웃의 수
n <- nrow(iris); n
tr_idx <- sample(1:n, 100); tr_idx

#훈련집합, 타겟 클래스, 테스트 집합 생성
train <- iris[tr_idx, -5]; train ## 훈련 집합 생성
## 테스트 셋: 훈련 집합을 제외한 데이터 프레임 or 배열  자연스럽게 50개가 됨
test <- iris[-tr_idx, -5]; test 
train_class <- iris[tr_idx, "Species"]; ## 훈련 집합의 타겟 클래스 생성
test_class <- iris[-tr_idx, "Species"]; ## 테스트 셋의 타겟 클래스 생성

#knn 모델 생성
nn5 <- knn(train=train, cl=train_class, test=test, k = 5)

#예측 결과
table(test_class, nn5)

#성능 평가
sum(test_class == nn5)/50

##################################################################
# 위스콘신 대학에서 제공한 유방암 환자 데이터로 종양 여부 분류 분석 모델
##################################################################

wbcd <- read.csv("15_Remind/data/wisc_bc_data.csv", stringsAsFactors = F)
#read.csv("data/wisc_bc_data.csv", stringsAsFactors = F)
str(wbcd)
wbcd$diagnosis <- factor(wbcd$diagnosis)
wbcd <- wbcd[-1] #첫번째 변수 id는 제거
str(wbcd)

#진단 상태 확인
table(wbcd$diagnosis)

# 3 feature만 데이터 확인
summary(wbcd[2:5])

#데이터 정규화(min-max 정규화: 0~1 사이의 값) 수행 함수 생성
normalize <- function(x){
    return( (x-min(x))/ (max(x)-min(x)))
}

# 첫 열 진단 결과만 제외하고 lapply 함수를 이용해 정규화 수행
# 데이터 프레임으로 변경
##  lapply
##     lapply(iris_num, mean, na.rm = T): iris_num의 열 단위 평균이 list 형태로 출력됨 

wbcd_n <- as.data.frame(lapply(wbcd[2:31], normalize))
summary(wbcd_n[2:5])

# 훈련 집합(469개), 테스트 집합(100개)
n <- nrow(wbcd_n);
tr_idx <- sample(1:n, 469);

# 훈련집합, 타겟클래스, 테스트 집합 생성
train <- wbcd[tr_idx, -1];
test <- wbcd[-tr_idx, -1];
train_class <- wbcd[tr_idx, "diagnosis"];
test_class <- wbcd[-tr_idx, "diagnosis"];

#knn 모델 생성
nn5 <- knn(train = train, cl=train_class, test=test, k=5)

#예측 결과
table(test_class, nn5)

#성능 평가
sum(test_class == nn5)/100

#참고: 적절한 k를 찾는법
score_board <- c(1:300)

for(i in 1:300){
    nn <- knn(train=train, cl=train_class, test=test, k=1)
    res <- sum(test_class == nn) / 100
    score_board[i] <- res
}

df <- data.frame(index = c(1:300), score = score_board)

subset(df, score == max(score))

#########################
## Naive Bayes Classifier
#########################

#패키지 설치 및 로드
library(e1071)

#데이터 셋 : UCI 대학에서 제공하는 독버섯 관련 데이터
mushroom <- read.csv("15_Remind/data/mushrooms.csv")
##read.csv("data/mushroom.csv")
str(mushroom)
?naiveBayes
#데이터 나누기
# 훈련 집합(6,500개), 테스트 집합(1624개 : 8124-6500개)
n <- nrow(mushroom); n
tr_idx <- sample(1:n, 6500);

#훈련집합, 타겟 클래스, 테스트 집합 생성
train <- mushroom[tr_idx, -1];
test <- mushroom[-tr_idx, -1];
train_class <- mushroom[tr_idx, "type"];
test_class <- mushroom[-tr_idx, "type"];

#모델/ 분류기 생성
m_cl <- naiveBayes(train, train_class);

#test 데이터 예측
m_pred <- predict(m_cl, test)

#예측 결과 확인
table(test_class, m_pred)

#성능 평가
sum(test_class == m_pred)/(n-6500)