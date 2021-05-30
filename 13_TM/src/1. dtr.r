#패키지 설치 및 로드 - 웹 문서 가져오기
#install.packages("RCurl") #웹 서버 접속
#install.packages("XML") #웹 문서 처리 패키지
library(RCurl)
library(XML)

#문서 가져오기 -> 위키피디아 "data science"
t <- readLines("https://en.wikipedia.org/wiki/Data_science")
head(t)
str(t)
## 웹 문서를 R의 데이터형으로 변환 : htmlParse, xpathSApply
d <- htmlParse(t, asText = T)
clean_doc <- xpathSApply(d, "//p", xmlValue)
head(clean_doc)

#텍스트 분석 기본 패키지 설치 및 로드
#install.packages("tm") #텍스트 마이닝 함수 제공
#install.packages("SnowballC") #어근 추출 함수 제공
library(tm)
library(SnowballC)

#tm::VectorSource(x) -> 벡터 x의 각 element를 document로 변환
#tm::Corpus -> 문서 집합인 코퍼스 생성
doc <- Corpus(VectorSource(clean_doc))
head(doc)
inspect(doc)

#전처리 수행: tm_map
doc <- tm_map(doc,content_transformer(tolower))
doc <- tm_map(doc,removeNumbers)
doc <- tm_map(doc,removeWords, stopwords("english"))
doc <- tm_map(doc,removePunctuation)
doc <- tm_map(doc,stripWhitespace)

#DTM 구축: DocumentTermMatrix
dtm <- DocumentTermMatrix(doc)
dim(dtm)
inspect(dtm)

# 최소 단어 빈도수가 n 이상인 term 찾기 -> tm::findFreqTerms
findFreqTerms(dtm, lowfreq = 7)

#주어진 단어와 연관된 단어 찾기 -> findAssocs()
findAssocs(dtm, terms="methods", corlimit = 0.6)

#빈도 막대로 시각화하기
##barplot(d[1:10, ]$freq, col="lightblue")