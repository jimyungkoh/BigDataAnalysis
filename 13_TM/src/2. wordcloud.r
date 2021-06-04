#패키지 설치 및 로드
##install.packages("wordcloud")
##install.packages("RColorBrewer")
library(wordcloud)
library(RColorBrewer)

str(dtm)
m <- as.matrix(dtm)
m
v <- sort(colSums(m), decreasing = T) #컬럼 단위(모든 문서)로 빈도수 합
v
d <- data.frame(word=names(v), freq=v) #matrix to data frame
head(d)
?wordcloud
#create wordcloud
wordcloud(words=d$word,
    freq=d$freq,
    min.freq = 1,
    max.words = 100,
    random.order = F,
    rot.per=0.25)

#컬러 팔레트 사용
display.brewer.all()
pal <- brewer.pal(8, "Spectral")
wordcloud(words=d$word,
    freq=d$freq,
    min.freq = 1,
    max.words = 100,
    random.order = F,
    rot.per=0.5,
    colors=pal,
    family="mono",
    font=2)

#워드 클라우드를 더 간단하고 예쁘게 생성 - wordcloud2
##devtools::install_github("lchiffon/wordcloud2")
library(wordcloud2)
?wordcloud2
wordcloud2(d)

#================================================================
# 위키피디아에서 한국어 키워드 "빅데이터" 검색 후 워드 클라우드 사용
#================================================================
t <- readLines("https://ko.wikipedia.org/wiki/%EB%B9%85_%EB%8D%B0%EC%9D%B4%ED%84%B0")
d <- htmlParse(t, asText = T)
clean_doc <- xpathSApply(d, "//p", xmlValue)

doc <- Corpus(VectorSource(clean_doc))
head(doc)
inspect(doc)


#DTM 구축: DocumentTermMatrix
dtm <- DocumentTermMatrix(doc)
dim(dtm)
inspect(dtm)

 m <- as.matrix(dtm)
 v <- sort(colSums(m), decreasing = T)
 d <- data.frame(word=names(v), freq=v)
 d1 <- d[1:500,]
 wordcloud2(d1)


#===============================================
## 한국어 분석용 KoNLP
#install.packages("rJava")
#install.packages("memoise")
#install.packages("multilinguer")
#install.packages(c("stringr", "hash", "tau", "Sejong", "RSQLite", "devtools"), type = "binary")
#install.packages("KoNLP")
#install.packages("remotes")
#remotes::install_github("haven-jeon/KoNLP", upgrade="never", INSTALL_opts=c("--no-multiarch"))
#Sys.setenv(JAVA_HOME= "C:/Program Files/Java/jre1.8.0_261")
#===============================================
#devtools::install_github("haven-jeon/KoNLP")
library(KoNLP)

#형태소 사전
useNIADic()

#명사 추출: extractNoun
n1 <- extractNoun("롯데마트가 판매하고 있는 흑마늘 양념 치킨이 논란이 되고 있다")
str(n1); n1
n2 <- extractNoun(c("R은 free 소프트웨어이고, [완전하게 무보증]입니다.",
                    "일정한 조건에 따르면, 자유롭게 이것을 재배포할수가 있습니다."))
n2

useSejongDic()

#사용자 사전
n2
buildDictionary(ext_dic = "sejong",
                user_dic=data.frame(term="무보증", tag="ncn"),
                replace_usr_dic=T)
extractNoun(c("R은 free 소프트웨어이고, [완전하게 무보증]입니다.",
                    "일정한 조건에 따르면, 자유롭게 이것을 재배포할수가 있습니다."))

#txt 파일 분석
## hiphop 가사 워드 클라우드
hiphop <- readLines("13_TM/data/hiphop.txt")
head(hiphop)
nouns <- extractNoun(hiphop) #명사 추출
str(nouns)
c <- unlist(nouns) # 명사 list를 문자열 벡터로 변환
wd <- Filter(function(x) {nchar(x) >= 2}, c)  #2글자 이상 단어만 추출하는 함수
wd_cnt <- table(wd) #단어 빈도수
v <- sort(wd_cnt, decreasing = T)
head(v)
wordcloud2(v)

##프로포즈 선물 워드 클라우드 
propose <- readLines("13_TM/data/propose.txt")
head(propose)
nouns <- extractNoun(propose) #명사 추출
c <- unlist(nouns) # 명사 list를 문자열 벡터로 변환
wd <- Filter(function(x) {nchar(x) >= 2}, c)  #2글자 이상 단어만 추출하는 함수
wd_cnt <- table(wd) #단어 빈도수
v <- sort(wd_cnt, decreasing = T)
wordcloud2(v)

#단어 정제
head(names(v), 20)

wd <- gsub("프로포즈", "", wd)
wd <- gsub("^ㅎ", "", wd)
wd <- gsub("하시", "", wd)
wd <- gsub("해서", "", wd)
wd <- gsub("거기", "", wd)
wd <- gsub("경우", "", wd)
wd <- Filter(function(x) {nchar(x) >= 2}, wd)  #2글자 이상 단어만 추출하는 함수
wd_cnt <- table(wd) #단어 빈도수
v <- sort(wd_cnt, decreasing = T)
wordcloud2(v)
head(v, 20)
wc_data <- v[1:100]
wordcloud2(wc_data, figPath = "13_TM/data/heart.png", size=1.5)
letterCloud(wc_data, word="R", size=2)

