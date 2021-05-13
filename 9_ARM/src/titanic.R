####################################################
#   Titanic dataset으로 연관규칙 생성
####################################################

#데이터셋 확인
str(Titanic)

#raw data를 데이터 프레임으로 전환
df <- as.data.frame(Titanic)
df

# 알고리즘에 적용할 수 있도록 데이터 변경
titanic.raw <- NULL
for(i in 1:4){
    titanic.raw <- cbind(titanic.raw, rep(as.character(df[, i]), df$Freq))
}
titanic.raw

#데이터 프레임으로 변경
titanic.raw <- as.data.frame(titanic.raw,
                            stringsAsFactors = TRUE)
titanic.raw
str(titanic.raw)

#변수명 생성
names(titanic.raw) <- names(df)[1:4]

#데이터 확인
head(titanic.raw)

#연관 규칙 생성
rules.all <- apriori(titanic.raw, control=list(verbose=F))
rules.all
summary(rules.all)
inspect(rules.all)

#생사 여부에 대한 rule만 생성
#lhs 다른 모든 속성이 포함
#최소 2개 항목으로
rules <- apriori(titanic.raw, control=list(verbose=F),
                parameter = list(minlen=2, supp=0.005, conf=0.8),
                appearance = list(rhs = c("Survived=No", "Survived=Yes")))

quality(rules) <- round(quality(rules), digits = 2)
inspect(sort(rules, by="lift"))

#각 클래스별 어린이/어른의 생사여부에 대한 마이닝
rules <- apriori(titanic.raw, control=list(verbose=F),
                parameter = list(minlen=3, supp=0.002, conf=0.2),
                appearance = list(rhs = c("Survived=Yes"),
                                    lhs=c("Class=1st", "Class=2nd",
                                    "Class=3rd", "Age=Child", "Age=Adult")))

quality(rules) <- round(quality(rules), digits = 2)
inspect(sort(rules, by="lift"))
