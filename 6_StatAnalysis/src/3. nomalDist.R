# 대한민국 30대 여성 3,500,000 의 키의 분포를 알아보자

## 난수로 키 데이터 생성
prop <- runif(3500000, min = 155, max = 170) 
head(prop)
prop <- as.integer(prop)

## 30개씩 표본 추출하여 평균 계산
samples <- integer(10^6)
for( i in 1:10^6){
    s <- sample(prop, 30, replace = T)
    mean_s <- mean(s)
    samples[i] <- mean_s
}
head(samples)

## 히스토그램으로 분포 확인
hist(samples, breaks=1000)

# 신뢰 구간 구하기
## 데이터 생성
x <- as.integer(runif(50, min=15, max=30)); x

## 표본평균
mean_x <- mean(x); mean_x

## 표준편차
sd_x <- sd(x); sd_x

## 표준오차(표본평균의 표준편차)
## sqrt: 제곱근
se_x <- sd_x / sqrt(50); se_x

## 유의 수준 alpha, 신뢰 수준
### 모집단 평균의 95%신뢰구간
alpha <- 0.05
conf_level <- 1 - alpha

## 좌우 각 z-score
### qnorm : 분위수함수. 확률 변수 x의 값 f(x) 계산
### 설명 참조 : https://statools.tistory.com/9
z_left <- qnorm(alpha / 2, 0, 1); z_left
z_right <- qnorm(1-alpha / 2, 0, 1); z_right

## 신뢰구간 상/하한
conf_lower <- mean_x + z_left * se_x; conf_lower
conf_upper <- mean_x + z_right * se_x; conf_upper

## 이것을 간단히
mean_x + qnorm(c(alpha / 2 , (1 - alpha) / 2), 0, 1) * se_x

## 더 간단히
qnorm(c(alpha / 2, 1 - alpha/2), mean_x, se_x)