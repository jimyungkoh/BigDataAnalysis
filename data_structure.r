install.packages("rmarkdown")
install.packages("knitr")
#Vector: R의 기본 데이터 타입

##벡터의 종류: 원자(atomic) 벡터

###벡터를 구성하는 요소를 더 이상 분리할 수 없는 경우
###logical, integer, double, character, complex, raw의 6가지 자료형을 가짐

###리스트(list) or 제네릭(generic) or 재귀(recursive) vector
### 벡터들을 다시 묶은 것, Features를 더 낮은 레벨로 분리 가능
### 한 리스트 안에서 서로 다른 타입의 벡터들이 올 수 있음

#벡터가 아닌 데이터 타입(but, 벡터를 기본으로 만들어짐)
##행렬(matrix), 배열(array), 데이터 프레임(data frame), 팩터(factor)

# 데이터 형
## 데이터 형 확인
###typeof(): 자료형 확인 기본 함수(C언어 기준)
typeof(1)
typeof("hello world")
### mode(): 자료형 확인 (old) 함수 (S언어 호환)
### integer, double이 numeric으로 표시되고 special,
### builtin이 function으로 표시되는 것을 제외하고 typeof()와 일치 
mode(1.0); mode(1)
typeof(5); typeof(1)
### class():객체의 유형
### metrix, array, function or numeric

# 변수/객체
## 생성
## 규칙: 알파벳(대소문자 구분), 숫자, 마침표(.), 언더라인(_)을 조합
## 숫자로 시작할 수 없고, '.'로 시작하는 경우 바로 뒤에 숫자가 올 수 없다.
## 이름 중간에 공백을 둘 수 없다(단, 벡틱을 사용하면 가능)
a <- 1
typeof(a)
`my data` <- c(1, 2, 3)
`my data`
typeof(`my data`)
`8` <- c(TRUE, FALSE, TRUE)
`8`
typeof(`8`)

#작업 공간
##작업이 이루어지는 공간에 대한 이해
x <- c(1, 2, 3)
y <- c("hi", "hello", "love", "u")
## x,y는 interactive workspace 또는 글로벌 환경이라 불리는 공간에 저장(.GlovalEnv)

## 글로벌 환경에 등록된 객체 관리
###객체 조회: ls()
ls()
###객체 삭제: rm()
rm(`8`)
ls()

#벡터를 생성하는 법
## c()를 통해 바인딩(<-)하거나, assign()을 통해 할당하거나
assign("z", c(10.4, 5.6, 3.1, 6.4, 21.7))

##연속형 벡터 생성: seq(), rep()
s1 <- seq(length = 51, from = -5, by = .2); s1
s2 <- rep(x, times = 5); s3 <- rep(x, each = 5); s2

##벡터 요소에 이름 부여: names()
fruit <- c(5, 10, 1, 20)
names(fruit) <- c("orange", "banana", "apple", "peach")

fruit

#벡터 인덱스
##벡터명(인덱스번호)
### 1. 인덱스 번호는 1부터 1씩 증가
### 2. 음수를 주면 해당 위치만 빼고 출력
### 3. [시작위치:끝] -> 시작~끝까지 출력
### 4. 인덱스도 벡터처럼 다룰 수 있음
### 5. 요소 이름으로 접근: fruit[c("apple", "orange")]

#데이터 형태의 변환
##데이터형 확인: class(), typeof(), mode(),
##              is.numeric(), is.character(), is.na(), etc.
##데이터형 변환 함수: as.factor(), as.integer(), as.data.frame()
z <- 0:9; z
d_chr <- as.character(z); d_chr
d <- as.integer(d_chr); d

#연산
##거듭제곱: ^ or **
10^3; 10**3
##나머지: %%
10 %% 3
##몫: %/%
10 %/% 3
##논리 연산
### 논리합: |
### 논리곱: &
### 논리부정: !
### 진위 여부: isTRUE() 

