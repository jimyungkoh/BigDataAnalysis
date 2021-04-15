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

