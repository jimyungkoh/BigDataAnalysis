library(ggplot2)
# 데이터 전처리 - 원하는 형태로 데이터 가공하기
## dplyr  함수를 이용해 데이터를 가공하는 방법
## filter(): 행 추출 | select(): 열(변수) 추출 | arranger(): 정렬
## mutate(): 변수 추가 | summarise(): 통계치 산출 | group_by(): 집단별로 나누기
## left_join(): 데이터 합치기(열) | bind_rows(): 데이터 합치기(행)

#조건에 맞는 데이터만 추출하기
library(dplyr)
exam <- read.csv("csv_exam.csv")
exam

##exam에서 class가 1인 경우만 추출해 출력
exam %>% filter(class==1)
### dplyr 패키지는 %>% 기호를 이용해 함수들을 나열하는 방식으로 코드를 작성한다.
### 위 코드는 exam을 출력하되, class가 1인 행만 추출하라는 조건이 지정됌.
### filter() 함수에 조건을 입력하면 조건에 해당되는 행만 추출한다.

### 밑에 같은 방식으로 2반 학생만 추출해보세요.
exam %>% filter(class==2)

#초과, 미만, 이상, 이하 조건 걸기
exam %>% filter(math>50) ## 수학 점수가 50점을 초과한 경우
exam %>% filter(math<50) ## 수학 점수가 50점 미만인 경우
exam %>% filter(math>=50) ## 수학 점수가 50점 이상인 경우
exam %>% filter(math<=50) ## 수학 점수가 50점 이하인 경우

#여러 조건을 충족하는 행 추출하기
##1반이면서 수학 점수가 50점 이상인 경우
exam %>% filter(class==1&math>=50)
##2반이면서 영어 점수가 80점 이상인 경우
exam %>% filter(class==2&english>=80)

#여러 조건 중 하나 이상 충족하는 행 추출하기('or'을 의미하는 '|' 기호 이용)
##영어 점수가 90점 미만이거나 과학 점수가 50점 미만인 데이터를 추출하세요~
exam %>% filter(english<90 | science<50)

#목록에 해당하는 행 추출하기
##1,3,5반에 해당하면 추출
exam %>% filter(class==1|class==3|class==5)
###이때, %in%(매치 연산자) 기호를 사용하면
###코드를 좀 더 간편하게 작성할 수 있다!
exam %>% filter(class %in% c(1,3,5))

#추출한 행으로 데이터 만들기
class1 <- exam %>% filter(class==1)
class2 <- exam %>% filter(class==2)
mean(class1$math)
mean(class2$math)

#내가 몰랐던 산술 연산가
##  %/%: 나눗셈의 몫
##  %%: 나눗셈의 나머지

#   혼자서 해보기(mpg 데이터를 이용한)
## Q1. 자동차 배기량에 따라 고속도로 연비가 다른지 알아보려고 합니다.
##      displ(배기량)이 4 이하인 자동차와 5 이상인 자동차 중 어떤 자동차의 
##      hwy(고속도로 연비)가 평균적으로 더 높은지 알아보세요
displ1 <- mpg %>% filter(displ<=4)
displ2 <- mpg %>% filter(displ>=5)
mean(displ1$hwy, na.rm =TRUE)
mean(displ2$hwy, na.rm = TRUE)

## Q2. 자동차 제조 회사에 따라 도시 연비가 다른지 알아보려고 합니다. "audi"와
##      "toyota"중 어느 manufacturer의 cty(도시 연비)가 평균적으로
##      더 높은지 알아보세요.
audi <- mpg %>% filter(manufacturer=="audi")
toyota <- mpg %>% filter(manufacturer=="toyota")
mean(audi$cty)
mean(toyota$cty)

## Q3. "chevrolet", "ford", "honda" 자동차의 고속도로 연비 평균을 알아보려고
##      합니다. 이 회사들의 데이터를 추출한 후 hwy 전체 평균을 구하세요.
makers <- mpg %>% filter(manufacturer %in% c("chevrolet", "ford", "honda"))
mean(makers$hwy)

