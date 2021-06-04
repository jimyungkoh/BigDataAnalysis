#########################
## K-Nearest Neighbor
#########################
#패키지 설치 및 로드

#install.packages("class")

library(class)

# 1. fgl data: 6종류의 유리조각(type)

library(MASS)
str(fgl) #RI: 굴절율

# 훈련 집합(200개)과 테스트 집합(14개)
n <- nrow(fgl); n
tr_idx <- sample(1:n, 200); tr_idx

?fgl
# 모델 생성할 변수, RI, Al 추출
# 훈련집합, 타겟 클래스, 테스트 집합 생성
train <- fgl[tr_idx, c('RI', 'Al')]; train
test <- fgl[-tr_idx, c('RI', "Al")]; test
train_class <- fgl[tr_idx, "type"]; train_class
test_class <- fgl[-tr_idx, "type"]; test_class

??knn()
# knn 모델 생성: 훈련집합, 타겟 클래스, 테스트 집합, 이웃 수
nn1 <- knn(train=train, cl=train_class, test=test, k=1)
nn5 <- knn(train=train, cl=train_class, test=test, k=5)

#예측 결과
table(test_class, nn1)
table(test_class, nn5)

#성능 평가
res1 <- sum(test_class == nn1) / 14;res1
res5 <- sum(test_class == nn5) / 14;res5

# 2. iris 데이터 셋
# 훈련 집합(100개)., 테스트 집합(50개)
n <- nrow(iris); n
tr_idx <- sample(1:n, 100); tr_idx

#훈련집합, 타겟클래스, 테스트 집합 생성
train <- iris[tr_idx, -5]; train
test <- iris[-tr_idx, -5]; test
train_class <- iris[tr_idx, "Species"];
test_class <- iris[-tr_idx, "Species"];

#knn 모델 생성
nn5 <- knn(train=train, cl=train_class, test=test, k=5)

#예측 결과
table(test_class, nn5)

#성능 평가
sum(test_class==nn5)/50

##################################################################
# 위스콘신 대학에서 제공한 유방암 환자 데이터로 종양 여부 분류 분석 모델
##################################################################

wbcd <- read.csv("10_Classification/data/wisc_bc_data.csv",
                    stringsAsFactors = F)
str(wbcd)
wbcd$diagnosis <- factor(wbcd$diagnosis)
wbcd <- wbcd[-1] #첫번째 변수 id는 제거
str(wbcd)

#진단 상태 확인
table(wbcd$diagnosis)

#3 feature만 데이터 확인
summary(wbcd[2:5])

#데이터 정규화(min-max 정규화: 0~1 사이의 값) 수행 함수 생성
normalize <- function(x){
    return( (x-min(x)) / (max(x)-min(x)) )
}

# 첫 열 진단 결과만 제외하고 lapply 함수를 이용해 정규화 수행
# 데이터 프레임으로 변경
wbcd_n <- as.data.frame(lapply(wbcd[2:31], normalize))
summary(wbcd_n[2:5])

# 훈련 집합(469개)., 테스트 집합(100개)
n <- nrow(wbcd_n); 
tr_idx <- sample(1:n, 469);

#훈련집합, 타겟클래스, 테스트 집합 생성
train <- wbcd[tr_idx, -1]; 
test <- wbcd[-tr_idx, -1]; 
train_class <- wbcd[tr_idx, "diagnosis"];
test_class <- wbcd[-tr_idx, "diagnosis"];

#knn 모델 생성
nn5 <- knn(train=train, cl=train_class, test=test, k=5)

#예측 결과
table(test_class, nn5)

#성능 평가
sum(test_class == nn5) / 100

#참고: 적절한 k를 찾는법
score_board <- c(1:300)

for(i in 1:300) {
    nn <- knn(train=train, cl=train_class, test=test, k=i)
    res <- sum(test_class == nn) / 100
    score_board[i] <- res
}

df <- data.frame(index = c(1:300), score = score_board)
df

subset(df, score == max(score))

