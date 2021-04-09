#데이터 정제를 위한 조건문
##인덱스 형식
data <- c(10,NA, 30, NA, 45)
data
data[data < 40]
data[data %% 3 !=0]

df <- data.frame(name=c("John", "Amy", "Steve"),
                 age=c(200, 16, 23),
                 gender=c("M", "F", "N"))

df

df[df$gender=="N",]

df[df$age>120| df$age<0,]

##if문 활용
x <- 5
if(x %% 2 == 0){
  print("짝수")
}else{
  print("홀수")
}

x <- -1
if (x>0){
  print("positive")
}else if(x<0){
  print("negative")
}else{
  print("zero")
}

##ifelse 함수 활용
city <- "Seoul"
ifelse(city=="Seoul", "Korea", "Other Country")

##조건문을 이용한 데이터 정제의 예
students <- read.csv("data/students.csv", header = TRUE,
                     fileEncoding = "CP949", encoding = "UTF-8")
students

students[, 2] <- ifelse(students[, 2]>=0 & students[, 2] <=100,
                        students[, 2], NA)
students[, 3] <- ifelse(students[, 3]>=0 & students[, 3] <=100,
                        students[, 3], NA)
students[, 4] <- ifelse(students[, 4]>=0 & students[, 4] <=100,
                        students[, 4], NA)
students

#데이터 정제 반복문
i <- 1
repeat {
  if(i>10){
    break
  }
  print(i)
  i <- i+1
}

i<-1
while (i<=10) {
  print(i)
  i<- i+1
}

for (i in 1:10) {
  print(i)  
  i <- i+1
}

##반복문을 이용한 데이터 정제
students <- read.csv("data/students.csv", header = TRUE,
                     fileEncoding = "CP949", encoding = "UTF-8")
students
for(i in 2:4){
  students[, i] <- ifelse(students[, i]>=0 & students[, i] <=100,
                          students[, i], NA)
}
students

##사용자 정의 함수
sumAtoB <- function(startNum=1, endNum=10){
  s <- 0
  for(i in startNum:endNum){
    s <- s+i
  }
  return(s)
}
sumAtoB()
sumAtoB(2,10)
sumAtoB(start=10, end=15)

#결측값 처리
str(airquality)
?airquality
air <- airquality

##결측치 확인
is.na(air$Ozone)

##빈도표 table
table(is.na(air))
table(is.na(air$Ozone))

##사용자 정의 함수를 이용하여 원하는 기능 추가하기
na.cnt <- function(x){
  table(is.na(x))
}
na.cnt(air$Ozone)
##결측치 제거: na.omit
air_del <- na.omit(air)
na.cnt(air_del)

colSums(air_del) ###컬럼별 합계
na_del <- is.na(air_del)
colSums(na_del)

##결측치 대체
meanOzone=mean(air$Ozone, na.rm=T)
air$Ozone[is.na(air$Ozone)] <- meanOzone
air2 <- airquality
na.cnt(air2)
air2$Ozone <- ifelse(is.na(air2$Ozone), meanOzone, air2$Ozone)
na.cnt(air2$Ozone)

#이상치 처리
## 특이값(존재할 수 없는 값)확인: table
outlier <- data.frame(gender =c(1,2,1,3,2,1), #성별 1 or 2
                     score=c(5,4,3,4,2,6)) #점수 1~5
outlier
table(outlier$gender)
table(outlier$score)

##특이값 처리: NA 부여
outlier$gender <- ifelse(outlier$gender==3, NA, outlier$gender)
outlier$score <- ifelse(outlier$score>5, NA, outlier$score)

##극단치 확인: boxplot()
air <- airquality
boxplot(air$Ozone)
boxplot(air$Ozone)$stats
air$Ozone <- ifelse(air$Ozone>122, NA, air$Ozone)
boxplot(air$Ozone)