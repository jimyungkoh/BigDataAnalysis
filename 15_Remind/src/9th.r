######################################################
############ 연관규칙 #################################
######################################################

#패키지 설치 : arules
#arules는 연관규칙 패키지임
library(arules)

#트랜젝션 데이터 불러오기
market <- read.transactions(file= "BigDataAnalysis/15_Remind/data/groceries.csv", format="basket", sep=",")

summary(market)

#트랜젝션 데이터 내용 확인: inspect()
inspect(market[1:10])

#항목이 트랜젝션에서 나타나는 비율 (support): itemFrequency()
itemFrequency(market[,1:10])

#지지도 상위 5개 항목의 막대 그래프 시각화: itemFrequencyPlot()
itemFrequencyPlot(market, topN=5, main="support top-5 items")

#apriori 알고리즘으로 연관 규칙 생성
##apriori(): 빈발 항목집합, 연관규칙, 연관 하이퍼그래프를 apriori algorithm으로 마이닝
rules.all <- apriori(market)

#규칙 확인
rules.all ##규칙의 개수만 확인함 ..
summary(rules.all) ## 규칙의 요약 통계만 확인..
inspect(rules.all)

#규칙 다듬기 1
##항목 size 1인 것 제외(항목 집합의 최소 길이 = 2)
##지지도 0.3, 신뢰도 0.9 함수
rules <- apriori(market, parameter = list(minlen=2, support=0.3, confidence=0.9))
rules
inspect(rules)

#규칙 결과 정렬
rules.sorted <- sort(rules, by="confidence")
inspect(rules.sorted)

#규칙 다듬기 2
##지지도와 신뢰도를 조정해서 규칙을 생성, lift를 중심으로 규칙 정렬
##지지도 0.3, 신뢰도 0.9 함수 처리 과정이 출력되지 않도록 (verbose=F) control 추가
rules <- apriori(market, control = list(verbose = F),
        parameter = list(minlen=2, support=0.2, confidence=0.8))
rules

##숫자 다듬기. confidence, lift 소수점 이하 2자리 표시
##The quality() computes several quality criteria for the result of a SOM algorithm.
quality(rules) <- round(quality(rules), digits = 2)

##규칙 결과 정렬
inspect(sort(rules, by="lift"))

#규칙 다듬기 3: shopping bags는 다른 항목과 독립적이므로 연관 규칙에서 제외
rules <- apriori(market, control = list(verbose=F),
        parameter=list(minlen=2, support=0.2, confidence=0.8),
        appearance=list(none="shopping bags"))

rules
quality(rules) <- round(quality(rules), digits=2)
inspect(sort(rules, by="lift"))

##일부 규칙 확인(상위 10개만)
inspect(sort(rules, by="lift")[1:10])

#생성한 연관 규칙을 데이터 프레임 구조로 변환해 csv 파일로 저장
rule_df <- as(rules, "data.frame")
rule_df

write.csv(rule_df,
        file="data/market_rules.csv",
        quote=TRUE,
        row.names=FALSE)

####################################################
######   Titanic dataset으로 연관규칙 생성
####################################################

#데이터셋 확인
##str(Titanic)

#raw data를 데이터 프레임으로 전환
df <- as.data.frame(Titanic)

#알고리즘에 적용할 수 있도록 데이터 변경
titanic.raw <- NULL
for(i in 1:4){
    titanic.raw <- cbind(titanic.raw, rep(as.character(df[, i]), df$Freq))
}

#데이터 프레임으로 변경
titanic.raw <- as.data.frame(titanic.raw,
                            stringAsFactors = True)

#변수명 생성
names(titanic.raw) <- names(df)[1:4]

#데이터 확인
##head(titanic.raw)

#연관 규칙 생성
rules.all <- apriori(titanic.raw, control = list(verbose=F))
summary(rules.all)
inspect(rules.all)

#생사 여부에 대한 rule만 생성
#lhs 다른 모든 속성이 포함
#최소 2개 항목으로
rules <- apriori(titanic.raw, control = list(verbose=F),
        parameter = list(minlen=2, supp=0.005, conf=0.8),
        appearance = list(rhs=c("Survived=No", "Survived=Yes")))

quality(rules) <- round(quality(rules), digits=2)
inspect(sort(rules, by="lift"))

#각 클래스별 어린이/어른의 생사여부에 대한 마이닝
rules <- apriori(titanic.raw, control=list(verbose=F),
                parameter=list(minlent=3, supp=0.002, conf=0.2),
                appearance = list(rhs=c("Survived=Yes"),
                                        lhs=c("Class=1st", "Class=2nd",
                                        "Class=3rd", "Age=Child", "Age=Adult")))

quality(rules) <- round(quality(rules), digits=2)
inspect(sort(rules, by="lift"))