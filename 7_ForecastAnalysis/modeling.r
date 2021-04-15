#모델링과 예측
##데이터 생성
x <- c(3.0, 6.0, 9.0, 12.0)
y <- c(3.0, 4.0, 5.5, 6.5)
x; y
m <- lm(y~x)
m

## 시각화

plot(x, y)
abline(m, col='red')

#매개변수 확인
coef(m)

#모델에 의한 예측값(y값) 계산(fitted)
fitted(m)

#오차(잔차)
residuals(m)

##모델 자세히 살펴보기
summary(m)

##모델을 이용한 예측
### 새로운 샘플
newx <- data.frame(x = c(1.2, 2.0, 20.65))
newx

###예측, predict()
predict(m, newdata = newx)

#############################################
#단순 선형 회귀
#1. cars 데이터 이용
str(cars)

## 데이터 시각화
plot(cars)

## 모델 생성
car_model <- lm(dist ~ speed, data = cars)

##계수 확인
coef(car_model)

## 모델 시각화
abline(car_model, col='red')

##예측값 확인
fitted(car_model)

##시속 21.5일 때 제동거리는?
new_speed <- data.frame(speed = c(21.5))
predict(car_model, new_speed)


#2. women data
str(women)

## 데이터 시각화
plot(women)

##모델 생성
women_model <-lm(weight ~ height, data=women)

##계수 확인
coef(women_model)

##모델 시각화
abline(women_model, col='red')

## summary로 car_model과  자세히 보기
summary(car_model)
summary(women)

# t-검정
## 데이터: 수면제 복용 후 수면 시간의 변화
data1 <- c(30, -5, 55, -30, -20, 45)
data2 <- c(12, 13, 12, 13, 12, 13)
data3 <- c(30, -5, 55, -30, -20, 45, 3, -5, 55, -30, -20, 45)

##평균과 표준편차
mean(data1); sd(data1)
mean(data2); sd(data2)
mean(data3); sd(data3)

## t.test로 t-검정; df: 자유도, p=balue:
t.test(data1)
t.test(data2)
t.test(data3)


#############################################
#다중 선형 회귀
#1. mtcars 데이터 (실린더 수와 차체 무게가 마력에 미치는 영향)
mtcars_model <- lm(hp ~ cyl + wt, data = mtcars)
mtcars_model
summary(mtcars_model)

#2. airquality 데이터(최고 온도에 영향을 미치는 변수, 오존량, 태양 방사선량, 풍속)
air <- airquality
head(air)
air_model <- lm(Temp ~ Ozone + Solar.R + Wind, data = air)
air_model
summary(air_model)

#변수 선택법
##step; both: 최상 부분집합; backward(후진); forward(전진)
mtcars_model <- lm(mpg ~ ., data = mtcars)
slm <- step(mtcars_model, direction = 'both')
slm


bestBIC <- summary(slm)$bic; bestBIC

##가장 낮은 모델 시각화
min.val <- which.min(bestBIC)
plot(bestBIC, type = "b")
points(min.val, bestBIC[min.val], col='red', pch=20) ##시험범위에요. 인덱스 알아두셔야 합니다.
