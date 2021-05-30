library(RCurl)
library(XML)
library(KoNLP)
library(tm)
library(wordcloud2)

t <- readLines("https://www.etnews.com/")
d <- htmlParse(t, asText = T)
news <- xpathSApply(d, "//div[@class='et_contents_wrap']", xmlValue)
head(news)

news_pre <- gsub("[\n\t]", "", "news") #이스케이프 문자 제거
news_pre <- gsub("[[:punct:]]", "", "news") #문장 부호 제거
news_pre <- gsub("[[:cntrl:]]", "", "news") #제어 문자 제거
news_pre <- gsub("[a-z]", "", "news") #영소문자 제거
news_pre <- gsub("[A-Z]", "", "news") #영대문자 제거
news_pre <- gsub("\\s+", "", "news") #2개 이상 공백 제거

useNIADic()
nouns <- extractNoun(news_pre) #명사 추출
c <- unlist(nouns) # 명사 list를 문자열 벡터로 변환
wd <- Filter(function(x) {
            nchar(x) >= 2}, c)  #2글자 이상 단어만 추출하는 함수
wd_cnt <- table(wd) #단어 빈도수
v <- sort(wd_cnt, decreasing = T)
wordcloud2(v[1:100])