#필요한 변수만 추출하기
# select()는 데이터에 들어 있는 수많은 변수 중 일부만 추출해
# 활용하고자 할 때 사용합니다~!

exam %>% select(math) ## math 추출
exam %>% select(english) ## english 추출

##여러 변수 추출하기(쉼표를 넣어 변수명을 나열해보자)
exam %>% select(class, math, english)

##변수 제외하기
exam %>% select(-math, -english)

#dplyr 함수 조합하기

## filter()와 select() 조합하기
### class가 1인 행만 추출한 다음 english 추출
exam %>% filter(class==1) %>% select(english)

##가독성 있게 줄 바꾸기
exam %>%
  filter(class==1) %>% ### class가 1인 행 추출
  select(english) ### english 추출

##일부만 출력하기
exam %>% 
  select(id, math) %>% 
  head ###괄호 없이 head만 쓰면 6행까지 출력된당

exam %>%
  select(id, math) %>% ### id, math 추출
  head(10) ### 앞부분 10행까지 추출

#혼자서 해보기(mpg 데이터를 이용한)
## Q1. mpg 데이터는 11개 변수로 구성되어 있다. 이 중 일부만 추출해 분석에 활용
##      하고자 함. mpg 데이터 중 class, cty 변수를 추출해 새로운 데이터를 
##      만드시오. 새로 만든 데이터의 일부를 출력해 두 변수로만 구성되어 있는지
##      확인하세요.
classcty <- mpg %>%
              select(class, cty)
head(classcty,10)

## Q2. 자동차 종류에 따라 도시 연비가 다른지 알아보고자 합니다.
##      앞에서 추출한 데이터를 이용해 class가 "suv"인 자동차와 "compact"인
##      자동차 중 어떤 자동차의 cty 평균이 더 높은지 구하세요.
suv <- classcty %>% filter(class=="suv")
compact <- classcty %>% filter(class=="compact")
mean(suv$cty)
mean(compact$cty)

#순서대로 정렬하기(arrange 함수를 이용한)
exam %>% arrange(math)
##내림차순 정렬
exam %>% arrange(desc(math))
### 정렬 기준으로 삼을 변수를 여러 개 지정하려면? 쉼표를 이용해 변수명 나열
### 밑 코드는 반으로 오름차순 정렬 후 각 반에서 수학점수 기준으로 오름차순 정렬
exam %>% arrange(class, math)

# mpg 데이터를 이용한 분석 문제 해결
## Q1. "audi"에서 생산한 자동차 중 어떤 자동차 모델의 hwy가 높은지 알아보려고 한다.
##      "audi"에서 생산한 자동차 중 hwy가 1~5위에 해당하는 자동차의 데이터를 출력하시오.
audi <- mpg %>% filter(manufacturer=="audi")
audi %>% arrange(desc(hwy)) %>% head(5)

#파생변수 추가하기(mutate 함수를 사용한다)
exam %>%
  mutate(total=math+english+science) %>%
  head
##여러 파생변수 한번에 추가하기
exam %>%
  mutate(total=math+english+science,
         mean=(math+english+science)/3) %>%
  head
## mutate()에 ifelse() 적용하기
exam %>%
  mutate(test =ifelse(science>=60, "pass", "fail")) %>%
  head
##추가한 변수를 dplyr 코드에 바로 활용하기
exam %>%
  mutate(total=math+english+science) %>% ###total 변수 추가
  arrange(total) %>% ### total 변수 기준 정렬
  head ### 일부 추출

#mpg 데이터를 이용해 분석 문제 해결하기
## Q1. mpg() 데이터 복사본을 만들고, cty, hwy를 더한 합산 연비 변수를 추가하세요.
mpg <- as.data.frame(mpg)
mpg <- mpg %>% mutate(totalfe=cty+hwy)

##앞에서 만든 '합산 연비 변수'를 2로 나눠 '평균 연비 변수'를 추가하세요.
mpg <- mpg %>% mutate(meanfe=totalfe/2)
mpg

##'평균 연비 변수'가 가장 높은 자동차 3종의 데이터를 출력하세요.
mpg %>% arrange(desc(meanfe)) %>% head(3)

