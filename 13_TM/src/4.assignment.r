Sys.setenv(JAVA_HOME= "C:/Program Files/Java/jdk-11.0.2")
library(RCurl)
library(XML)
library(KoNLP)
library(tm)
library(wordcloud2)
library(stringr)
#1. 공동구매 요청 테이블을 분석해서 가장 인기 있는 아이템 찾기 (order.txt)
?readLines()
order <- readLines("13_TM/data/order.txt", encoding = "UTF-8")
nouns <- extractNoun(order) #명사 추출
c <- unlist(nouns) # 명사 list를 문자열 벡터로 변환
wd <- Filter(function(x) {nchar(x) >= 2}, c)  #2글자 이상 단어만 추출하는 함수
wd <- gsub("언제", "", wd) 
wd <- gsub("인생", "", wd)
wd <- gsub("영역", "", wd)
wd <- gsub("해주", "", wd)
wd <- gsub("공구", "", wd)
wd <- gsub("해요", "", wd)
wd <- gsub("퍼스나콘/아이디", "", wd) 
wd <- gsub("[a-z]", "", wd) #영소문자 제거
wd <- gsub("[A-Z]", "", wd) #영대문자 제거
wd <- gsub("\\d+", "", wd) #모든 숫자 정제
wd <- Filter(function(x) {nchar(x) >= 2}, wd)
wd_cnt <- table(wd) #단어 빈도수
v <- sort(wd_cnt, decreasing = T)
head(v)
wordcloud2(v[1:100])


#2. 고객 불만 게시판 분석해서 불만 요인 파악하기 (comp.txt)
comp <- readLines("13_TM/data/comp.txt", encoding = "UTF-8")
nouns <- extractNoun(comp) #명사 추출
c <- unlist(nouns) # 명사 list를 문자열 벡터로 변환
wd <- Filter(function(x) {nchar(x) >= 2}, c)  #2글자 이상 단어만 추출하는 함수
wd <- gsub("\\d+", "", wd) #모든 숫자 정제
wd <- gsub("퍼스나콘/아이디", "", wd)
wd <- gsub("[a-z]", "", wd) #영소문자 제거
wd <- gsub("[A-Z]", "", wd) #영대문자 제거
wd <- gsub("영역", "", wd)
wd <- Filter(function(x) {nchar(x) >= 2}, wd)
wd_cnt <- table(wd) #단어 빈도수
v <- sort(wd_cnt, decreasing = T)
wordcloud2(v[1:100])
head(v, 10)

#3. 서울시 홈페이지에서 시민참여 게시판 분석하기 (seoul.txt)
seoul <- readLines("data/seoul.txt", encoding = "UTF-8")
nouns <- extractNoun(seoul) #명사 추출
c <- unlist(nouns) # 명사 list를 문자열 벡터로 변환
wd <- Filter(function(x) {nchar(x) >= 2}, c)  #2글자 이상 단어만 추출하는 함수
wd <- gsub("\\d+", "", wd) #모든 숫자 정제
wd <- gsub("[a-z]", "", wd) #영소문자 제거
wd <- gsub("[A-Z]", "", wd) #영대문자 제거
wd <- Filter(function(x) {nchar(x) >= 2}, wd)
wd_cnt <- table(wd) #단어 빈도수
v <- sort(wd_cnt, decreasing = T)
letterCloud(v, word="SEOUL", size=5)
wordcloud2(v[1:100], size=1, shape= "cardioid")
head(v,10)

#4. 뉴스에서 관심 키워드의 기사를 검색하여 주제어 분석하기
##install.packages("RSelenium")
library(RSelenium)
library(rvest)
library(tidyverse)
library(dplyr)
setwd("13_TM/data")
remDR <- remoteDriver(remoteServerAddr = 'localhost',port = 4445L, browserName = 'chrome')
 
remDR$open()
headlines=NULL
left="https://search.naver.com/search.naver?where=news&sm=tab_pge&
query=%ED%95%9C%EA%B5%AD%EC%82%B0%EC%97%85%EA%B8%B0%EC%88%A0%EB%8C%80&sort=2&photo=0&field=0&pd=13&
ds=2021.02.28&de=2021.05.29&mynews=0&office_type=0&office_section_code=0&news_office_checked=&
nso=so:r,p:3m,a:all&start="

for (i in 0:78){
    page_num=as.character(1+i*10)
    url=paste0(left, page_num, collapse = "")
    remDR$navigate(url)
    parsed <- remDR$getPageSource()[[1]] %>% read_html()
    title <- parsed %>% html_nodes(".list_news") %>% html_nodes(".news_area > a") %>% html_text()
    headlines <- append(headlines, title)
}

write.table(headlines, file="headlines.txt", fileEncoding = "UTF-8")

kpu <- readLines("headlines.txt", encoding = "UTF-8")
nouns <- extractNoun(kpu) #명사 추출
c <- unlist(nouns) # 명사 list를 문자열 벡터로 변환
wd <- Filter(function(x) {nchar(x) >= 2}, c)  #2글자 이상 단어만 추출하는 함수
wd <- gsub("\\d+", "", wd) #모든 숫자 정제
wd <- gsub("[a-z]", "", wd) #영소문자 제거
wd <- gsub("[A-Z]", "", wd) #영대문자 제거
wd <- gsub("기대", "", wd) #영대문자 제거
wd <- gsub("대학", "", wd) #영대문자 제거
wd <- gsub("한국산", "", wd) #영대문자 제거
wd <- gsub("업기술", "", wd) #영대문자 제거
wd <- Filter(function(x) {nchar(x) >= 2}, wd)
wd_cnt <- table(wd) #단어 빈도수
v <- sort(wd_cnt, decreasing = T)
wordcloud2(v[1:100], shape="diamond", size=0.7)
head(v,10)