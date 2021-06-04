install.packages("plotly")
library(plotly)
library(ggplot2)

# interactive scatter plot ---------------------------------------
p <- ggplot(data=mpg, aes(x=displ, y=hwy, col=drv)) + geom_point()

p
ggplotly(p)

# interactive bar plot --------------------------------------------

p <- ggplot(data=diamonds, aes(x=cut, fill =clarity))+ geom_bar(position="dodge")
p
ggplotly(p)

#interactive time-series : dygpaph()------------------------------------------
#install.packages("dygraphs")
library(dygraphs)

e <- economics
head(e)

## 실업자수(unemploy)를 시계열 타입으로 변경
## xts: 시계열 객체 생성 함수
library(xts)
eco <- xts(e$unemploy, order.by = e$date)

head(eco)
dygraph(eco)

## 날짜 범위 선택 bar를 하단에 추가
dygraph(eco) %>% dyRangeSelector()

#여러 값 표현하기
## 저축률 : psavert

psavert <- xts(e$psavert, order.by = e$date)
##실업자수
unemploy <- xts(e$unemploy/1000, order.by = e$date)

eco2 <- cbind(psavert, unemploy)
head(eco2)

dygraph(eco2) %>% dyRangeSelector()

