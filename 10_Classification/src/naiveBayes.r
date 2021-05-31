#########################
## Naive Bayes Classifier
#########################

#패키지 설치 및 로드
#install.packages("e1071")
library(e1071)

#데이터 셋: UCI 대학에서 제공하는 독버섯 관련 데이터
mushroom <- read.csv("data/mushrooms.csv")
str(mushroom)

#데이터 나누기
# 훈련 집합(6500개)., 테스트 집합(-개)
n <- nrow(mushroom);  
tr_idx <- sample(1:n, 6500); 

#훈련집합, 타겟클래스, 테스트 집합 생성
train <- mushroom[tr_idx, -1]; 
test <- mushroom[-tr_idx, -1]; 
train_class <- mushroom[tr_idx, "type"]; 
test_class <- mushroom[-tr_idx, "type"]; 

#모델/ 분류기 생성
m_cl <- naiveBayes(train, train_class)

#test 데이터 예측
m_pred <- predict(m_cl, test)

#예측 결과 확인
table(test_class, m_pred)

#성능 평가
sum(test_class==m_pred)/(n-6500)