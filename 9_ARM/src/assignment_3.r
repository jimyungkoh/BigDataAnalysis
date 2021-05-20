####################################################
#   Titanic dataset으로 연관규칙 생성
####################################################

#패키지 설치: arules(연관규칙분석 패키지)
library(arules)

#데이터셋을 확인합니다.
str(Titanic)

#raw data를 데이터 프레임으로 전환합니다.
df <- as.data.frame(Titanic)

# 알고리즘에 적용할 수 있도록 데이터를 변경합니다.
titanic.raw <- NULL
for(i in 1:4){
    titanic.raw <- cbind(titanic.raw, rep(as.character(df[, i]), df$Freq))
}

#문자열 형인 titanic.raw를 데이터 프레임으로 변경합니다.
titanic.raw <- as.data.frame(titanic.raw,
                            stringsAsFactors = TRUE)

#titanic.raw 데이터에 변수(Column)명을 추가합니다.
#           ("Class", "Sex", "Age", "Survived")
names(titanic.raw) <- names(df)[1:4]

#연관 규칙 생성
## apriori 인자 설명
## data 인자: titinic.raw
## parameter 인자: 규칙에 포함되는 최소 길이, 최소 지지도, 최소 신뢰도
## appearance 인자: 원하는 아이템[list(rhs=c("Survived=Yes")만 노출)]
## lhs(Left Hand Side): 왼쪽에 규칙을 구성
rules <- apriori(titanic.raw, control=list(verbose=F),
            parameter = list(minlen=3, supp=0.0015, conf=0.13),
            appearance = list(rhs=c("Survived=Yes"),
            lhs=c("Class=1st", "Class=2nd", "Class=3rd",
            "Sex=Male", "Sex=Female"),
            default="none"))

#quality(): SOM(Self-Organizing Map) 알고리즘을 활용해 결괏값으로부터
#           몇몇 Quality 지표를 생성합니다. 
#두 자릿수로 제한된 퀄리티 지표를 산출합니다.
quality(rules) <- round(quality(rules), digits = 2)

#inspect(): Transaction Object의 연관 규칙 내용 확인합니다.
#           (lift 내림차순으로 정렬된)
result <- inspect(sort(rules, by="lift")) 

#One More Thing!
##sex에 성별과 등급 정보를 담는데
#   , 필요한 정보만 남기기 위해 gsub을 통해 값을 정제합니다.
sex = result[, 1]
sex = gsub("Class=","",sex)
sex = gsub("Sex=","",sex)
sex = gsub("Male","M",sex)
sex = gsub("Female","F",sex)
sex = as.factor(sex)

##lift: {등급, 성별}의 신뢰도/{살아남은 경우}
#       즉, 단순히 살아남은 경우보다 {등급, 성별}이 주어졌을 때 
#       살아남을 확률이 얼마나 증가했는가를 나타냅니다.
lift = as.numeric(result[, 7])

#plot 함수를 통해 데이터를 시각화합니다!
plot(sex, lift, xlab="좌석 등급과 성별", ylab="lift")