##1~3번 문제를 해결할 수 있는 하나로 연결된 dplyr 구문을 만들어 실행해 보세요.
##데이터는 복사본 대신 mpg 원본을 이용하세요.
mpg %>%
  mutate(totalfe=cty+hwy, meanfe=totalfe/2) %>%
  arrange(desc(meanfe)) %>%
  head(3)

#집단별로 요약하기[group_by()와 summarise()를 이용한]
exam %>% summarise(mean_math=mean(math)) ##math 평균 산출
##  summarise()는 전체를 요약한 값보다는 group_by()와 조합해 집단별 요약표를
##  만들 때 사용합니다.

exam %>%
  group_by(class) %>% # class별로 분리
  summarise(mean_math=mean(math)) # math 평균 산출

#여러 요약 통계량 한번에 산출하기
exam %>%
  group_by(class) %>% # class 별로 분리
  summarise(mean_math=mean(math), # math 평균
            sum_math=sum(math), # math 합계
            median_math=median(math), # math 중앙값
            n=n()) # 학생 수
##n()은 데이터가 몇 행으로 되어 있는지 '빈도'를 구하는 기능

#dplyr 조합하기(dplyr 패키지는 함수를 조합할 때 진가를 발휘함)
mpg %>%
  group_by(manufacturer) %>% # 회사별로 분리
  filter(class == "suv") %>% # suv 추출
  mutate(tot=(cty+hwy)/2) %>% # 통합 연비 변수 생성
  summarise(mean_tot=mean(tot)) %>% #통합 연비 평균 산출
  arrange(desc(mean_tot)) %>%
  head(5) # 1~5위까지 출력

#mpg 데이터를 이용해 분석 문제를 해결해 보세요.
## Q1. mpg 데이터의 class는 "suv", "compact" 등 자동차를 특징에 따라 일곱 종류로 분류한 변수입니다. 어떤 차종의 도시 연비가 높은지 비교해 보려고 합니다. class별 cty 평균을 구해 보세요.
mpg %>%
  group_by(class) %>%
  summarise(mean_cty=mean(cty)) %>%
  arrange(desc(mean_cty))
## Q2. 어떤 회사 자동차의 hwy가 가장 높은지 알아보려고 합니다. hwy 평균이 가장 높은 회사 세 곳을 출력하세요.
mpg %>%
  group_by(manufacturer) %>%
  summarise(mean_hwy=mean(hwy)) %>%
  arrange(desc(mean_hwy)) %>%
  head(3)
## Q3. 어떤 회사에서 "compact"(경차) 차종을 가장 많이 생산하는지 알아보려고 합니다. 각 회사별 "compact" 차종 수를 내림차순으로 정렬해 출력하세요.
mpg %>%
  group_by(manufacturer) %>%
  filter(class=="compact") %>%
  summarise(compact=n())%>%
  arrange(desc(compact))
### 답안
### mpg %>%
###     filter(class=="compact") %>%
###     group_by(manufacturer) %>%
###     summarise(count=n()) %>%
###     arrange(desc(count))

#데이터 합치기
##가로로 합치기
###중간고사 데이터 생성
test1 <- data.frame(id=c(1,2,3,4,5),
                    midterm=c(60,80,70,90,85))
###기말고사 데이터 생성
test2 <- data.frame(id=c(1,2,3,4,5),
                    final=c(70,83,65,95,80))
test1
test2
### dplyr 패키지의 left_join()을 이용하면 데이터를 가로로 합칠 수 있다!
### by에 기준 변수를 지정할 때 변수명 앞뒤에 따옴표를 입력해야 한다.
total <- left_join(test1, test2, by="id")
total

##다른 데이터를 활용해 변수 추가하기
###left_join()을 응용하면 특정 변수의 값을 기준으로 다른 데이터의 값을 추가할 수 있다.
### 예를 들어, 지역 번호가 들어있는 데이터를 분석할 경우, 어떤 지역인지 알 수 있도록 지역 이름을 추가해야 할 때가 있는데, 지역 번호별 지역 이름을 나타낸 데이터가 있다면 분석 중인 데이터에 지역 이름을 추가할 수 있다.