##집합 연산
### union(x, y): 합집합
### intersect(x, y): 교집합
### setdiff(x, y): 차집합
### setequal(x, y): 동일 집합 확인

##벡터 요소 간 연산
w <- c(1, 2, 3, 4)
x <- c(5, 6, 7, 8)
y <- c(3, 4)
z <- c(5, 6, 7)
##  1. 두 벡터 길이가 같으면 같은 위치의 요소 끼리 연산
w + x
##  2. 요소 길이가 배수 관계에 있을 때는 작은 쪽 벡터의 요소를 순환하며 연산
w + y
##  3. 요소 길이가 배수 관계에 있지 않을 때는 warning 발생, 재사용
###x + z: > x + z > [1] 10 12 14 13 > In x + z : 두 객체의 길이가 서로 배수관계에 있지 않습니다

#벡터 다루기
## all(): 벡터 내 모든 요소가 조건을 만족하는지 확인
x <- 10:20; x
all(x > 15)
## any(): 벡터 내 일부 요소가 조건을 만족하는지 확인
any(x > 15)
## which(): 조건을 만족하는 요소의 위치 확인
which(x>15)
## subset(): 벡터의 부분 집합 생성
subset(x, x>15)
## NA: 누락된 값, 연산 불가; NULL: 존재하지 않는 값, 무시하고 연산
x <- c(32, 1, NA, 46, 8); y <- c(32, 1, NULL, 46, 8)
mean(x); mean(y); mean(x, na.rm=T)

##벡터의 형 변환: 서로 다른 데이터 형이 들어갈 경우 강제 형 변환 발생
##               숫자 -> 문자; 정수 -> 실수
##문자형 벡터는 연산 불가("이항연산자에 수치가 아닌 인수입니다.")

# 배열: 동일한 유형의 데이터 벡터들의 구조적 모임

## 행렬: 행 개수와 열 개수라는 두 가지 속성을 추가로 갖는 배열
##      모든 요소의 데이터형 동일(서로 다른 데이터형을 다루기 위해 -> 데이터 프레임 사용)
### 행렬 생성(byrow=T: 행 우선 변경; 기본적으로 열 우선으로 행렬 생성)
matrix(data = NA, nrow = 1, ncol = 1, byrow = FALSE, dimnames = NULL)

###행렬 연산 +, -, *, %*%(행렬 곱), t(): 전치행렬, aperm(): 전치행렬, solve(): 역행렬, det(): 행렬식
###행렬 결합 rbind(): 행 단위 결합; cbind(): 열 단위 결합

## n차원 배열 생성 (dim 인수를 통해 차원을 정의)
array(data = NA, dim = length(data), dimnames = NULL)

## 배열에 사용하는 함수
### dim(): 배열의 구조, 차원의 수 확인 또는 생성
### apply(): 배열의 행 or 열 별 함수 적용

#팩터
#   범주형 데이터를 표현하는 데이터 구조
#   사전에 정해진 특정 유형으로 분류되는 데이터
#   정해진 값들을 '레벨(level)'이라 부름

##생성
factor(x, levels, labels=levels, exclude = NA, ordered = is.ordered(x), nmax = NA)
x <- factor(c(1, 2, 3, 4, 5)); x
### 순서형 팩터 생성
ordered(x, levels)

##팩터 관련 함수
nlevels(x) ###레벨의 개수 확인
levels(x) ###레벨의 목록 확인
is.factor(x) ### 팩터 여부 확인
is.ordered(x) ###순서형 팩터인지 확인

#데이터 프레임
#   행과 열의 2차원 구조를 가진 표(table) 형태의 데이터
#   행렬과 달리 여러 데이터 타입(numeric, character, factor, etc)의 vector를 column으로 가질 수 있음

##생성: data.frame()
##테이블 구조의 데이터 파일로부터 데이터 프레임 생성
##  read.table(); read.csv(); read.csv2(); read.delim(); read.delim2()
##  arguments: file-읽어 올 파일 경로와 이름; header-첫 행의 열 이름 여부;
##             sep-항목의 구분자; nrow-가져 올 행의 수(행 중간 주석이 포함된 경우 제외);
##             skip-제외할 행의 수(행 중간 주석이 포함된 경우 포함)

