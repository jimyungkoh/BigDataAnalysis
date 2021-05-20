#########################
## Dicision Tree
#########################
#패키지 설치 및 로드

#install.packages("party")
library(party)

# 1. ariquality 데이터셋
str(airquality)

#분류 모델 생성 :ctree
##분류 모델: 태양열, 바람, 오존량으로 온도 예측

formula <- Temp ~ Solar.R + Wind + Ozone
air_ctree <- ctree(formula, data = airquality)
air_ctree

#모델 시각화
plot(air_ctree)

#2. iris 데이터셋
## 학습 데이터 (70%)와 테스트 데이터(30%)를 나누어 모델 생성

#샘플링으로 데이터 추출
## 1을 0.7, 2를 0.3 가중치를 주어 중복 허용해서 iris 데이터 개수만큼 생성
ind <- sample(2, nrow(iris), replace = T, prob = c(0.7, 0.3))
ind

train <- iris[ind == 1, ]
test <- iris[ind == 2,]
nrow(train); nrow(test)

# 분류 모델 생성
formula <- Species ~ Sepal.Length + Sepal.Width + Sepal.Length +
            Sepal.Width
iris_ctree <- ctree(formula, data =train)

#모델 시각화
plot(iris_ctree)

#데스트 데이터로 결과 예측
testPred <- predict(iris_ctree, test)
testPred

#예측 결과와 실제 데이터의 정확도 확인
table(testPred, test$Species)
sum(testPred == test$Species)/length(testPred)