name <- data.frame(class=c(1,2,3,4,5),
                   teacher=c("안젤리나 졸리", "앤 해서웨이", "엠버 허드", "한효주", "권은비"))
name

exam_new <- left_join(exam, name, by="class")
exam_new

##세로로 합치기[bind_rows()를 이용한]
### 학생 1~5번 시험 데이터 생성
group_a <-data_frame(id=c(1,2,3,4,5),
                     test=c(60,80,70,90,85))
### 학생 6~10번 시험 데이터 생성
group_b <- data_frame(id=c(6,7,8,9,10),
                      test=c(70,83,65,95,80))
group_a; group_b

group_all <- bind_rows(group_a,group_b)
group_all

#혼자서 해보기: mpg 데이터를 이용해 분석 문제를 해결해 보세요(156~157pp)

fuel <- data.frame(fl=c("c","d","e","p","r"),
                   price_fl=c(2.35,2.38,2.11,2.76,2.22),
                   stringsAsFactors = F)
##stringsAsFactors=F 는 문자를 Factor 타입으로 변환하지 않도록 설정하는 파라미터임. data.frame()은 변수에 문자가 들어 있으면 factor 타입으로 변환하도록 기본 설정되어 있고, fl을 mpg 데이터와 동일하게 문자 타입(chr)으로 만들어야 분석 작업에서 오류가 발생하지 않기 때문에 이 파라미터를 성정한 것임.

## Q1. mpg 데이터에는 연료 종류를 나타낸 fl 변수는 있지만 연료 가격을 나타낸 변수는 없다. 위에서 만든 fuel 데이터를 이용해 mpg 데이터에 price_fl 변수를 추가하시오.

mpg <- left_join(mpg, fuel, by="fl")
mpg

## Q2. 연료 가격 변수가 잘 추가됐는지 확인하기 위해 model, fl, price_fl 변수를 추출해 앞부분 5행을 출력해보세요.

mpg %>% select(model, fl, price_fl) %>% head(5)

#분석 도전!
#미국 동북중부 427개 지역의 인구통계 정보를 담고 있는 midwest 데이터를 사용해 데이터 분석 문제를 해결해 보세요. midwest는 ggplot2 패키지에 들어 있습니다.
midwest <- as.data.frame(ggplot2::midwest)
##문제 1. popadults는 해당 지역의 성인 인구, poptotal은 전체 인구를 나타냅니다. midwest 데이터에 '전체 인구 대비 미성년 인구 백분율' 변수를 추가하세요.
midwest <- midwest %>%
            mutate(notadult=((poptotal-popadults)/poptotal)*100)

##문제2. 미성년 인구 백분율이 가장 높은 상위 5개 county(지역)의 미성년 인구 백분율을 출력하세요.
midwest %>%
  group_by(county) %>%
  arrange(desc(notadult)) %>%
  select(county, notadult) %>%
  head(5)

##문제3. 분류표의 기준에 따라 미성년 비율 등급 변수를 추가하고, 각 등급에 몇 개의 지역이 있는지 알아보세요.
midwest %>%
  mutate(class
         =ifelse(notadult>=40, "large", ifelse(notadult>=30, "middle", "small"))) %>%
  group_by(class) %>%
  summarise(n=n())
###답안
midwest <- midwest %>%
  mutate(grade=ifelse(notadult>=40, "large",
                      ifelse(notadult>=30, "middle", "small")))

####미성년 비율 등급 빈도표
table(midwest$grade)

##문제4. popasian은 해당 지역의 아시아인 인구를 나타냅니다. '전체 인구 대비 아시아인 인구 백분율' 변수를 추가하고 하위 10개 지역의 state(주), county(지역), 아시아인 인구 백분율을 출력하세요.
###답안
midwest %>%
  mutate(ratio_asian=(popasian/poptotal)*100) %>%
  arrange(ratio_asian) %>%
  select(state,county, ratio_asian) %>%
  head(10)