##데이터 프레임 서브세팅

###데이터 프레임 요소 조회
###     [행 인덱스, 열 인덱스] -> 벡터 출력
###     $변수이름, [["변수이름"]] -> 벡터 출력
###     ["변수이름"] -> 서브 데이터 프레임 출력

###컬럼(값) 변경: 조회한 셀(컬럼) 값, 데이터 형 변경
###     df_names$컬럼명 <- value

###컬럼 추가: 데이터 프레임에 새로운 열을 만들어 값 대입
###     df_names$new_col <- value

###컬럼 삭제: df_names$컬럼명 <- NULL

###여러 컬럼 선택(select): 나열한 컬럼 이름 순서대로 조회
###     df_names$[, col_names or index vector]

###여러 컬럼 제외 선택
###     열 인덱스 번호와 음수(-) 연산자 사용
###     컬럼명 사용 불가: 연산자 '-'는 문자열에는 적용 불가

###여러 행 필터(filter)
###     단순 조회: df_name[행 인덱스 벡터, ]
###     조건 필터: df_name[조건, ]

##데이터 프레임 집계
###function(df_name$컬럼명)
###apply(data, margin, fun)
###     margin: 1은 행 단위, 2는 열 단위 


##데이터 프레임 함수
###str(): 각 변수의 이름과 데이터 타입 확인
str(iris)
###attributes(): 열의 이름, 행의 이름, 클래스 확인
attributes(iris)
###dim(): 차원 수 확인
dim(iris)
###ncol(), nrow()
ncol(iris); nrow(iris)
###names(), colnames(): 열의 이름
names(iris); colnames(iris)
###rownames(), row.names(): 행의 이름 
rownames(iris); row.names(iris)
###summary(): 데이터 프레임 요약 정보
summary(iris)
###head(), tail(): 앞, 뒤 일부 데이터 프레임 추출. 행 수 지정 가능하며, 생략하면 default 6개
head(iris); tail(iris)
###attach(), detach(): 데이터 프레임 컬럼명을 변수명으로 변경, 해지
attach(iris); Species
###with(): attach() 없이 컬럼 이름을 직접 사용해 함수 적용
with(iris, Species)
###subset(): 데이터 프레임에서 일부 데이터 추출
subset(iris,iris$Petal.Length>5)
###merge(): 두 데이터 프레임 병합. 관계 데이터 베이스의 'join'
###     병합의 기준이 되는 열의 이름이 서로 다를 때, by.x, by.y 인자 사용
###     all, all.x, all.y는 병합 조건 외 모든 데이터 포함 여부
merge()

###is.data.frame(), as.data.frame: 데이터 프레임 확인 및 변환

x <- as.data.frame(iris)
x

##데이터의 파일 출력
###데이터 프레임 저장
###     write.table(x, file= "", append= FALSE, quote= TRUE,
###                 sep= " ",eol= "\n", na= "NA", dec= ".",
###                 row.names= TRUE,col.names= TRUE,
###                 qmethod=c("escape", "double"),fileEncoding= "")
###     동일한 이름 파일이 있을 때 덮어쓰기 하려면 append=FALSE (추가=TRUE)
###     각 요소에 ""가 자동으로 붙는 것을 없애려면 quite=FALSE


#리스트: (키, 값) 형태 데이터를 담는 연관 배열, 어떤 형태 데이터 객체도 저장 가능

##리스트 생성: list()

##리스트 조회
##      리스트 이름[인덱스번호] or 리스트 이름["키"] -> 리스트 반환
##      리스트 이름[[인덱스번호]] or 리스트 이름$키 -> 데이터 객체 반환

##unlist() 함수

##lapply(): 벡터, 리스트에 함수를 적용해 리스트로 결과 반환

##sapply(): 벡터 리스트에 함수를 적용해 벡터로 결과 반환