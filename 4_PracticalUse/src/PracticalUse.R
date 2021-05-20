# 실습 참고 교재 : 'Do it! 쉽게 배우는 R 데이터 분석', 김영우 저, 이지스퍼블리싱
# ggplot2::mpg data를 이용하여 다음 문제를 수행하세요.
#nstall.packages("ggplot2")
library(ggplot2)
library(dplyr)
?mpg ##ggplot2의 샘플 데이터
str(mpg)
data <- as.data.frame(mpg)
head(data)

mpg
## 실습 1. audi의 자동차 모델 중 고속도로 연비(hwy)가 가장 높은 5개의 자동차 데이터 출력
mpg %>%
    filter(manufacturer=="audi") %>% 
    arrange(desc(hwy)) %>%
    head(5)

mpg %>%
    filter(manufacturer=="audi") %>%
    arrange(desc(hwy))%>%
    head(5)

#mpg %>%group_by(manufacturer) %>%arrange(desc(hwy)) %>% head(5)

## 실습 2. 고속도로 연비(hwy)와 도시 연비(cty)를 통합한 평균 연비 변수를 추가하고 평균 연비가 가장 높은 자동차 3종 출력 

mpg %>%
    mutate(total = (hwy + cty)/2) %>%
    arrange(desc(total)) %>%
    head(3)



mpg %>%
  mutate(total=(hwy+cty)/2) %>%
  arrange(desc(total))%>%
  head(3)

## 실습 3. 제조사와 구동 방식으로 그룹을 만들어 그룹별 도시 연비의 평균 구하기
mpg %>% 
  group_by(manufacturer, drv) %>%
  summarise(mean_cty=mean(cty))


mpg %>%
    group_by(manufacturer, drv) %>%
    summarise(mean_cty=mean(cty))
## 실습 4. 제조사별 'suv' 자동차의 평균 연비가 가장 높은 자동차 5개 출력
mpg %>%
  filter(class=="suv") %>%
  group_by(manufacturer, model) %>%
  summarise(total=(hwy+cty)/2) %>%
  arrange(desc(total)) %>%
  head(5)

## 실습 5. 자동차 class 별 도시 연비의 평균 알아보고 평균이 높은 순으로 정렬해서 출력
mpg %>%
  group_by(class) %>%
  summarise(mean_cty=mean(cty))%>%
  arrange(desc(mean_cty))

## 실습 6. 어떤 회사에서 'compact'(경차)를 가장 많이 생산할까?
mpg %>%
  filter(class=="compact") %>%
  group_by(manufacturer) %>%
  summarise(n=n()) %>%
  arrange(desc(n)) %>%
  head(1)

## 실습 7. 자동차 연료별 가격 정보를 참고하여, 자동차 모델별 연료 타입에 따른 연료 가격 테이블 만들기
### c : CNG : 2.35 / d : diesel : 2.38 / e : ethanol E85 : 2.11 / p : premium : 2.76 / r : regular : 2.22

fuel <- data.frame(fl=c("c","d","e","p","r"),
                  price_fl=c(2.35,2.38,2.11,2.76,2.22),
                  stringsAsFactors = F)

mpg <- left_join(mpg, fuel, by="fl")
mpg

mpg %>% select(model, fl, price_fl) %>% head(5)

########################################################################################################
# ggplot2::midwest 데이터를 사용하여 문제를 해결하세요. 미국 중서부 지역의 인구통계 데이터
midwest <- as.data.frame(ggplot2::midwest)

## 실습 8. '전체 인구 대비 미성년 인구 비율' 변수를 추가하고, 미성년 인구 비율이 가장 높은 상위 5개 지역을 출력

midwest <- midwest %>%
            mutate(notadult=((poptotal-popadults)/poptotal)*100)

midwest %>%
  arrange(desc(notadult)) %>%
  select(county, notadult) %>%
  head(5)

## 실습 9. 아래 분류표를 참고하여 미성년 비율 등급 변수를 추가하고, 각 등급별 몇 개의 지역이 있는지 확인
### Large : 40% 이상 / Middle : 30~40% / Small : 30% 미만
midwest <- midwest %>%
  mutate(grade=ifelse(notadult>=40, "large",
                      ifelse(notadult>=30, "middle", "small")))

table(midwest$grade)

## 실습 10. '전체 인구 대비 아시아인 인구 비율' 변수를 추가하고, 하위 10개 지역의 주, 지역명, 비율을 출력
midwest %>%
  mutate(ratio_asian=(popasian/poptotal)*100) %>%
  arrange(ratio_asian) %>%
  select(state,county, ratio_asian) %>%
  head(10)